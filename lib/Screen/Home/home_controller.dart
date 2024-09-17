import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/getsubjobassigned_model.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
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
  var subJobSparePart = <SubJobSparePart>[].obs;
  var subJobAssignedPage = <SubJobAssgined>[].obs;
  final BottomBarController notificationController =
      Get.put(BottomBarController());
  int currentPage = 1;
  int currentPagePM = 1;
  final mostRecentNewJob = Rx<Issues?>(null);
  final mostRecentCompleteJob = Rx<Issues?>(null);
  var pmItems = <PmModel>[].obs;
  var pmItemsPage = <PmModel>[].obs;
  RxBool isLoading = true.obs;
  final RxInt pmjobList = 0.obs;
  final RxInt pmjobListConfirmed = 0.obs;
  final RxInt pmjobListClosed = 0.obs;
  final RxInt sparePartPending = 0.obs;
  final RxInt sparePartApproved = 0.obs;
  final RxInt sparePartReject = 0.obs;
  final RxInt subjobList = 0.obs;
  final RxInt subjobListPending = 0.obs;
  final RxInt subjobListClosed = 0.obs;
  final RxInt pmCompletedList = 0.obs;
  final RxInt expandedIndex = (-2).obs;
  final RxInt expandedIndex2 = (-2).obs;
  final UserController userController = Get.put(UserController());
  var totalJobsTicket = 0.obs;
  var totalJobsPM = 0.obs;
  var totalJobs = 0.obs;
  var closedJobs = 0.obs;
  var incomingJobs = 0.obs;
  var techLevel = ''.obs;
  var techManageId = ''.obs;
  var handlerIdTech = ''.obs;
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
    totalJobsTicket = 0.obs;
    totalJobsPM = 0.obs;
    totalJobs = 0.obs;
    closedJobs = 0.obs;
    incomingJobs = 0.obs;
    overdueJobs = 0.obs;
    onProcessJobs = 0.obs;
    serviceZoneSet = <String>{}.obs;
    currentPage = 1;
    currentPagePM = 1;
    try {
      await userController.fetchData();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenResponse = prefs.getString('token_response');
      Map<String, dynamic> tokenData = json.decode(tokenResponse ?? '');
      // String? accessToken = tokenData['token'];
      handlerIdTech.value = tokenData['user']['id'].toString();
      int handlerId = tokenData['user']['id'];
      techLevel.value = tokenData['user']['tech_level'];

      await userController.fetchData();
      techManageId.value = userController.userInfo.first.id.toString();
      await fetchPMdata(handlerId);
      await fetchSubJobsdata(handlerId);
      subJobSparePart.clear();
      if (techLevel.value == '1') {
        await fetchSubJobSparePart(handlerId.toString(), 'tech');
      } else {
        await fetchSubJobSparePart(techManageId.value, 'leadtech');
      }
      pmItemsPage.clear();
      subJobAssignedPage.clear();
      await fetchPMdataPage(1, userController.userInfo.first.id.toString());
      await fetchJobdataPage(1, userController.userInfo.first.id.toString());
      isLoading.value = false;

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
        Uri.parse(getPMticketById(userController.userInfo.first.id.toString())),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<PmModel> itemList =
            responseData.map((job) => PmModel.fromJson(job)).toList();
        totalJobs.value += itemList.length;

        List<PmModel> pendingPmItems = [];
        List<PmModel> confirmPmItems = [];
        List<PmModel> closedPmItems = [];
        List<PmModel> closedPmItemsOver = [];

        for (var pm in itemList) {
          String status = stringToStatus(pm.status ?? '');
          if (pm.techStatus != '2') {
            switch (status) {
              case 'pending':
                pendingPmItems.add(pm);
                if (DateTime.parse(pm.dueDate ?? '').isBefore(DateTime.now())) {
                  closedPmItemsOver.add(pm);
                }
                break;
              case 'confirmed':
                confirmPmItems.add(pm);
                if (DateTime.parse(pm.dueDate ?? '').isBefore(DateTime.now())) {
                  closedPmItemsOver.add(pm);
                }
                break;
              case 'completed':
                closedPmItems.add(pm);
                break;
              case 'closed':
                closedPmItems.add(pm);
                break;
            }
          }
        }
        totalJobsPM.value = itemList.length;
        pmjobList.value = pendingPmItems.length;
        incomingJobs.value += pmjobList.value;
        pmjobListConfirmed.value = confirmPmItems.length;
        overdueJobs.value += closedPmItemsOver.length;
        closedJobs.value += closedPmItems.length;
        pmCompletedList.value = closedPmItems.length;
        pmItems.value = itemList;

        if (serviceZoneSet.isEmpty) {
          serviceZoneSet.add('-');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchPMdataPage(int page, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(getPmJobPage(userId, page)),
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

  Future<void> fetchJobdataPage(int page, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(getSubJobsByHandlerPage(userId, page)),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<SubJobAssgined> itemList =
            responseData.map((job) => SubJobAssgined.fromJson(job)).toList();

        subJobAssignedPage.addAll(itemList);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> loadMorePM(String userId) async {
    currentPagePM++;
    print(currentPagePM);
    await fetchPMdataPage(currentPagePM, userId);
  }

  Future<void> loadMoreJob(String userId) async {
    currentPage++;
    print(currentPage);

    await fetchJobdataPage(currentPage, userId);
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

        totalJobs.value += itemList.length;

        List<SubJobAssgined> newSubJobs = [];
        List<SubJobAssgined> pendingSubJobs = [];
        List<SubJobAssgined> completedSubJobs = [];
        List<SubJobAssgined> closedSubJobsOver = [];

        for (var subJob in itemList) {
          if (subJob.techStatus != '2') {
            switch (subJob.status) {
              case '101':
                newSubJobs.add(subJob);
                if (DateTime.parse(subJob.dueDate ?? '')
                    .isBefore(DateTime.now())) {
                  closedSubJobsOver.add(subJob);
                }
                break;
              case '102':
                pendingSubJobs.add(subJob);
                if (DateTime.parse(subJob.dueDate ?? '')
                    .isBefore(DateTime.now())) {
                  closedSubJobsOver.add(subJob);
                }
                break;
              case '103':
                completedSubJobs.add(subJob);
                break;
            }
          }
        }
        totalJobsTicket.value = itemList.length;
        subjobList.value = newSubJobs.length;
        subjobListPending.value = pendingSubJobs.length;
        onProcessJobs.value += pendingSubJobs.length;
        subjobListClosed.value = completedSubJobs.length;
        overdueJobs.value += closedSubJobsOver.length;
        closedJobs.value += completedSubJobs.length;
        subJobAssigned.value = itemList;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchSubJobSparePart(String id, String option) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(option == 'tech'
            ? getSparepartJobByHandler(id)
            : getSparepartJobById(id)),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<SubJobSparePart> itemList =
            responseData.map((job) => SubJobSparePart.fromJson(job)).toList();

        List<SubJobSparePart> pendingSparePart = [];
        List<SubJobSparePart> completedSparePart = [];
        List<SubJobSparePart> rejectedSparePart = [];
        for (var sparePart in itemList) {
          switch (sparePart.techManagerStatus) {
            case '0':
              pendingSparePart.add(sparePart);
              break;
            case '1':
              completedSparePart.add(sparePart);
              break;
            case '2':
              rejectedSparePart.add(sparePart);
              break;
          }
        }
        sparePartPending.value = pendingSparePart.length;
        sparePartApproved.value = completedSparePart.length;
        sparePartReject.value = rejectedSparePart.length;
        subJobSparePart.value = itemList;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
