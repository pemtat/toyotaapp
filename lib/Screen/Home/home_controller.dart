import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Service/api.dart';
import 'dart:convert';

class HomeController extends GetxController {
  var jobList = <Issues>[].obs;
  final RxInt jobListLength = 0.obs;
  final RxInt jobListCloseLength = 0.obs;
  final BottomBarController notificationController =
      Get.put(BottomBarController());
  final mostRecentNewJob = Rx<Issues?>(null);
  final mostRecentCompleteJob = Rx<Issues?>(null);
  var pmItems = <PmModel>[].obs;
  final RxInt pmjobList = 0.obs;
  final RxInt pmjobListClosed = 0.obs;
  final RxInt pmCompletedList = 0.obs;
  final RxInt expandedIndex = (-2).obs;
  final RxInt expandedIndex2 = (-2).obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataFromAssignJob();
  }

  Future<void> fetchDataFromAssignJob() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenResponse = prefs.getString('token_response');
      Map<String, dynamic> tokenData = json.decode(tokenResponse ?? '');
      String? accessToken = tokenData['token'];
      int handlerId = tokenData['user']['id'];
      fetchPMdata(handlerId);
      final response = await http.get(
        Uri.parse(getAssignJob),
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> issues = responseData['issues'];
        jobList.assignAll(issues.map((data) => Issues.fromJson(data)).toList());
      }

      fetchAndProcessJobs(handlerId, accessToken ?? '');

      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> fetchAndProcessJobs(int handlerId, String accessToken) async {
    try {
      List<Future<void>> fetchTasks = [];

      for (int page = 1; page <= 10; page++) {
        fetchTasks.add(fetchAndProcessJobPage(page, handlerId, accessToken));
      }

      await Future.wait(fetchTasks);
      findMostRecentNewJob();
      findMostRecentCompleteJob();
    } catch (e) {
      print('Exception occurred during fetching and processing jobs: $e');
    }
  }

  Future<void> fetchAndProcessJobPage(
      int page, int handlerId, String accessToken) async {
    try {
      final response2 = await http.get(
        Uri.parse(getAllJobs(page)),
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response2.statusCode == 200) {
        try {
          Map<String, dynamic> responseData = json.decode(response2.body);
          List<dynamic> issues = responseData['issues'];
          List<dynamic> filteredIssues = issues.where((issue) {
            return issue.containsKey('handler') &&
                issue['handler'].containsKey('id') &&
                issue['handler'] is Map<String, dynamic> &&
                issue['handler']['id'] == handlerId;
          }).toList();

          jobList.addAll(
              filteredIssues.map((data) => Issues.fromJson(data)).toList());
        } catch (e) {
          print('Exception occurred during JSON parsing or filtering: $e');
        }
      } else {
        print('Failed to fetch jobs for page $page: ${response2.statusCode}');
      }
    } catch (e) {
      print('Exception occurred during HTTP request for page $page: $e');
    }
  }

  void findMostRecentNewJob() {
    var assignedJobs =
        jobList.where((job) => job.status?.name != 'closed').toList();
    if (assignedJobs.isNotEmpty) {
      mostRecentNewJob.value = assignedJobs
          .reduce((a, b) => a.createdAt!.compareTo(b.createdAt!) > 0 ? a : b);
    }
    jobListLength.value = assignedJobs.length;
  }

  void findMostRecentCompleteJob() {
    var closeJobs =
        jobList.where((job) => job.status?.name == 'closed').toList();
    if (closeJobs.isNotEmpty) {
      mostRecentCompleteJob.value = closeJobs
          .reduce((a, b) => a.createdAt!.compareTo(b.createdAt!) > 0 ? a : b);
    }
    jobListCloseLength.value = closeJobs.length;
  }

  void notification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notification', 'yes');
    notificationController.checkNotification();
  }

  //PM

  Future<void> fetchPMdata(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(getPMticketById('B182')),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<PmModel> itemList =
            responseData.map((job) => PmModel.fromJson(job)).toList();
        itemList.sort((a, b) => a.pmPlan!.compareTo(b.pmPlan!));
        List<PmModel> closedPmItems =
            itemList.where((pm) => pm.pmStatus == 'closed').toList();

        pmItems.value = itemList;
        pmjobList.value = pmItems.length;
        pmjobListClosed.value = closedPmItems.length;
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
