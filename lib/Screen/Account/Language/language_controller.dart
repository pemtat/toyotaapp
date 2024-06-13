import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class LanguageController extends GetxController {
  void showConfirmDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            changeLanguage();
          },
        );
      },
    );
  }

  Future<void> changeLanguage() async {}
}
