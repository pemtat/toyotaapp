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
  var serviceItems = <ServiceItem>[].obs;

  final RxInt expandedIndex = (-2).obs;
  final RxInt expandedIndex2 = (-2).obs;
  @override
  void onInit() {
    super.onInit();
    fetchDataFromAssignJob();
    addInitialServiceItems();
  }

  Future<void> fetchDataFromAssignJob() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenResponse = prefs.getString('token_response');
      Map<String, dynamic> tokenData = json.decode(tokenResponse ?? '');
      String? accessToken = tokenData['token'];
      int handlerId = tokenData['user']['id'];

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
  void addServiceItem(ServiceItem item) {
    serviceItems.add(item);
  }

  List<ServiceItem> getServiceItems() {
    return serviceItems;
  }

  ServiceItem? getServiceItemByNo(String serviceItemNo) {
    return serviceItems
        .firstWhereOrNull((item) => item.serviceItemNo == serviceItemNo);
  }

  void addInitialServiceItems() {
    addServiceItem(ServiceItem(
      jobId: 1,
      serviceItemNo: 'SV00-00214',
      itemNo: 'UBRRM12',
      serialNo: '415822',
      status: 'assigned',
      pmPlan: DateTime.parse('2024-01-04'),
      actual: DateTime.parse('2024-04-29'),
      description: 'PM Support 1/4.',
      customerNo: 'CD-0582S001',
      customerName: 'บริษัท รอยัล ปอร์ซเลน  จำกัด (มหาชน)',
      shipToCode: '',
      resourceNo: 'B033',
      resourceName: 'จรัญ สุตนพัฒน์',
      serviceZoneCode: 'A',
    ));
    addServiceItem(ServiceItem(
      jobId: 2,
      serviceItemNo: 'SV00-00214',
      itemNo: 'UBRRM12',
      serialNo: '415822',
      status: 'assigned',
      pmPlan: DateTime.parse('2024-01-07'),
      actual: DateTime.parse('2024-04-01'),
      description: 'PM Support 2/4.',
      customerNo: 'CD-0582S001',
      customerName: 'บริษัท รอยัล ปอร์ซเลน จำกัด (มหาชน)',
      shipToCode: '',
      resourceNo: 'B033',
      resourceName: 'จรัญ สุตนพัฒน์',
      serviceZoneCode: 'A',
    ));
    addServiceItem(ServiceItem(
      jobId: 3,
      serviceItemNo: 'SV00-00214',
      itemNo: 'UBRRM12',
      serialNo: '415822',
      status: 'assigned',
      pmPlan: DateTime.parse('2024-01-10'),
      actual: DateTime.parse('2024-04-01'),
      description: 'PM Support 3/4.',
      customerNo: 'CD-0582S001',
      customerName: 'บริษัท รอยัล ปอร์ซเลน จำกัด (มหาชน)',
      shipToCode: '',
      resourceNo: 'B033',
      resourceName: 'จรัญ สุตนพัฒน์',
      serviceZoneCode: 'A',
    ));
    addServiceItem(ServiceItem(
      jobId: 4,
      serviceItemNo: 'SV00-00214',
      itemNo: 'UBRRM12',
      serialNo: '415822',
      status: 'assigned',
      pmPlan: DateTime.parse('2025-01-01'),
      actual: DateTime.parse('2024-04-01'),
      description: 'PM Support 4/4.',
      customerNo: 'CD-0582S001',
      customerName: 'บริษัท รอยัล ปอร์ซเลน จำกัด (มหาชน)',
      shipToCode: '',
      resourceNo: 'B033',
      resourceName: 'จรัญ สุตนพัฒน์',
      serviceZoneCode: 'A',
    ));
    addServiceItem(ServiceItem(
      jobId: 5,
      serviceItemNo: 'SV00-00236',
      itemNo: 'UBRRM1',
      serialNo: '360924',
      status: 'assigned',
      pmPlan: DateTime.parse('2025-01-04'),
      actual: DateTime.parse('2024-04-01'),
      description: 'PM Support 1/4.',
      customerNo: 'CD-0582S001',
      customerName: 'บริษัท รอยัล ปอร์ซเลน จำกัด (มหาชน)',
      shipToCode: '',
      resourceNo: 'B033',
      resourceName: 'จรัญ สุตนพัฒน์',
      serviceZoneCode: 'A',
    ));
    serviceItems.sort((b, a) => b.pmPlan.compareTo(a.pmPlan));
  }
}
