import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class FillformController2 extends GetxController {
  void showSaveDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: completeJob,
        );
      },
    );
  }

  void completeJob() {}
}
