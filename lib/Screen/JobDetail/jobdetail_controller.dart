import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class JobdetailController extends GetxController {
  final notes = TextEditingController().obs;

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert();
      },
    );
  }
}
