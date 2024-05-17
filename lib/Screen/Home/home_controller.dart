import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var jobList = <Home>[].obs;
  final BottomBarController notificationController =
      Get.put(BottomBarController());
  final RxInt expandedIndex = (-1).obs;

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
          date: '12 March 2024',
          location: 'Bangkok Thailand',
          status: 'New'),
      Home(
          jobid: '0002',
          detail: 'Replace Spare Part',
          ticketid: '234595',
          problem: 'Car fixing.',
          date: '16 March 2024',
          location: 'Bangkok Thailand',
          status: 'New'),
      Home(
          jobid: '0003',
          detail: 'Replace Spare Part',
          ticketid: '234595',
          problem: 'Car fixing.',
          date: '16 March 2024',
          location: 'Bangkok Thailand',
          status: 'Completed'),
    ]);
  }

  void notification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notification', 'yes');
    notificationController.checkNotification();
  }
}
