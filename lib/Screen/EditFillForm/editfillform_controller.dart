import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/maintenance_model.dart';
import 'package:toyotamobile/Models/repair_procedure.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/rcode.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_result.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/wcode.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class EditFillformController extends GetxController {
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
  final reportList = <RepairReportModel>[].obs;
  final additionalReportList = <RepairReportModel>[].obs;
  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  var userByZone = <UsersZone>[].obs;
  var selectedUser = ''.obs;
  var usersList = <UsersZone>[].obs;
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
  final UserController userController = Get.put(UserController());

  final RepairStaff repairStaffController = Get.put(RepairStaff());
  final TicketDetailController ticketDetailController =
      Get.put(TicketDetailController());

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
  var readOnly = ''.obs;
  void fetchForm(
      String reportId, String ticketId, String jobId, readOnly) async {
    String? token = await getToken();
    this.ticketId.value = ticketId;
    this.jobId.value = jobId;
    await userController.fetchData();
    await fetchUserByZone(
      userController.userInfo.first.zone,
      token ?? '',
      userByZone,
    );
    if (readOnly != null) {
      this.readOnly.value = readOnly;
    } else {
      this.readOnly.value = 'no';
    }

    await fetchReportData(
        reportId, token ?? '', reportList, additionalReportList);

    if (reportList.isNotEmpty) {
      var reportData = reportList.first;
      relationId.value = reportData.relationId ?? '';
      fault.value.text = reportData.faultReport ?? '';
      customerFleetNo.value.text = reportData.customerFleet ?? '';
      customerName.value.text = reportData.customerName ?? '';
      department.value.text = reportData.department ?? '';
      contactedName.value.text = reportData.contactedName ?? '';
      product.value.text = reportData.product ?? '';
      model.value.text = reportData.model ?? '';
      serialNo.value.text = reportData.serialNo ?? '';
      operationHour.value.text = reportData.operationHour ?? '';
      mastType.value.text = reportData.mastType ?? '';
      lifeHeight.value.text = reportData.liftHeight ?? '';
      selectedUser.value = reportData.tech2 ?? '';
      errorCode.value.text = reportData.errorCodeReport ?? '';
      workorderNumber.value.text = reportData.orderNo ?? '';

      if (reportData.fieldReport != '-') {
        fieldServiceReport.add(reportData.fieldReport ?? '');
      }

      var chargingTypeChoose = <String>[].obs;
      if (reportData.repairResult != '') {
        chargingTypeChoose.add(reportData.repairResult ?? '');
      }
      if (reportData.m != '0' && chargingTypeChoose.isNotEmpty) {
        final newBatteryInfo = MaintenanceModel(
            people: double.tryParse(reportData.m ?? '0') ?? 0,
            hr: double.tryParse(reportData.hr ?? '0') ?? 0,
            chargingType: chargingTypeChoose);
        repairResultController.maintenanceList.add(newBatteryInfo);
      }

      if (reportData.processStaff != '-') {
        repairStaffController.repairStaff.add(reportData.processStaff ?? '');
      }
      if (reportData.wCode != '-') {
        wcodeController.wCode.add(reportData.wCode ?? '');
      }
      if (reportData.rCode! != '-') {
        List<String> rCodeList = reportData.rCode!.split(',');

        for (String rCode in rCodeList) {
          rcodeController.rCode.add(rCode.trim());
        }
      }
      // if (reportData.wCode!.isNotEmpty) {
      //   List<String> wCodeList = reportData.wCode!.split('%');

      //   for (String wCode in wCodeList) {
      //     wcodeController.wCode.add(wCode.trim());
      //   }
      // }
      rPController.repairProcedureList.add(RepairProcedureModel(
        repairProcedure: reportData.produre ?? '',
        causeProblem: reportData.problem ?? '',
      ));

      if (reportData.quantity != '0')

        // ignore: curly_braces_in_flow_control_structures
        for (var reportDataList in reportList + additionalReportList) {
          if (reportDataList.additional == false &&
              reportDataList.quantity != '0') {
            sparePartListController.sparePartList.add(SparePartModel(
                relationId: reportDataList.relationId,
                cCodePage: reportDataList.cCode ?? '1',
                partNumber: reportDataList.partNumber ?? '',
                partDetails: reportDataList.description ?? '',
                quantity: int.parse(reportDataList.quantity ?? ''),
                changeNow: reportDataList.changeNow ?? '',
                changeOnPM: reportDataList.changeOnPm ?? '',
                additional: 0));
          } else if (reportDataList.additional == true &&
              reportDataList.quantity != '0') {
            additSparePartListController.additSparePartList.add(SparePartModel(
                relationId: reportDataList.relationId,
                cCodePage: reportDataList.cCode ?? '1',
                partNumber: reportDataList.partNumber ?? '',
                partDetails: reportDataList.description ?? '',
                quantity: int.parse(reportDataList.quantity ?? ''),
                changeNow: reportDataList.changeNow ?? '',
                changeOnPM: reportDataList.changeOnPm ?? '',
                additional: 1));
          }
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

        if (repairStaffController.repairStaff.isEmpty) {
          repairStaffController.repairStaff.add('-');
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
        saveCurrentDateTime(saveCompletedtime);
        final Map<String, dynamic> data = {
          'field_report': fieldServiceReport.first,
          'fault_report': fault.value.text,
          'error_code_report': errorCode.value.text,
          'order_no': workorderNumber.value.text,
          'r_code': rcodeController.rCode.join(','),
          'w_code': wcodeController.wCode.first,
          'produre': rPController.repairProcedureList.first.repairProcedure,
          'problem': rPController.repairProcedureList.first.causeProblem,
          'repair_result':
              repairResultController.maintenanceList.first.chargingType.first,
          "m": repairResultController.maintenanceList.first.people,
          'process_staff': repairStaffController.repairStaff.first,
          'relation_id': relationId.value,
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
          'tech2': selectedUser.value == '' ? '-' : selectedUser.value,
          'bugid': ticketId.value,
          'save_time': saveCompletedtime.value
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
            'job_issue_id': jobId.value,
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

            showWaitMessage();
            if (readOnly.value == 'yes') {
              // ticketDetailController.fetchData(
              //     ticketId.toString(), jobId.toString());
              await fetchReportData(
                  jobId.toString(),
                  token ?? '',
                  ticketDetailController.reportList,
                  ticketDetailController.additionalReportList);
            } else {
              // jobDetailController.fetchData(
              //     ticketId.toString(), jobId.toString());
              await fetchReportData(
                  jobId.toString(),
                  token ?? '',
                  jobDetailController.reportList,
                  jobDetailController.additionalReportList);
              jobDetailController.completeCheck.value = true;
            }
            showSaveMessage();
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
