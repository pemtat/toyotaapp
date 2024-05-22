import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Screen/Login/login_view.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class AccountController extends GetxController {
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
    Get.offAll(() => LoginView());
  }
}
