import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Service/api.dart';
import 'dart:convert';

class HomeController extends GetxController {
  var jobList = <Home>[].obs;
  final RxInt jobListLength = 0.obs;
  final RxInt jobListCloseLength = 0.obs;
  final BottomBarController notificationController =
      Get.put(BottomBarController());
  final mostRecentNewJob = Rx<Home?>(null);
  final mostRecentCompleteJob = Rx<Home?>(null);
  var pmItems = <PmModel>[].obs;
  final RxInt pmjobList = 0.obs;
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
        jobList.assignAll(issues.map((data) => Home.fromJson(data)).toList());
      }
      final response2 = await http.get(
        Uri.parse(getAllJob),
        headers: {
          'Authorization': '$accessToken',
        },
      );
      if (response2.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response2.body);
        List<dynamic> issues = responseData['issues'];
        List<dynamic> filteredIssues = issues.where((issue) {
          return issue.containsKey('handler') &&
              issue['handler'] is Map<String, dynamic> &&
              issue['handler']['id'] == handlerId;
        }).toList();
        jobList.assignAll(
            filteredIssues.map((data) => Home.fromJson(data)).toList());
        findMostRecentNewJob();
        findMostRecentCompleteJob();
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void findMostRecentNewJob() {
    var assignedJobs = jobList.where((job) => job.status != 'closed').toList();
    if (assignedJobs.isNotEmpty) {
      mostRecentNewJob.value =
          assignedJobs.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    }
    jobListLength.value = assignedJobs.length;
  }

  void findMostRecentCompleteJob() {
    var closeJobs = jobList.where((job) => job.status == 'closed').toList();
    if (closeJobs.isNotEmpty) {
      mostRecentCompleteJob.value =
          closeJobs.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
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
        pmItems.value = itemList;
        pmjobList.value = pmItems.length;
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
