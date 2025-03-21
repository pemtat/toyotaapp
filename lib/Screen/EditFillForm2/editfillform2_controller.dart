import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/batteryInformation_model.dart';
import 'package:toyotamobile/Models/batteryreport_model.dart';
import 'package:toyotamobile/Models/batteryusage_model.dart';
import 'package:toyotamobile/Models/forkliftinformation.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/specigravity_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/batterycondition.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/battery_information.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/batteryusage_widget.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/corrective_action.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/forklife_information.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/repairpm.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/specic_gravity.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class EditFillformController2 extends GetxController {
  var jobId = ''.obs;
  var readOnly = ''.obs;
  var jobIssueId = ''.obs;
  final customerName = TextEditingController().obs;
  final contactPerson = TextEditingController().obs;
  final division = TextEditingController().obs;
  var userByZone = <UsersZone>[].obs;
  var selectedUser = ''.obs;
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
  final sparePartRemark = TextEditingController().obs;
  final TextEditingController signatureController = TextEditingController();
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final BatteryInformation batteryInfoController =
      Get.put(BatteryInformation());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());
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
  final TicketPmDetailController ticketPmDetailController =
      Get.put(TicketPmDetailController());
  final TicketDetailController ticketDetailController =
      Get.put(TicketDetailController());
  var batteryReportList = <BatteryReportModel>[].obs;

  var saveCompletedtime = ''.obs;

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

  void fetchData(String jobId, readOnly, jobIssueId) async {
    this.jobId.value = jobId;
    if (readOnly != null) {
      this.readOnly.value = readOnly;
    } else {
      this.readOnly.value = 'no';
    }
    if (jobIssueId == null) {
      this.jobIssueId.value = '';
    } else {
      this.jobIssueId.value = jobIssueId;
    }

    String? token = await getToken();
    await userController.fetchData();
    if (this.jobIssueId.value == '') {
      await fetchBatteryReportData(jobId, token ?? '', batteryReportList);
    } else {
      await fetchJobBatteryReportData(
          this.jobIssueId.value, token ?? '', batteryReportList);
    }

    await fetchUserByZone(
      userController.userInfo.first.zone,
      token ?? '',
      userByZone,
    );
    var data = batteryReportList.first;
    var info1 = data.btrMaintenance;
    var specicGravity = data.specicVoltageCheck;
    var condition = data.btrConditions;
    var sparepart = data.btrSpareparts;
    var recommendedSpareparts =
        sparepart!.where((sp) => sp.additional == 'recommended').toList();
    var changeSpareparts =
        sparepart.where((sp) => sp.additional == 'change').toList();
    // var filteredBatteryCondition = condition!
    //     .where((item) =>
    //         (item.status != null && item.status!.isNotEmpty) &&
    //         (item.description != null && item.description!.isNotEmpty) &&
    //         (item.nameEn != null))
    //     .toList();
    customerName.value.text = info1!.customerName ?? '';
    contactPerson.value.text = info1.contactPerson ?? '';
    division.value.text = info1.division ?? '';
    selectedUser.value = info1.tech2 ?? '';
    if ((info1.sparePartRemark ?? '') != '') {
      sparePartRemark.value.text = info1.sparePartRemark ?? '';
      sparePartRemark.refresh();
    }

    final newBatteryInfo = BatteryInformationModel(
      batteryBand: info1.batteryBand ?? '-',
      batteryModel: info1.batteryModel ?? '-',
      mfgNo: info1.manufacturerNo ?? '',
      serialNo: info1.serialNo ?? '',
      batteryLifespan: double.parse(info1.batteryLifespan ?? '0.0'),
      voltage: double.parse(info1.informationVoltage ?? '0.0'),
      capacity: double.parse(info1.capacity ?? '0.0'),
    );

    if (info1.batteryBand != '-' ||
        info1.batteryModel != '-' ||
        info1.manufacturerNo != '-' ||
        info1.serialNo != '-' ||
        info1.batteryLifespan != '0' ||
        info1.informationVoltage != '0' ||
        info1.capacity != '0') {
      batteryInfoController.batteryInformationList.add(newBatteryInfo);
    }

    final newForklife = ForkliftInformationModel(
      forkLifeBrand: info1.forkliftBrand ?? '',
      forkLifeModel: info1.forkliftModel ?? '',
      serialNo: info1.forkliftSerial ?? '',
      forkLifeOperation: double.tryParse(info1.forkliftOperation ?? '') ?? 0,
    );
    if (info1.forkliftBrand != '-' ||
        info1.forkliftModel != '-' ||
        info1.forkliftSerial != '-' ||
        info1.forkliftOperation != '0') {
      forkLifeInformation.forklifeList.add(newForklife);
    }

    List<String> chosenChargingTypes = [];
    if (info1.chargingType != '-') {
      chosenChargingTypes.add(info1.chargingType ?? '-');
    }
    final newBatteryUseInfo = BatteryUsageModel(
        shiftTime: double.tryParse(info1.shiftTime ?? '') ?? 0,
        hrsPerShift: double.tryParse(info1.hrs ?? '') ?? 0,
        ratio: double.tryParse(info1.ratio ?? '') ?? 0,
        chargingType: chosenChargingTypes);

    if (info1.shiftTime != '0' || info1.hrs != '0' || info1.ratio != '0') {
      batteryUsageController.batteryUsageList.add(newBatteryUseInfo);
    }

    List<SpecicGravityModel> newSpecicGravityList = specicGravity!
        .map((item) => SpecicGravityModel(
              temperature: double.tryParse(item.temperature ?? '') ?? 0,
              thp: double.tryParse(item.thp ?? '') ?? 0,
              voltage: double.tryParse(item.voltageCheck ?? '') ?? 0,
            ))
        .toList();

    if (specicGravity.first.temperature != '0' ||
        specicGravity.first.thp != '0' ||
        specicGravity.first.voltageCheck != '0') {
      specicGravityController.specicGravityList.addAll(newSpecicGravityList);
    }

    if (info1.correctiveAction != '') {
      if (info1.correctiveAction!.contains('Other')) {
        correctiveActionController.correctiveAction.add('Other');

        if (info1.correctiveAction!.contains(':')) {
          List<String> parts = info1.correctiveAction!.split(':');

          if (parts.length > 1) {
            correctiveActionController.other.value.text = parts[1].trim();
            correctiveActionController.other2.text = parts[1].trim();
          }
        }
      } else {
        correctiveActionController.correctiveAction
            .add(info1.correctiveAction ?? '');
      }
    }

    var sparePartList = <SparePartModel>[].obs;
    for (var i = 0; i < recommendedSpareparts.length; i++) {
      if (recommendedSpareparts[i].quantity != '0') {
        sparePartList.add(SparePartModel(
            cCodePage: recommendedSpareparts[i].cCode ?? '',
            partNumber: recommendedSpareparts[i].partNumber ?? '',
            partDetails: recommendedSpareparts[i].description ?? '',
            quantity:
                int.tryParse(recommendedSpareparts[i].quantity ?? '') ?? 0,
            salesPrice: recommendedSpareparts[i].salesPrice ?? '0',
            priceVat: recommendedSpareparts[i].priceVat == true ? '1' : '0',
            changeNow: "",
            changeOnPM: "",
            unitMeasure: recommendedSpareparts[i].unitMeasure ?? '',
            relationId: "",
            additional: 0));
      }
    }
    sparePartListController.sparePartList.addAll(sparePartList);

    // var additionalSparePartList = <SparePartModel>[].obs;
    // if (changeSpareparts.first.quantity != '0') {
    //   for (var i = 0; i < changeSpareparts.length; i++) {
    //     {
    //       additionalSparePartList.add(SparePartModel(
    //           cCodePage: changeSpareparts[i].cCode ?? '',
    //           partNumber: changeSpareparts[i].partNumber ?? '',
    //           partDetails: changeSpareparts[i].description ?? '',
    //           quantity: int.tryParse(changeSpareparts[i].quantity ?? '') ?? 0,
    //           salesPrice: changeSpareparts[i].salesPrice ?? '0',
    //           priceVat: changeSpareparts[i].priceVat == true ? '1' : '0',
    //           changeNow: "",
    //           changeOnPM: "",
    //           unitMeasure: changeSpareparts[i].unitMeasure ?? '',
    //           relationId: "",
    //           additional: 1));
    //     }
    //   }
    //   additSparePartListController.additSparePartList
    //       .addAll(additionalSparePartList);
    // }

    if (info1.repairPm != '') {
      if (info1.repairPm!.contains('Other')) {
        repairPmController.repairPm.add('Other');

        if (info1.repairPm!.contains(':')) {
          List<String> parts = info1.repairPm!.split(':');

          if (parts.length > 1) {
            repairPmController.other.value.text = parts[1].trim();
            repairPmController.other2.text = parts[1].trim();
          }
        }
      } else if (info1.repairPm!.contains('Replace new cell battery')) {
        repairPmController.repairPm.add('Replace new cell battery');

        if (info1.repairPm!.contains(':')) {
          List<String> parts = info1.repairPm!.split(':');

          if (parts.length > 1) {
            repairPmController.otherCell.value.text = parts[1].trim();
            repairPmController.otherCell2.text = parts[1].trim();
          }
        }
      } else {
        repairPmController.repairPm.add(info1.repairPm ?? '');
      }
    }

    condition!.sort((a, b) =>
        int.parse(a.itemId ?? '').compareTo(int.parse(b.itemId ?? '')));

    for (var i = 0; i < condition.length; i++) {
      if (condition[i].status != '' ||
          condition[i].checking != '' ||
          condition[i].description != '') {
        batteryConditionController.isAllFieldsFilled.value = true;
      }

      batteryConditionController.selections[i] = condition[i].status ?? '';
      batteryConditionController.additional[i] = condition[i].checking ?? '';
      batteryConditionController.remarks[i] = condition[i].description ?? '';
      batteryConditionController.remarksChoose[i] =
          condition[i].description ?? '';
    }

    // if (jobIssueId == null) {
    //   await fetchPmTruckById(
    //       jobId,
    //       forkLifeInformation.forklifeBrand,
    //       forkLifeInformation.serialNo,
    //       forkLifeInformation.forklifeModel,
    //       customerName);
    // }
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    String apiUrl = jobIssueId.value == ''
        ? updateBatteryReport()
        : updateJobsBatteryReport();

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
        quantity: 0,
        additional: 0,
        relationId: "",
        unitMeasure: "-",
        salesPrice: "0",
        priceVat: "0",
      );

      sparePartListController.sparePartList.add(defaultSparePart);
    }
    if (additSparePartListController.additSparePartList.isEmpty) {
      final SparePartModel defaultSparePart = SparePartModel(
        cCodePage: "-",
        partNumber: "-",
        partDetails: "-",
        quantity: 0,
        additional: 0,
        relationId: "",
        unitMeasure: "-",
        salesPrice: "0",
        priceVat: "0",
      );

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
      "charging_type": chargingType,
      "total_voltage": sumVoltageCheck,
      "corrective_action": correctiveActionController.correctiveAction.isEmpty
          ? ''
          : correctiveActionController.correctiveAction.first,
      "result": "",
      "repair_pm": repairPmController.repairPm.isEmpty
          ? ''
          : repairPmController.repairPm.first,
      "relation_id": "",
      "customer_name": customerName.value.text,
      "contact_person": contactPerson.value.text,
      "division": division.value.text,
      "tech2": selectedUser.value == '' ? '-' : selectedUser.value,
      "signature_tech": '',
      "suggestion": '',
      "satisfaction": '',
      "created_by": userController.userInfo.first.id,
      "btr_sparepart": combinedList,
      "specic_voltage_check": specicGravity,
      "btr_conditions": batteryCondition,
      'spare_part_remark': sparePartRemark.value.text,
    };
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Authorization': '$token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        showWaitMessage();
        if (readOnly.value == 'yes') {
          if (jobIssueId.value == '') {
            await fetchBatteryReportData(jobId.toString(), token ?? '',
                ticketPmDetailController.reportList);
            await fetchSubJobSparePartOption();
            await ticketPmDetailController.fetchSubJobSparePartIdPM();
          } else {
            await fetchJobBatteryReportData(jobIssueId.value, token ?? '',
                ticketDetailController.reportBatteryList);
            await fetchSubJobSparePartOption();
            await ticketDetailController.fetchSubJobSparePartId();
          }
        } else {
          // await jobDetailControllerPM.fetchData(jobId.toString());
          // await fetchCommentJobInfo(
          //     jobId.toString(), token ?? '', jobDetailControllerPM.comment);
          // jobDetailControllerPM.commentCheck.value = true;
          if (jobIssueId.value == '') {
            await fetchBatteryReportData(jobId.toString(), token ?? '',
                jobDetailControllerPM.reportList);
            jobDetailControllerPM.completeCheck.value = true;

            await fetchSubJobSparePartOption();
            await jobDetailControllerPM.fetchSubJobSparePartIdPM();
          } else {
            await fetchJobBatteryReportData(jobIssueId.value, token ?? '',
                jobDetailController.reportBatteryList);
            jobDetailController.completeCheck.value = true;
            await fetchSubJobSparePartOption();
            await jobDetailController.fetchSubJobSparePartId();
          }
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
