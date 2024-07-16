import 'dart:convert';
import 'dart:ui';
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
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

class EditFillformController2 extends GetxController {
  var jobId = ''.obs;
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
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

  void fetchData(String jobId) async {
    this.jobId.value = jobId;
    String? token = await getToken();
    await userController.fetchData();
    await fetchBatteryReportData(jobId, token ?? '', batteryReportList);
    var data = batteryReportList.first;
    var info1 = data.btrMaintenance;
    var specicGravity = data.specicVoltageCheck;
    var condition = data.btrConditions;
    var sparepart = data.btrSpareparts;
    var recommendedSpareparts =
        sparepart!.where((sp) => sp.additional == 'recommended').toList();
    var changeSpareparts =
        sparepart.where((sp) => sp.additional == 'change').toList();
    var filteredBatteryCondition = condition!
        .where((item) =>
            (item.status != null && item.status!.isNotEmpty) &&
            (item.description != null && item.description!.isNotEmpty) &&
            (item.nameEn != null))
        .toList();

    final newBatteryInfo = BatteryInformationModel(
      batteryBand: info1!.batteryBand ?? '-',
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
        info1.capacity != '0')
      batteryInfoController.batteryInformationList.add(newBatteryInfo);

    final newForklife = ForkliftInformationModel(
      forkLifeBrand: info1.forkliftBrand ?? '',
      forkLifeModel: info1.forkliftModel ?? '',
      serialNo: info1.forkliftSerial ?? '',
      forkLifeOperation: double.tryParse(info1.forkliftOperation ?? '') ?? 0,
    );
    if (info1.forkliftBrand != '-' ||
        info1.forkliftModel != '-' ||
        info1.forkliftSerial != '-' ||
        info1.forkliftOperation != '0')
      forkLifeInformation.forklifeList.add(newForklife);

    List<String> chosenChargingTypes = [];
    chosenChargingTypes.add(info1.chargingType ?? '');
    final newBatteryUseInfo = BatteryUsageModel(
        shiftTime: double.tryParse(info1.shiftTime ?? '') ?? 0,
        hrsPerShift: double.tryParse(info1.hrs ?? '') ?? 0,
        ratio: double.tryParse(info1.ratio ?? '') ?? 0,
        chargingType: chosenChargingTypes);

    if (info1.shiftTime != '0' || info1.hrs != '0' || info1.ratio != '0')
      batteryUsageController.batteryUsageList.add(newBatteryUseInfo);

    List<SpecicGravityModel> newSpecicGravityList = specicGravity!
        .map((item) => SpecicGravityModel(
              temperature: double.tryParse(item.temperature ?? '') ?? 0,
              thp: double.tryParse(item.thp ?? '') ?? 0,
              voltage: double.tryParse(item.voltageCheck ?? '') ?? 0,
            ))
        .toList();

    if (specicGravity.first.temperature != '0' ||
        specicGravity.first.thp != '0' ||
        specicGravity.first.voltageCheck != '0')
      specicGravityController.specicGravityList.addAll(newSpecicGravityList);

    if (info1.correctiveAction != '')
      correctiveActionController.correctiveAction
          .add(info1.correctiveAction ?? '');

    var sparePartList = <SparePartModel>[].obs;
    if (recommendedSpareparts.first.quantity != '0') {
      for (var i = 0; i < recommendedSpareparts.length; i++) {
        {
          sparePartList.add(SparePartModel(
              cCodePage: recommendedSpareparts[i].cCode ?? '',
              partNumber: recommendedSpareparts[i].partNumber ?? '',
              partDetails: recommendedSpareparts[i].description ?? '',
              quantity:
                  int.tryParse(recommendedSpareparts[i].quantity ?? '') ?? 0,
              changeNow: "",
              changeOnPM: "",
              relationId: "",
              additional: 0));
        }
      }
      sparePartListController.sparePartList.addAll(sparePartList);
    }

    var additionalSparePartList = <SparePartModel>[].obs;
    if (changeSpareparts.first.quantity != '0') {
      for (var i = 0; i < changeSpareparts.length; i++) {
        {
          additionalSparePartList.add(SparePartModel(
              cCodePage: changeSpareparts[i].cCode ?? '',
              partNumber: changeSpareparts[i].partNumber ?? '',
              partDetails: changeSpareparts[i].description ?? '',
              quantity: int.tryParse(changeSpareparts[i].quantity ?? '') ?? 0,
              changeNow: "",
              changeOnPM: "",
              relationId: "",
              additional: 1));
        }
      }
      additSparePartListController.additSparePartList
          .addAll(additionalSparePartList);
    }
    if (info1.repairPm != '')
      repairPmController.repairPm.add(info1.repairPm ?? '');

    bool areAllDescriptionsEmpty = condition.every((item) =>
        item.description == '' || item.checking == '' || item.status == '');

    if (areAllDescriptionsEmpty)
      for (var i = 0; i < condition.length; i++) {
        batteryConditionController.selections[i] = condition[i].status ?? '';
        batteryConditionController.additional[i] = condition[i].checking ?? '';
        batteryConditionController.remarks[i] = condition[i].description ?? '';
        batteryConditionController.isAllFieldsFilled.value = true;
      }
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    String apiUrl = updateBatteryReport();

    saveCurrentDateTime(saveCompletedtime);

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
          relationId: "");

      sparePartListController.sparePartList.add(defaultSparePart);
    }
    if (additSparePartListController.additSparePartList.isEmpty) {
      final SparePartModel defaultSparePart = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
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
      return {
        "c_code": sparePart.cCodePage,
        "part_number": sparePart.partNumber,
        "description": sparePart.partDetails,
        "quantity": sparePart.quantity,
        "additional": "recommended",
        "relation_id": "",
      };
    }).toList();

    List<Map<String, dynamic>> additionalList =
        additSparePartListController.additSparePartList.map((sparePart) {
      return {
        "c_code": sparePart.cCodePage,
        "part_number": sparePart.partNumber,
        "description": sparePart.partDetails,
        "quantity": sparePart.quantity,
        "additional": "change",
        "relation_id": "",
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
        "item_id": index,
        "status": batteryConditionController.selections[index],
        "checking": batteryConditionController.additional[index],
        "description": batteryConditionController.remarks[index]
      };
    }).toList();

    var chargingType = (batteryusage.chargingType.isNotEmpty &&
            batteryusage.chargingType.first == 'Charge when needed')
        ? 1
        : 0;

    final Map<String, dynamic> data = {
      "job_id": jobId.toString(),
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
      "created_by": userController.userInfo.first.id,
      "btr_sparepart": combinedList,
      "specic_voltage_check": specicGravity,
      "btr_conditions": batteryCondition
    };
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Authorization': '$token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        await jobDetailControllerPM.fetchData(jobId.toString());
      } else {
        print('Failed to save report: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
