import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/repair_procedure.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/rcode.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_result.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/wcode.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class FillformController extends GetxController {
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  final customerName = TextEditingController().obs;
  final department = TextEditingController().obs;
  final contactedName = TextEditingController().obs;
  final product = TextEditingController().obs;
  final model = TextEditingController().obs;
  final serialNo = TextEditingController().obs;
  final operationHour = TextEditingController().obs;
  final mastType = TextEditingController().obs;
  final lifeHeight = TextEditingController().obs;
  final customerFleetNo = TextEditingController().obs;
  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  var userByZone = <UsersZone>[].obs;
  var isFormComplete = false.obs;
  final TextEditingController signatureController = TextEditingController();
  var selectedUser = ''.obs;

  var usersList = <UsersZone>[].obs;
  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  final ProcessStaff processStaffController = Get.put(ProcessStaff());
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
  final UserController userController = Get.put(UserController());
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
        repairResultController.maintenanceList.isEmpty ||
        processStaffController.repairStaff.isEmpty) {
      isComplete = false;
    }

    isFormComplete.value = isComplete;
  }

  void fetchData(String ticketId, String jobId) async {
    String? token = await getToken();
    this.ticketId.value = ticketId;
    this.jobId.value = jobId;
    await userController.fetchData();
    await fetchUserByZone(
      userController.userInfo.first.zone,
      token ?? '',
      userByZone,
    );
    if (jobDetailController.customerInfo.isNotEmpty) {
      customerName.value.text =
          jobDetailController.customerInfo.first.customerName ?? '';
    }
    if (jobDetailController.userData.isNotEmpty) {
      contactedName.value.text =
          jobDetailController.userData.first.users!.first.realName ?? '';
    }
    if (jobDetailController.warrantyInfo.isNotEmpty) {
      product.value.text =
          jobDetailController.warrantyInfo.first.nametruck ?? '';
      model.value.text = jobDetailController.warrantyInfo.first.model ?? '';
      serialNo.value.text = jobDetailController.warrantyInfo.first.serial ?? '';
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
        repairResultController.maintenanceList.isEmpty
            ? repairResultController.repairResultWrite()
            : repairResultController.maintenanceList.first;
        repairResultController.maintenanceList.first.chargingType.isEmpty
            ? repairResultController.maintenanceList.first.chargingType.add('')
            : repairResultController.maintenanceList.first.chargingType.first;

        if (fieldServiceReport.isEmpty) {
          fieldServiceReport.add('-');
        }
        if (wcodeController.wCode.isEmpty) {
          wcodeController.wCode.add('-');
        }

        if (processStaffController.repairStaff.isEmpty) {
          processStaffController.repairStaff.add('-');
        }
        if (rcodeController.rCode.isEmpty) {
          rcodeController.rCode.add('-');
        }
        if (rPController.repairProcedureList.isEmpty) {
          rPController.repairProcedureList.add(RepairProcedureModel(
            repairProcedure: '-',
            causeProblem: '-',
          ));
        }
        if (fault.value.text == '') {
          fault.value.text = '-';
        }
        if (errorCode.value.text == '') {
          errorCode.value.text = '-';
        }
        if (workorderNumber.value.text == '') {
          workorderNumber.value.text = '-';
        }
        if (customerName.value.text == '') {
          customerName.value.text = '-';
        }
        if (department.value.text == '') {
          department.value.text = '-';
        }
        if (contactedName.value.text == '') {
          contactedName.value.text = '-';
        }
        if (product.value.text == '') {
          product.value.text = '-';
        }
        if (model.value.text == '') {
          model.value.text = '-';
        }
        if (serialNo.value.text == '') {
          serialNo.value.text = '-';
        }
        if (operationHour.value.text == '') {
          operationHour.value.text = '-';
        }
        if (mastType.value.text == '') {
          mastType.value.text = '-';
        }
        if (lifeHeight.value.text == '') {
          lifeHeight.value.text = '-';
        }
        if (customerFleetNo.value.text == '') {
          customerFleetNo.value.text = '-';
        }

        if (highRelationData.isNotEmpty) {
          var currentRelationId = highRelationData.first['relation_id'];
          var highRelation = (int.parse(currentRelationId) + 1).toString();
          saveCurrentDateTime(saveCompletedtime);
          final Map<String, dynamic> data = {
            'job_issue_id': '$jobId',
            'field_report': fieldServiceReport.first,
            'fault_report': fault.value.text,
            'error_code_report': errorCode.value.text,
            'order_no': jobId.value,
            'r_code': rcodeController.rCode.join(','),
            'w_code': wcodeController.wCode.first,
            'produre': rPController.repairProcedureList.first.repairProcedure,
            'problem': rPController.repairProcedureList.first.causeProblem,
            'repair_result':
                repairResultController.maintenanceList.first.chargingType.first,
            "hr": repairResultController.maintenanceList.first.hr,
            "m": repairResultController.maintenanceList.first.people,
            'process_staff': processStaffController.repairStaff.first,
            'relation_id': highRelation,
            'customer_name': customerName.value.text,
            'department': department.value.text,
            'contacted_name': contactedName.value.text,
            'product': product.value.text,
            'model': model.value.text,
            'serial_no': serialNo.value.text,
            'operation_hour': operationHour.value.text,
            'mast_type': mastType.value.text,
            'customer_fleet': customerFleetNo.value.text,
            'lift_height': lifeHeight.value.text,
            'tech1': userController.userInfo.first.realName,
            'tech2': selectedUser.value == '' ? '-' : selectedUser.value,
            'bugid': ticketId.value,
            'save_time': saveCompletedtime.value
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
                'job_issue_id': jobId.value,
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
                } else {
                  print(
                      'Error occurred while saving report: ${response.statusCode}');
                }
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
              showWaitMessage();
              // jobDetailController.fetchData(
              //     ticketId.toString(), jobId.toString());
              await fetchReportData(
                  jobId.toString(),
                  token ?? '',
                  jobDetailController.reportList,
                  jobDetailController.additionalReportList);
              jobDetailController.completeCheck.value = true;
              showSaveMessage();
            } else {
              print('Failed to save report: ${response.statusCode}');
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
