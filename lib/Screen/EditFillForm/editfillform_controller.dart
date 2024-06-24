import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/repair_procedure.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/rcode.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_result.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/wcode.dart';

class EditFillformController extends GetxController {
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  final reportList = <RepairReportModel>[].obs;
  final additionalReportList = <RepairReportModel>[].obs;
  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  final RepairStaff repairStaffController = Get.put(RepairStaff());
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
      var reportData = reportList.first;
      fault.value.text = reportData.faultReport ?? '';
      errorCode.value.text = reportData.errorCodeReport ?? '';
      workorderNumber.value.text = reportData.orderNo ?? '';
      fieldServiceReport.add(reportData.fieldReport ?? '');
      rcodeController.rCode.add(reportData.rCode ?? '');

      wcodeController.wCode.add(reportData.wCode ?? '');
      rPController.repairProcedureList.add(RepairProcedureModel(
        repairProcedure: reportData.produre ?? '',
        causeProblem: reportData.problem ?? '',
      ));

      if (reportData.quantity != 0)
        // ignore: curly_braces_in_flow_control_structures
        for (var reportDataList in reportList + additionalReportList) {
          if (reportDataList.additional == false &&
              reportDataList.quantity != '0') {
            sparePartListController.sparePartList.add(SparePartModel(
                relationId: reportData.relationId,
                cCodePage: reportData.cCode ?? '1',
                partNumber: reportData.partNumber ?? '',
                partDetails: reportData.description ?? '',
                quantity: int.parse(reportData.quantity ?? ''),
                changeNow: reportData.changeNow ?? '',
                changeOnPM: reportData.changeOnPm ?? '',
                additional: 0));
          } else if (reportDataList.additional == true &&
              reportDataList.quantity != '0') {
            additSparePartListController.additSparePartList.add(SparePartModel(
                relationId: reportData.relationId,
                cCodePage: reportData.cCode ?? '1',
                partNumber: reportData.partNumber ?? '',
                partDetails: reportData.description ?? '',
                quantity: int.parse(reportData.quantity ?? ''),
                changeNow: reportData.changeNow ?? '',
                changeOnPM: reportData.changeOnPm ?? '',
                additional: 1));
          }
        }

      repairResultController.repairResult.add(reportData.repairResult ?? '');
      repairStaffController.repairStaff.add(reportData.processStaff ?? '');
    }
  }
}
