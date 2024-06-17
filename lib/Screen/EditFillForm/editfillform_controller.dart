import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';

class EditFillformController extends GetxController {
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  final reportList = <RepairReportModel>[].obs;
  final additionalReportList = <RepairReportModel>[].obs;
  List<String> fieldServiceReportList = [
    'Inspection',
    'Repairing',
    'Re-repairing',
    'Comission',
    'Other',
  ];

  var fieldServiceReport = <String>[].obs;
  var detail = <String>[].obs;

  void fetchForm(String reportId) async {
    String? token = await getToken();
    await fetchReportData(
        reportId, token ?? '', reportList, additionalReportList);

    if (reportList.isNotEmpty) {
      fault.value.text = reportList.first.faultReport ?? '';
      errorCode.value.text = reportList.first.errorCodeReport ?? '';
      workorderNumber.value.text = reportList.first.orderNo ?? '';
    }
  }
}
