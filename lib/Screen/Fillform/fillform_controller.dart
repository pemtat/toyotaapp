import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/rcode.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_result.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/wcode.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

class FillformController extends GetxController {
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  var isFormComplete = false.obs;
  final TextEditingController signatureController = TextEditingController();

  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  final ProcessStaff processStaffController = Get.put(ProcessStaff());
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
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
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
  final GlobalKey<SfSignaturePadState> signature = GlobalKey();
  var saveCompletedtime = ''.obs;
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

  Future<void> saveReport(BuildContext context) async {
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
          saveCurrentDateTime(saveCompletedtime);
          final Map<String, dynamic> data = {
            'job_issue_id': '$jobId',
            'field_report': fieldServiceReport.join(', '),
            'fault_report': fault.value.text,
            'error_code_report': errorCode.value.text,
            'order_no': workorderNumber.value.text,
            'r_code': rcodeController.rCode.join(','),
            'w_code': wcodeController.wCode.join('%'),
            'produre': rPController.repairProcedureList.first.repairProcedure,
            'problem': rPController.repairProcedureList.first.causeProblem,
            'repair_result': repairResultController.repairResult.join(','),
            'process_staff': processStaffController.repairStaff.join(','),
            'relation_id': highRelation,
            'bugid': ticketId.value
          };
          List<SparePartModel> allSpareParts =
              List.from(sparePartListController.sparePartList);
          allSpareParts.addAll(additSparePartListController.additSparePartList);
          if (sparePartListController.sparePartList.isEmpty) {
            final SparePartModel defaultSparePart = SparePartModel(
              relationId: highRelation,
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
              relationId: highRelation,
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
            for (var sparePart in allSpareParts) {
              final sparePartData = {
                ...sparePart.toJson(),
                'relation_id': highRelation,
              };

              try {
                final response =
                    await http.post(Uri.parse(createJobReportAdditional()),
                        headers: {
                          'Authorization': '$token',
                          'Content-Type': 'application/json',
                        },
                        body: jsonEncode(sparePartData));

                if (response.statusCode == 201) {
                  print('Sparepart saved successfully');
                } else {}
              } catch (e) {
                print('Error occurred while saving sparepart: $e');
              }
            }
          }

          try {
            final response = await http.post(Uri.parse(apiUrl),
                headers: {
                  'Authorization': '$token',
                  'Content-Type': 'application/json',
                },
                body: jsonEncode(data));

            if (response.statusCode == 201) {
              jobDetailController.fetchData(
                  ticketId.toString(), jobId.toString());
            } else {
              print('Failed to save report: ${response.statusCode}');
            }
          } catch (e) {}
        }
      }
    } catch (e) {
      print('Error occurred while saving report: $e');
    }
  }
}
