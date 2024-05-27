import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/Login/login_view.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class AccountController extends GetxController {
  final BottomBarController controller = Get.put(BottomBarController());
  final HomeController jobController = Get.put(HomeController());

  void showLogoutDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            logout();
          },
        );
      },
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', "");
    prefs.setString('token_response', "");
    prefs.setString('token', "");
    controller.currentIndex.value = 0;
    jobController.mostRecentNewJob.value = null;
    jobController.mostRecentCompleteJob.value = null;
    Get.offAll(() => LoginView());
  }
}
