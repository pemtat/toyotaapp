import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/rcode.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_result.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/wcode.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

class FillformController extends GetxController {
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  var isFormComplete = false.obs;

  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  final ProcessStaff processStaffController = Get.put(ProcessStaff());
  List<String> fieldServiceReportList = [
    'Inspection',
    'Repairing',
    'Re-repairing',
    'Comission',
    'Other',
  ];
  var fieldServiceReport = <String>[].obs;
  var detail = <String>[].obs;
  var ticketId = ''.obs;
  var jobId = ''.obs;

  void showSavedDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            saveReport();
          },
        );
      },
    );
  }

  void checkFormCompletion() {
    bool isComplete = true;

    if (fault.value.text.isEmpty ||
        errorCode.value.text.isEmpty ||
        workorderNumber.value.text.isEmpty ||
        rcodeController.rCode.isEmpty ||
        wcodeController.wCode.isEmpty ||
        rPController.repairProcedure.value.text.isEmpty ||
        rPController.causeProblem.value.text.isEmpty ||
        repairResultController.repairResult.isEmpty ||
        processStaffController.repairStaff.isEmpty) {
      isComplete = false;
    }

    isFormComplete.value = isComplete;
  }

  void fetchData(String ticketId, String jobId) async {
    this.ticketId.value = ticketId;
    this.jobId.value = jobId;
  }

  Future<void> saveReport() async {
    String? token = await getToken();
    String apiUrl = createJobReport();

    try {
      final response = await http.get(
        Uri.parse(getHighRelelationReport()),
        headers: {
          'Authorization': '$token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> highRelationData = json.decode(response.body);

        if (highRelationData.isNotEmpty) {
          var currentRelationId = highRelationData.first['relation_id'];
          var highRelation = (int.parse(currentRelationId) + 1).toString();

          final Map<String, dynamic> data = {
            'job_issue_id': '$ticketId',
            'field_report': fieldServiceReport.join(', '),
            'fault_report': fault.value.text,
            'error_code_report': errorCode.value.text,
            'order_no': workorderNumber.value.text,
            'r_code': rcodeController.rCode.join(','),
            'w_code': wcodeController.wCode.join(','),
            'produre': rPController.repairProcedure.value.text,
            'problem': rPController.causeProblem.value.text,
            'repair_result': repairResultController.repairResult.join(','),
            'process_staff': processStaffController.repairStaff.join(','),
            'relation_id': highRelation,
          };
          final List<Map<String, dynamic>> sparePartsJson =
              sparePartListController.sparePartList
                  .map((part) => part.toJson())
                  .toList();
          final Map<String, dynamic> data2 = {
            'spareparts': sparePartsJson,
            'relation_id': highRelation,
          };

          try {
            final response = await http.post(Uri.parse(apiUrl),
                headers: {
                  'Authorization': '$token',
                },
                body: jsonEncode(data));

            if (response.statusCode == 200) {
              print('Report saved successfully');
            } else {
              print('Failed to save report: ${response.body}');
            }
          } catch (e) {
            print('Error occurred while saving report: $e');
          }
          try {
            final response =
                await http.post(Uri.parse(createJobReportAdditional()),
                    headers: {
                      'Authorization': '$token',
                    },
                    body: jsonEncode(data2));

            if (response.statusCode == 200) {
              print('Sparepart Report saved successfully');
            } else {
              print('Failed to save report: ${response.body}');
            }
          } catch (e) {
            print('Error occurred while saving report: $e');
          }
        }
      }
    } catch (e) {
      print('Error occurred while saving report: $e');
    }
  }
}
