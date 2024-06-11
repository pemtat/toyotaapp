import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FillformController extends GetxController {
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  List<String> fieldServiceReportList = [
    'Inspection',
    'Repairing',
    'Re-repairing',
    'Comission',
    'Other',
  ];

  var fieldServiceReport = <String>[].obs;
  var detail = <String>[].obs;
}
