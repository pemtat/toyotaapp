import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/Login/login_view.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class AccountController extends GetxController {
  final BottomBarController controller = Get.put(BottomBarController());
  final HomeController jobController = Get.put(HomeController());
  final UserController userController = Get.put(UserController());
  @override
  void onInit() {
    super.onInit();
    userController.fetchData();
  }

  void showLogoutDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          rightColor: red1,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            logout();
          },
        );
      },
    );
  }

  void showDeleteDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            deleteAccount();
          },
          rightColor: red1,
        );
      },
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', "");
    prefs.setString('token_response', "");
    prefs.setString('token', "");
    prefs.setString('verify', "");
    controller.currentIndex.value = 0;
    jobController.mostRecentNewJob.value = null;
    jobController.mostRecentCompleteJob.value = null;
    Get.offAll(() => LoginView());
  }

  Future<void> deleteAccount() async {}
}
