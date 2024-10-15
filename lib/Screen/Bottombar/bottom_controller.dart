import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBarController extends GetxController {
  var currentIndex = 0.obs;
  var hasNotification = false.obs;

  Future<bool> checkNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notification = prefs.getString('notification');
    if (currentIndex.value != 4) {
      hasNotification.value = true;
      return notification == 'yes';
    }
    return notification == 'no';
  }

  Future<void> clearNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notification');
    hasNotification.value = false;
  }
}
