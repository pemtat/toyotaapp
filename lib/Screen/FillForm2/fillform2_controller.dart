import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/specigravity_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/batterycondition.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/battery_information.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/batteryusage_widget.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/corrective_action.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/forklife_information.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/repairpm.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/specic_gravity.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class FillformController2 extends GetxController {
  var jobId = ''.obs;
  var jobIssueId = ''.obs;
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
  final sparePartRemark = TextEditingController().obs;
  final TextEditingController signatureController = TextEditingController();
  final customerName = TextEditingController().obs;
  final contactPerson = TextEditingController().obs;
  final division = TextEditingController().obs;
  var userByZone = <UsersZone>[].obs;
  var selectedUser = ''.obs;
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final BatteryInformation batteryInfoController =
      Get.put(BatteryInformation());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
  final BatteryUsage batteryUsageController = Get.put(BatteryUsage());
  final SpecicGravity specicGravityController = Get.put(SpecicGravity());
  final CorrectiveAction correctiveActionController =
      Get.put(CorrectiveAction());
  final BatteryCondition batteryConditionController =
      Get.put(BatteryCondition());
  final ForklifeInformation forkLifeInformation =
      Get.put(ForklifeInformation());
  final RepairPM repairPmController = Get.put(RepairPM());
  final GlobalKey<SfSignaturePadState> signature = GlobalKey();
  final UserController userController = Get.put(UserController());
  var saveCompletedtime = ''.obs;
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

  void showSaveDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightColor: red1,
          rightButton: right,
          onRightButtonPressed: () async {
            saveReport(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void fetchData(String jobId, jobIssueId) async {
    this.jobId.value = jobId;
    if (jobIssueId == null) {
      this.jobIssueId.value = '';
    } else {
      this.jobIssueId.value = jobIssueId;
    }
    String? token = await getToken();
    await userController.fetchData();
    await fetchUserByZone(
      userController.userInfo.first.zone,
      token ?? '',
      userByZone,
    );

    if (jobIssueId == null) {
      if (jobDetailControllerPM.pmJobs.isNotEmpty) {
        customerName.value.text =
            jobDetailControllerPM.pmJobs.first.customerName ?? '';
        forkLifeInformation.forklifeBrand.value.text =
            jobDetailControllerPM.pmJobs.first.tNo ?? '';
        forkLifeInformation.forklifeModel.value.text =
            jobDetailControllerPM.pmJobs.first.tModel ?? '';
        forkLifeInformation.serialNo.value.text =
            jobDetailControllerPM.pmJobs.first.serialNo ?? '';
      }
    } else {
      if (jobDetailController.subJobs.isNotEmpty) {
        customerName.value.text =
            jobDetailController.subJobs.first.companyName ?? '';
        contactPerson.value.text =
            jobDetailController.subJobs.first.realName ?? '';
        forkLifeInformation.forklifeBrand.value.text =
            jobDetailController.subJobs.first.nameTruck ?? '';
        forkLifeInformation.forklifeModel.value.text =
            jobDetailController.subJobs.first.model ?? '';
        forkLifeInformation.serialNo.value.text =
            jobDetailController.subJobs.first.serialNo ?? '';
      }
    }
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    String apiUrl = jobIssueId.value == ''
        ? createBatteryReport()
        : createJobsBatteryReport();

    saveCurrentDateTime(saveCompletedtime);
    if (correctiveActionController.correctiveAction.isNotEmpty) {
      if (correctiveActionController.correctiveAction.first == 'Other') {
        correctiveActionController.correctiveAction.clear();
        correctiveActionController.correctiveAction
            .add('Other : ${correctiveActionController.other.value.text}');
      }
    }
    if (repairPmController.repairPm.isNotEmpty) {
      if (repairPmController.repairPm.first == 'Other') {
        repairPmController.repairPm.clear();
        repairPmController.repairPm
            .add('Other : ${repairPmController.other.value.text}');
      } else if (repairPmController.repairPm.first ==
          'Replace new cell battery') {
        repairPmController.repairPm.clear();
        repairPmController.repairPm.add(
            'Replace new cell battery : ${repairPmController.otherCell.value.text}');
      }
    }
    batteryInfoController.batteryInformationList.isEmpty
        ? batteryInfoController.batteryInfoWrite()
        : batteryInfoController.batteryInformationList.first;
    forkLifeInformation.forklifeList.isEmpty
        ? forkLifeInformation.forklifeWrite()
        : forkLifeInformation.forklifeList.first;
    batteryUsageController.batteryUsageList.isEmpty
        ? batteryUsageController.batteryUsageWrite()
        : batteryUsageController.batteryUsageList.first;
    var batteryinformation = batteryInfoController.batteryInformationList.first;
    var forklifeinformation = forkLifeInformation.forklifeList.first;
    var batteryusage = batteryUsageController.batteryUsageList.first;

    if (sparePartListController.sparePartList.isEmpty) {
      final SparePartModel defaultSparePart = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          unitMeasure: "-",
          salesPrice: "0",
          priceVat: "0",
          quantity: 0,
          additional: 0,
          relationId: "");

      sparePartListController.sparePartList.add(defaultSparePart);
    }
    if (additSparePartListController.additSparePartList.isEmpty) {
      final SparePartModel defaultSparePart = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          unitMeasure: "-",
          salesPrice: "0",
          priceVat: "0",
          quantity: 0,
          additional: 0,
          relationId: "");

      additSparePartListController.additSparePartList.add(defaultSparePart);
    }

    if (specicGravityController.specicGravityList.isEmpty) {
      final SpecicGravityModel defaultSparePart =
          SpecicGravityModel(temperature: 0, thp: 0, voltage: 0);

      specicGravityController.specicGravityList.add(defaultSparePart);
    }
    List<Map<String, dynamic>> specicGravity =
        specicGravityController.specicGravityList.map((specic) {
      return {
        "temperature": specic.temperature,
        "thp": specic.thp,
        "voltage_check": specic.voltage
      };
    }).toList();
    double sumVoltageCheck = specicGravity.fold(
        0, (sum, item) => sum + (item["voltage_check"] ?? 0));
    List<Map<String, dynamic>> sparePartList =
        sparePartListController.sparePartList.map((sparePart) {
      var price = double.tryParse(sparePart.salesPrice) ?? 0.0;
      return {
        "c_code": sparePart.cCodePage,
        "part_number": sparePart.partNumber,
        "description": sparePart.partDetails,
        "quantity": sparePart.quantity,
        "additional": "recommended",
        "relation_id": "",
        "unit_of_measure": sparePart.unitMeasure,
        "price": price,
        "price_includes_vat": sparePart.priceVat == '1' ? 1 : 0
      };
    }).toList();

    List<Map<String, dynamic>> additionalList =
        additSparePartListController.additSparePartList.map((sparePart) {
      var price = double.tryParse(sparePart.salesPrice) ?? 0.0;
      return {
        "c_code": sparePart.cCodePage,
        "part_number": sparePart.partNumber,
        "description": sparePart.partDetails,
        "quantity": sparePart.quantity,
        "additional": "change",
        "relation_id": "",
        "unit_of_measure": sparePart.unitMeasure,
        "price": price,
        "price_includes_vat": sparePart.priceVat == '1' ? 1 : 0
      };
    }).toList();
    List<Map<String, dynamic>> combinedList = [
      ...sparePartList,
      ...additionalList,
    ];
    List<Map<String, dynamic>> batteryCondition =
        batteryConditionController.ListData.asMap().entries.map((entry) {
      int index = entry.key;

      return {
        "item_id": index + 1,
        "status": batteryConditionController.selections[index],
        "checking": batteryConditionController.additional[index],
        "description": batteryConditionController.remarks[index]
      };
    }).toList();

    var chargingType = batteryusage.chargingType.isNotEmpty
        ? batteryusage.chargingType.first
        : '-';

    if (customerName.value.text == '') {
      customerName.value.text = '-';
    }
    if (contactPerson.value.text == '') {
      contactPerson.value.text = '-';
    }
    if (division.value.text == '') {
      division.value.text = '-';
    }
    if (sparePartRemark.value.text.isEmpty) {
      sparePartRemark.value.text = '';
    }

    final Map<String, dynamic> data = {
      "job_id": jobId.toString(),
      if (jobIssueId.value != '') "job_issue_id": jobIssueId.value,
      "battery_band": batteryinformation.batteryBand,
      "battery_model": batteryinformation.batteryModel,
      "manufacturer_no": batteryinformation.mfgNo,
      "serial_no": batteryinformation.serialNo,
      "battery_lifespan": batteryinformation.batteryLifespan,
      "information_voltage": batteryinformation.voltage,
      "capacity": batteryinformation.capacity,
      "forklift_brand": forklifeinformation.forkLifeBrand,
      "forklift_model": forklifeinformation.forkLifeModel,
      "forklift_serial": forklifeinformation.serialNo,
      "forklift_operation": forklifeinformation.forkLifeOperation,
      "shift_time": batteryusage.shiftTime,
      "hrs": batteryusage.hrsPerShift,
      "ratio": batteryusage.ratio,
      "customer_name": customerName.value.text,
      "contact_person": contactPerson.value.text,
      "tech1": userController.userInfo.first.realName,
      "tech2": selectedUser.value == '' ? '-' : selectedUser.value,
      "division": division.value.text,
      "signature_tech": '',
      "suggestion": '',
      "satisfaction": '',
      "charging_type": chargingType,
      "total_voltage": sumVoltageCheck,
      "corrective_action": correctiveActionController.correctiveAction.isEmpty
          ? ''
          : correctiveActionController.correctiveAction.first,
      "result": "",
      "repair_pm": repairPmController.repairPm.isEmpty
          ? ''
          : repairPmController.repairPm.first,
      "bug_id": jobId.toString(),
      "relation_id": "",
      "created_by": userController.userInfo.first.id,
      "btr_sparepart": combinedList,
      "specic_voltage_check": specicGravity,
      'spare_part_remark': sparePartRemark.value.text,
      "btr_conditions": batteryCondition
    };
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Authorization': '$token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      if (response.statusCode == 201) {
        showWaitMessage();
        // await jobDetailControllerPM.fetchData(jobId.toString());
        // await fetchCommentJobInfo(
        //     jobId.toString(), token ?? '', jobDetailControllerPM.comment);
        // jobDetailControllerPM.commentCheck.value = true;
        if (jobIssueId.value == '') {
          await fetchBatteryReportData(
              jobId.toString(), token ?? '', jobDetailControllerPM.reportList);
          jobDetailControllerPM.completeCheck.value = true;
          await fetchSubJobSparePartOption();
          await jobDetailControllerPM.fetchSubJobSparePartIdPM();
        } else {
          await fetchJobBatteryReportData(jobIssueId.value, token ?? '',
              jobDetailController.reportBatteryList);
          await fetchSubJobSparePartOption();
          await jobDetailController.fetchSubJobSparePartId();
          jobDetailController.completeCheck.value = true;
        }
        showSaveMessage();
      } else {
        print('Failed to save report: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
