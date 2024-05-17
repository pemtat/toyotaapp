import 'package:toyotamobile/Calender/calender_controller.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';
import 'package:toyotamobile/Screen/Home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBarController extends GetxController {
  var currentIndex = 0.obs;
  var hasNotification = false.obs;

  Future<void> handleTap(int index) async {
    switch (index) {
      case 0:
        Get.offAll(() => HomeView());
        break;
      case 3:
        Get.offAll(() => NotificationView());
        await clearNotification();
        break;
      case 2:
        Get.offAll(() => CalenderView());
        break;
    }
    currentIndex.value = index;
  }

  Future<bool> checkNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notification = prefs.getString('notification');
    hasNotification.value = true;
    return notification == 'yes';
  }

  Future<void> clearNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notification');
  }
}
