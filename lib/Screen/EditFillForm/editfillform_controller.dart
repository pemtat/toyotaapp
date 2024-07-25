import 'dart:convert';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
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
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

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
  final TextEditingController signatureController = TextEditingController();
  var signaturePad = ''.obs;
  final GlobalKey<SfSignaturePadState> signature = GlobalKey();
  var saveCompletedtime = ''.obs;
  var fieldServiceReport = <String>[].obs;
  var detail = <String>[].obs;
  var isSignatureEmpty = true.obs;
  var ticketId = ''.obs;
  var jobId = ''.obs;
  var relationId = ''.obs;

  void fetchForm(String reportId, String ticketId, String jobId) async {
    String? token = await getToken();
    this.ticketId.value = ticketId;
    this.jobId.value = jobId;

    await fetchReportData(
        reportId, token ?? '', reportList, additionalReportList);

    if (reportList.isNotEmpty) {
      var reportData = reportList.first;
      relationId.value = reportData.relationId ?? '';
      fault.value.text = reportData.faultReport ?? '';
      errorCode.value.text = reportData.errorCodeReport ?? '';
      workorderNumber.value.text = reportData.orderNo ?? '';

      fieldServiceReport.add(reportData.fieldReport ?? '');
      List<String> newList = reportData.rCode!.split(',');

      newList = reportData.repairResult!.split(',');
      repairResultController.repairResultChoose.addAll(newList);

      newList = reportData.processStaff!.split(',');
      repairStaffController.repairStaffChoose.addAll(newList);
      if (reportData.rCode!.isNotEmpty) {
        List<String> rCodeList = reportData.rCode!.split(',');

        for (String rCode in rCodeList) {
          rcodeController.rCode.add(rCode.trim());
        }
      }
      if (reportData.wCode!.isNotEmpty) {
        List<String> wCodeList = reportData.wCode!.split('%');

        for (String wCode in wCodeList) {
          wcodeController.wCode.add(wCode.trim());
        }
      }
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
      if (reportData.repairResult!.isNotEmpty) {
        repairResultController.repairResult.add(reportData.repairResult ?? '');
      }
      if (reportData.processStaff!.isNotEmpty) {
        repairStaffController.repairStaff.add(reportData.processStaff ?? '');
      }
      signatureController.value =
          TextEditingValue(text: reportData.signature ?? '');
    }
  }

  void clearSignature() {
    isSignatureEmpty.value = true;
    signature.currentState!.clear();
  }

  Future<void> saveSignature() async {
    if (signature.currentState != null) {
      try {
        final data = await signature.currentState!.toImage(pixelRatio: 3.0);
        final byteData = await data.toByteData(format: ImageByteFormat.png);
        String base64String = base64Encode(byteData!.buffer.asUint8List());
        signaturePad.value = base64String;
      } catch (e) {
        print('Error saving signature: $e');
      }
    } else {
      print('Signature pad not initialized');
    }
  }

  void showSavedDialog(
      BuildContext context, String title, String left, String right) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          rightColor: red1,
          onRightButtonPressed: () {
            saveReport(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    try {
      if (relationId.value != '') {
        saveCurrentDateTime(saveCompletedtime);
        final Map<String, dynamic> data = {
          'field_report': fieldServiceReport.first,
          'fault_report': fault.value.text,
          'error_code_report': errorCode.value.text,
          'order_no': workorderNumber.value.text,
          'r_code': rcodeController.rCode.join(','),
          'w_code': wcodeController.wCode.join('%'),
          'produre': rPController.repairProcedureList.first.repairProcedure,
          'problem': rPController.repairProcedureList.first.causeProblem,
          'repair_result': repairResultController.repairResult.join(','),
          'process_staff': repairStaffController.repairStaff.join(','),
          'relation_id': relationId.value,
          'bugid': ticketId.value
        };
        List<SparePartModel> allSpareParts =
            List.from(sparePartListController.sparePartList);
        allSpareParts.addAll(additSparePartListController.additSparePartList);
        if (sparePartListController.sparePartList.isEmpty) {
          final SparePartModel defaultSparePart = SparePartModel(
            cCodePage: "-",
            partNumber: "-",
            partDetails: "-",
            quantity: 0,
            changeNow: "-",
            changeOnPM: "-",
            additional: 0,
          );

          allSpareParts.add(defaultSparePart);
        }
        if (additSparePartListController.additSparePartList.isEmpty) {
          final SparePartModel defaultSparePart = SparePartModel(
            cCodePage: "-",
            partNumber: "-",
            partDetails: "-",
            quantity: 0,
            changeNow: "-",
            changeOnPM: "-",
            additional: 1,
          );

          allSpareParts.add(defaultSparePart);
        }

        if (allSpareParts.isNotEmpty) {
          final body = {
            'relation_id': relationId.value.toString(),
            'sparepart':
                allSpareParts.map((sparePart) => sparePart.toJson()).toList(),
          };
          try {
            final response = await http.post(Uri.parse(updateSparepart()),
                headers: {
                  'Authorization': '$token',
                  'Content-Type': 'application/json',
                },
                body: jsonEncode(body));

            if (response.statusCode == 200) {
              print('Sparepart Updated successfully');
            } else {
              print('Failed to save sparepart: ${response.body}');
            }
          } catch (e) {
            print('Error occurred while saving sparepart: $e');
          }
        }

        try {
          final response =
              await http.put(Uri.parse(updateReportById(jobId.value)),
                  headers: {
                    'Authorization': '$token',
                    'Content-Type': 'application/json',
                  },
                  body: jsonEncode(data));

          if (response.statusCode == 200) {
            print('Report updated successfully');
            Fluttertoast.showToast(
              msg: "กำลังบันทึกข้อมูล...",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              fontSize: 12.0,
            );
            jobDetailController.fetchData(
                ticketId.toString(), jobId.toString());
            Fluttertoast.showToast(
              msg: "บันทึกข้อมูลสำเร็จ",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              fontSize: 12.0,
            );
          } else {
            print('Failed to save report: ${response.statusCode}');
          }
        } catch (e) {
          print('Error occurred while saving report: $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
