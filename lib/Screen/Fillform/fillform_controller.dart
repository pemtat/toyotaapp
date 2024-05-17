import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FillformController extends GetxController {
  var fieldServiceReport = <String>[].obs;
  var detail = <String>[].obs;
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  void fieldService(String label) {
    if (fieldServiceReport.contains(label)) {
      fieldServiceReport.remove(label);
    } else {
      fieldServiceReport.add(label);
    }
  }

  TextEditingController getTextFieldController(String text) {
    switch (text) {
      case 'Fault':
        return fault.value;
      case 'Error Code':
        return errorCode.value;
      case 'Work Order Number(Order No.)':
        return workorderNumber.value;
      default:
        throw Exception('Invalid text');
    }
  }
}
