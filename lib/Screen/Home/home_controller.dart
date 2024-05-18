import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var jobList = <Home>[].obs;
  final BottomBarController notificationController =
      Get.put(BottomBarController());
  final RxInt expandedIndex = (-1).obs;
  var mostRecentNewJob = Rx<Home?>(null);
  var mostRecentCompleteJob = Rx<Home?>(null);

  @override
  void onInit() {
    super.onInit();
    jobList.assignAll([
      Home(
          jobid: '0001',
          detail: 'Investigate machine',
          ticketid: '123456',
          problem:
              'Machine doesn’t work at all. Petrol is leaking from the machine.',
          date: DateTime.parse('2024-03-13T14:30:00'),
          location: 'Bangkok Thailand',
          status: 'New'),
      Home(
          jobid: '0002',
          detail: 'Replace Spare Part',
          ticketid: '234595',
          problem: 'Car fixing.',
          date: DateTime.parse('2024-03-12T14:30:00'),
          location: 'Bangkok Thailand',
          status: 'New'),
      Home(
          jobid: '0003',
          detail: 'Replace Spare Part',
          ticketid: '234595',
          problem: 'Car fixing.',
          date: DateTime.parse('2024-03-12T14:30:00'),
          location: 'Bangkok Thailand',
          status: 'Completed'),
    ]);
    _findMostRecentNewJob();
    _findMostRecentCompleteJob();
  }

  void _findMostRecentNewJob() {
    var newJobs = jobList.where((job) => job.status == 'New').toList();
    if (newJobs.isNotEmpty) {
      mostRecentNewJob.value =
          newJobs.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    }
  }

  void _findMostRecentCompleteJob() {
    var newJobs = jobList.where((job) => job.status == 'Completed').toList();
    if (newJobs.isNotEmpty) {
      mostRecentCompleteJob.value =
          newJobs.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    }
  }

  void notification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notification', 'yes');
    notificationController.checkNotification();
  }
}
