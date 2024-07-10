import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/getsubjobassigned_model.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart' as ticket;
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'dart:convert';

class HomeController extends GetxController {
  var jobList = <Issues>[].obs;
  var userInfo = <UserById>[].obs;
  var ticketJobList = <Issues>[].obs;
  var issueData = [].obs;
  var userData = [].obs;
  final RxInt jobListLength = 0.obs;
  final RxInt jobListCloseLength = 0.obs;
  var customerUserInfo = <CustomerById>[].obs;
  var subJobAssignedList = <SubJobAssgined>[].obs;
  var subJobAssigned = <SubJobAssgined>[].obs;
  final BottomBarController notificationController =
      Get.put(BottomBarController());
  int currentPage = 1; // Initial page
  final mostRecentNewJob = Rx<Issues?>(null);
  final mostRecentCompleteJob = Rx<Issues?>(null);
  var pmItems = <PmModel>[].obs;
  var pmItemsPage = <PmModel>[].obs;
  RxBool isLoading = true.obs;
  final RxInt pmjobList = 0.obs;
  final RxInt pmjobListConfirmed = 0.obs;
  final RxInt pmjobListClosed = 0.obs;
  final RxInt subjobList = 0.obs;
  final RxInt subjobListPending = 0.obs;
  final RxInt subjobListClosed = 0.obs;
  final RxInt pmCompletedList = 0.obs;
  final RxInt expandedIndex = (-2).obs;
  final RxInt expandedIndex2 = (-2).obs;
  final UserController userController = Get.put(UserController());
  var totalJobs = 0.obs;
  var closedJobs = 0.obs;
  var incomingJobs = 0.obs;
  var overdueJobs = 0.obs;
  var onProcessJobs = 0.obs;
  var serviceZoneSet = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataFromAssignJob();
  }

  Future<void> fetchDataFromAssignJob() async {
    isLoading.value = true;
    totalJobs = 0.obs;
    closedJobs = 0.obs;
    incomingJobs = 0.obs;
    overdueJobs = 0.obs;
    onProcessJobs = 0.obs;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenResponse = prefs.getString('token_response');
      Map<String, dynamic> tokenData = json.decode(tokenResponse ?? '');
      // String? accessToken = tokenData['token'];
      int handlerId = tokenData['user']['id'];
      await userController.fetchData();
      await fetchPMdata(handlerId);
      await fetchSubJobsdata(handlerId);
      // final response = await http.get(
      //   Uri.parse(getAssignJob),
      //   headers: {
      //     'Authorization': '$accessToken',
      //   },
      // );

      // if (response.statusCode == 200) {
      //   Map<String, dynamic> responseData = json.decode(response.body);
      //   List<dynamic> issues = responseData['issues'];
      //   jobList.assignAll(issues.map((data) => Issues.fromJson(data)).toList());
      // }

      // await fetchAndProcessJobs(handlerId, accessToken ?? '');

      // ignore: empty_catches
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
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
                issue['handler']['id'] == handlerId &&
                issue['status']['name'] == 'closed';
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
        Uri.parse(getPMticketById(userController.userInfo.first.resourceNo)),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<PmModel> itemList =
            responseData.map((job) => PmModel.fromJson(job)).toList();
        totalJobs.value = totalJobs.value + itemList.length;
        // itemList.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
        List<PmModel> pendingPmItems = itemList
            .where((pm) => stringToStatus(pm.status ?? '') == 'pending')
            .toList();
        pmjobList.value = pendingPmItems.length;
        incomingJobs.value = incomingJobs.value + pmjobList.value;
        List<PmModel> confirmPmItems = itemList
            .where((pm) => stringToStatus(pm.status ?? '') == 'confirmed')
            .toList();
        pmjobListConfirmed.value = confirmPmItems.length;
        List<PmModel> closedPmItems = itemList
            .where((pm) => stringToStatus(pm.status ?? '') == 'closed')
            .toList();
        serviceZoneSet.addAll(
          itemList
              .where((pm) => pm.serviceZoneCode != null)
              .map((pm) => pm.serviceZoneCode!)
              .toSet(),
        );

        closedJobs.value = closedJobs.value + closedPmItems.length;
        overdueJobs.value = overdueJobs.value + closedPmItems.length;
        pmCompletedList.value = closedPmItems.length;
        pmItems.value = itemList;
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchPMdataPage(int page) async {
    await userController.fetchData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(getPmJobPage(userController.userInfo.first.resourceNo, page)),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<PmModel> itemList =
            responseData.map((job) => PmModel.fromJson(job)).toList();

        pmItemsPage.addAll(itemList);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> loadMore() async {
    currentPage++;
    await fetchPMdataPage(currentPage);
  }

  Future<void> fetchTicketJobs(String id) async {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(getTicketbyId(id.toString())),
      headers: {
        'Authorization': '$token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ticket.TicketByIdModel ticketModel =
          ticket.TicketByIdModel.fromJson(data);
      List<ticket.Issues>? issuesList = ticketModel.issues;
      issuesList!.map((issue) {}).toList();
      issueData.addAll(issuesList);
    } else {}
  }

  //Subjobs
  Future<void> fetchSubJobsdata(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(getSubJobsByHandler(id.toString())),
        headers: {
          'Authorization': '$token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<SubJobAssgined> itemList =
            responseData.map((job) => SubJobAssgined.fromJson(job)).toList();
        totalJobs.value = totalJobs.value + itemList.length;
        List<SubJobAssgined> newSubJobs =
            itemList.where((subJob) => subJob.status == '101').toList();
        subjobList.value = newSubJobs.length;
        List<SubJobAssgined> pendingSubJobs =
            itemList.where((subJob) => subJob.status == '102').toList();
        subjobListPending.value = pendingSubJobs.length;
        onProcessJobs.value = onProcessJobs.value + pendingSubJobs.length;
        List<SubJobAssgined> completedSubJobs =
            itemList.where((subJob) => subJob.status == '103').toList();
        subjobListClosed.value = completedSubJobs.length;
        overdueJobs.value = overdueJobs.value + completedSubJobs.length;

        // itemList.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
        // List<SubJobAssgined> closedSubJob = itemList
        //     .where((subJob) => stringToStatus(subJob.status ?? '') == 'closed')
        //     .toList();
        closedJobs.value = closedJobs.value + completedSubJobs.length;

        // Set<String> uniqueBugIds = {};
        // List<String> allIds = [];
        // List<SubJobAssgined> filteredItemList = [];

        // for (var subJob in itemList) {
        //   if (!uniqueBugIds.contains(subJob.bugId)) {
        //     uniqueBugIds.add(subJob.bugId ?? '');
        //     allIds.add(subJob.id ?? '');
        //     filteredItemList.add(subJob);
        //     await fetchTicketJobs(subJob.bugId ?? '');
        //   }
        // }

        subJobAssigned.value = itemList;
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
