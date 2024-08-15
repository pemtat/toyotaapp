import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/maintenance_model.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/auxiliarymotor.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/batterychecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/chargerchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/chassischeck.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/controllerlogic.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/drivemotorchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/forspecial.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/hydraulicmotor.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/initialchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/maintenance.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/mastchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/meterialhandling.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/powertrainchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/ptpsos.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/safety.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/steeringmotor.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/vnaom.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class FillformController3 extends GetxController {
  var jobId = ''.obs;
  var readOnly = ''.obs;
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
  var reportPreventiveList = <PreventivereportModel>[].obs;
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
  var userByZone = <UsersZone>[].obs;
  var selectedUser = ''.obs;
  final AuxiliaryMotor auxiliaryMotor = Get.put(AuxiliaryMotor());
  final DriveMotorChecks driveMotorChecks = Get.put(DriveMotorChecks());
  final InitialChecks initialChecks = Get.put(InitialChecks());
  final BatteryChecks batteryChecks = Get.put(BatteryChecks());
  final MeterialHandling meterialHandling = Get.put(MeterialHandling());
  final MastChecks mastChecks = Get.put(MastChecks());
  final PtPsOm ptPsOm = Get.put(PtPsOm());
  final VnaOm vnaOm = Get.put(VnaOm());
  final ForSpecial forSpecial = Get.put(ForSpecial());
  final Safety safety = Get.put(Safety());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());
  final SparepartList sparepartList = Get.put(SparepartList());
  final ProcessStaff processStaff = Get.put(ProcessStaff());
  final PowertrainChecks powertrainChecks = Get.put(PowertrainChecks());
  final BreakSystemChecks breakSystemChecks = Get.put(BreakSystemChecks());
  final ChassisChecks chassisChecks = Get.put(ChassisChecks());
  final HydraulicmMotor hydraulicmMotor = Get.put(HydraulicmMotor());
  final ControllerLogic controllerLogic = Get.put(ControllerLogic());
  final ChargerChecks chargerChecks = Get.put(ChargerChecks());
  final Maintenance maintenance = Get.put(Maintenance());
  final SteeringMotor steeringMotor = Get.put(SteeringMotor());
  final TextEditingController signatureController = TextEditingController();
  final GlobalKey<SfSignaturePadState> signature = GlobalKey();
  final UserController userController = Get.put(UserController());
  final TicketPmDetailController ticketPmDetailController =
      Get.put(TicketPmDetailController());

  var saveCompletedtime = ''.obs;
  void clearSignature() {
    isSignatureEmpty.value = true;
    signature.currentState!.clear();
  }

  void fetchData(String jobId, readOnly) async {
    this.jobId.value = jobId;
    if (readOnly != null) {
      this.readOnly.value = readOnly;
    } else {
      this.readOnly.value = 'no';
    }

    String? token = await getToken();
    await userController.fetchData();
    await fetchPreventiveReportData(jobId, token ?? '', reportPreventiveList);
    await fetchUserByZone(
      userController.userInfo.first.zone,
      token ?? '',
      userByZone,
    );
    var data = reportPreventiveList.first;
    var fullMaintenanceRecords = data.pvtCheckingTypeMaster;
    var maintenances = data.pvtMaintenance;
    var sparePart = data.darDetails;

    if (fullMaintenanceRecords != []) {
      for (var i = 0; i < fullMaintenanceRecords!.length; i++) {
        final data = fullMaintenanceRecords[i];

        for (var j = 0; j < data.maintenanceRecords!.length; j++) {
          final subData = data.maintenanceRecords![j];
          String choose = checkStatus(subData.ok ?? '', subData.poor ?? '');

          if (choose != '' ||
              subData.data1 != '' ||
              subData.data2 != '' ||
              subData.remark != '') {
            if (i == 0) {
              initialChecks.selections[j] = choose;
              initialChecks.remarks[j] = subData.remark ?? '';
              initialChecks.remarksChoose[j] = subData.remark ?? '';
              initialChecks.isAllFieldsFilled.value = true;
            } else if (i == 1) {
              chassisChecks.selections[j] = choose;
              chassisChecks.remarks[j] = subData.remark ?? '';
              chassisChecks.remarksChoose[j] = subData.remark ?? '';
              chassisChecks.additional[j] = subData.data1 ?? '';
              chassisChecks.additionalChoose[j] = subData.data1 ?? '';
              chassisChecks.additionalControllers[j].text = subData.data1 ?? '';
              chassisChecks.isAllFieldsFilled.value = true;
            } else if (i == 2) {
              hydraulicmMotor.selections[j] = choose;
              hydraulicmMotor.remarks[j] = subData.remark ?? '';
              hydraulicmMotor.remarksChoose[j] = subData.remark ?? '';
              hydraulicmMotor.additional[j] = subData.data1 ?? '';
              hydraulicmMotor.additionalChoose[j] = subData.data1 ?? '';

              hydraulicmMotor.isAllFieldsFilled.value = true;
            } else if (i == 3) {
              steeringMotor.selections[j] = choose;
              steeringMotor.remarks[j] = subData.remark ?? '';
              steeringMotor.remarksChoose[j] = subData.remark ?? '';
              steeringMotor.additional[j] = subData.data1 ?? '';
              steeringMotor.additionalChoose[j] = subData.data1 ?? '';
              steeringMotor.isAllFieldsFilled.value = true;
            } else if (i == 4) {
              auxiliaryMotor.selections[j] = choose;
              auxiliaryMotor.remarks[j] = subData.remark ?? '';
              auxiliaryMotor.remarksChoose[j] = subData.remark ?? '';
              auxiliaryMotor.additional[j] = subData.data1 ?? '';
              auxiliaryMotor.additionalChoose[j] = subData.data1 ?? '';
              auxiliaryMotor.isAllFieldsFilled.value = true;
            } else if (i == 5) {
              driveMotorChecks.selections[j] = choose;
              driveMotorChecks.remarks[j] = subData.remark ?? '';
              driveMotorChecks.remarksChoose[j] = subData.remark ?? '';
              driveMotorChecks.additional[j] = subData.data1 ?? '';
              driveMotorChecks.additionalChoose[j] = subData.data1 ?? '';
              driveMotorChecks.isAllFieldsFilled.value = true;
            } else if (i == 6) {
              breakSystemChecks.selections[j] = choose;
              breakSystemChecks.remarks[j] = subData.remark ?? '';
              breakSystemChecks.remarksChoose[j] = subData.remark ?? '';
              breakSystemChecks.additional[j] = subData.data1 ?? '';
              breakSystemChecks.additionalChoose[j] = subData.data1 ?? '';
              breakSystemChecks.additionalControllers[j].text =
                  subData.data1 ?? '';
              breakSystemChecks.isAllFieldsFilled.value = true;
            } else if (i == 7) {
              controllerLogic.selections[j] = choose;
              controllerLogic.remarks[j] = subData.remark ?? '';
              controllerLogic.remarksChoose[j] = subData.remark ?? '';
              controllerLogic.additional[j] = subData.data1 ?? '';
              controllerLogic.isAllFieldsFilled.value = true;
            } else if (i == 8) {
              powertrainChecks.selections[j] = choose;
              powertrainChecks.remarks[j] = subData.remark ?? '';
              powertrainChecks.remarksChoose[j] = subData.remark ?? '';
              powertrainChecks.additional[j] = subData.data1 ?? '';
              powertrainChecks.isAllFieldsFilled.value = true;
            } else if (i == 9) {
              batteryChecks.selections[j] = choose;
              batteryChecks.remarks[j] = subData.remark ?? '';
              batteryChecks.remarksChoose[j] = subData.remark ?? '';
              batteryChecks.additional[j] = subData.data1 ?? '';
              batteryChecks.additionalChoose[j] = subData.data1 ?? '';
              batteryChecks.additionalControllers[j].text = subData.data1 ?? '';
              if (choose != '' ||
                  subData.data1 != '' ||
                  (subData.data2 != '' && subData.data2 != ',') ||
                  subData.remark != '') {
                batteryChecks.isAllFieldsFilled.value = true;
              }
              if (subData.data2!.contains(',')) {
                var splitData = subData.data2!.split(',');
                batteryChecks.additional2[j][0] = splitData[0].trim();
                batteryChecks.additional2[j][1] = splitData[1].trim();
                batteryChecks.additionalChoose2[j][0] = splitData[0].trim();
                batteryChecks.additionalChoose2[j][1] = splitData[1].trim();
                batteryChecks.subControllers1[j].text = splitData[0].trim();
                batteryChecks.subControllers2[j].text = splitData[1].trim();
              } else {
                batteryChecks.additional2[j][0] = subData.data2 ?? '';
                batteryChecks.additional2[j][1] = subData.data2 ?? '';
                batteryChecks.additionalChoose2[j][0] = subData.data2 ?? '';
                batteryChecks.additionalChoose2[j][1] = subData.data2 ?? '';
                batteryChecks.subControllers1[j].text = subData.data2 ?? '';
                batteryChecks.subControllers2[j].text = subData.data2 ?? '';
              }
            } else if (i == 10) {
              chargerChecks.selections[j] = choose;
              chargerChecks.remarks[j] = subData.remark ?? '';
              chargerChecks.remarksChoose[j] = subData.remark ?? '';
              chargerChecks.isAllFieldsFilled.value = true;
            } else if (i == 11) {
              meterialHandling.selections[j] = choose;
              meterialHandling.remarks[j] = subData.remark ?? '';
              meterialHandling.remarksChoose[j] = subData.remark ?? '';
              meterialHandling.additional[j] = subData.data1 ?? '';
              meterialHandling.additionalChoose[j] = subData.data1 ?? '';
              meterialHandling.isAllFieldsFilled.value = true;
            } else if (i == 12) {
              mastChecks.selections[j] = choose;
              mastChecks.remarks[j] = subData.remark ?? '';
              mastChecks.remarksChoose[j] = subData.remark ?? '';
              mastChecks.additional[j] = subData.data1 ?? '';
              mastChecks.additionalChoose[j] = subData.data1 ?? '';
              mastChecks.additionalControllers[j].text = subData.data1 ?? '';

              if (choose != '' ||
                  subData.data1 != '' ||
                  (subData.data2 != '' && subData.data2 != ',') ||
                  subData.remark != '') {
                mastChecks.isAllFieldsFilled.value = true;
              }

              if (subData.data2!.contains(',')) {
                var splitData = subData.data2!.split(',');
                mastChecks.additional2[j][0] = splitData[0].trim();
                mastChecks.additional2[j][1] = splitData[1].trim();
                mastChecks.additionalChoose2[j][0] = splitData[0].trim();
                mastChecks.additionalChoose2[j][1] = splitData[1].trim();
                mastChecks.subControllers1[j].text = splitData[0].trim();
                mastChecks.subControllers2[j].text = splitData[1].trim();
              } else {
                mastChecks.additional2[j][0] = subData.data2 ?? '';
                mastChecks.additional2[j][1] = subData.data2 ?? '';
                mastChecks.additionalChoose2[j][0] = subData.data2 ?? '';
                mastChecks.additionalChoose2[j][1] = subData.data2 ?? '';
                mastChecks.subControllers1[j].text = subData.data2 ?? '';
                mastChecks.subControllers2[j].text = subData.data2 ?? '';
              }
            } else if (i == 13) {
              ptPsOm.selections[j] = choose;
              ptPsOm.remarks[j] = subData.remark ?? '';
              ptPsOm.remarksChoose[j] = subData.remark ?? '';
              ptPsOm.additional[j] = subData.data1 ?? '';
              ptPsOm.additionalChoose[j] = subData.data1 ?? '';
              ptPsOm.additionalControllers[j].text = subData.data1 ?? '';

              ptPsOm.isAllFieldsFilled.value = true;
            } else if (i == 14) {
              vnaOm.selections[j] = choose;
              vnaOm.remarks[j] = subData.remark ?? '';
              vnaOm.remarksChoose[j] = subData.remark ?? '';
              vnaOm.additional[j] = subData.data1 ?? '';
              vnaOm.additionalChoose[j] = subData.data1 ?? '';
              vnaOm.additionalControllers[j].text = subData.data1 ?? '';
              vnaOm.isAllFieldsFilled.value = true;
            } else if (i == 15) {
              forSpecial.selections[j] = choose;
              forSpecial.remarks[j] = subData.remark ?? '';
              forSpecial.remarksChoose[j] = subData.remark ?? '';
              forSpecial.isAllFieldsFilled.value = true;
            }
          }
        }
      }
    }
    if (maintenances != []) {
      customerFleetNo.value.text = maintenances!.customerFleet ?? '';
      operationHour.value.text = maintenances.operationHour ?? '';
      mastType.value.text = maintenances.mastType ?? '';
      lifeHeight.value.text = maintenances.liftHeight ?? '';
      selectedUser.value = maintenances.tech2 ?? '';
      customerName.value.text = maintenances.customerName ?? '';
      department.value.text = maintenances.department ?? '';
      contactedName.value.text = maintenances.contactedName ?? '';
      product.value.text = maintenances.product ?? '';
      model.value.text = maintenances.model ?? '';
      serialNo.value.text = maintenances.serialNo ?? '';
      if (maintenances.safetyTravelAlarm == '' &&
          maintenances.safetyRearviewMirror == '' &&
          maintenances.safetySeatBelt == '') {
        safety.isAllFieldsFilled.value = false;
      } else {
        safety.isAllFieldsFilled.value = true;
      }

      safety.selections[0] = maintenances.safetyTravelAlarm ?? '';
      safety.selections[1] = maintenances.safetyRearviewMirror ?? '';
      safety.selections[2] = maintenances.safetySeatBelt ?? '';

      var chargingTypeChoose = <String>[].obs;
      if (maintenances.mtServiceResult != '') {
        chargingTypeChoose.add(maintenances.mtServiceResult ?? '');
      }
      if (maintenances.m != '0' &&
          maintenances.hr != '0' &&
          chargingTypeChoose.isNotEmpty) {
        final newBatteryInfo = MaintenanceModel(
            people: double.tryParse(maintenances.m ?? '0') ?? 0,
            hr: double.tryParse(maintenances.hr ?? '0') ?? 0,
            chargingType: chargingTypeChoose);
        maintenance.maintenanceList.add(newBatteryInfo);
      }

      if (maintenances.officerChecking != '') {
        processStaff.repairStaff.add(maintenances.officerChecking ?? '');
      }
    }

    if (sparePart != []) {
      var sparePartListData = <SparePartModel>[].obs;
      if (sparePart!.first.qty != '0') {
        for (var i = 0; i < sparePart.length; i++) {
          {
            sparePartListData.add(SparePartModel(
                cCodePage: sparePart[i].pageCode ?? '',
                partNumber: sparePart[i].partNumber ?? '',
                partDetails: sparePart[i].description ?? '',
                quantity: int.tryParse(sparePart[i].qty ?? '') ?? 0,
                changeNow: "",
                changeOnPM: "",
                relationId: "",
                additional: 0));
          }
        }
        sparepartList.sparePartList.addAll(sparePartListData);
      }
    }
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
          onRightButtonPressed: () {
            saveReport(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  int statusToInt(String status) {
    if (status == 'Good') {
      return 1;
    } else if (status == 'Poor') {
      return 0;
    } else {
      return -1;
    }
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    String apiUrl = updatePreventiveReport();
    int index = 0;
    List<Map<String, dynamic>> intial =
        initialChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = initialChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": initialChecks.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> chassic =
        chassisChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = chassisChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": chassisChecks.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": chassisChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> hydraulic =
        hydraulicmMotor.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;

      String selection = hydraulicmMotor.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": hydraulicmMotor.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": hydraulicmMotor.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> steering =
        steeringMotor.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = steeringMotor.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": steeringMotor.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": steeringMotor.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> auxiliary =
        auxiliaryMotor.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = auxiliaryMotor.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": auxiliaryMotor.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": auxiliaryMotor.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> drivemotor =
        driveMotorChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = driveMotorChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": driveMotorChecks.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": driveMotorChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> brake =
        breakSystemChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = breakSystemChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": breakSystemChecks.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": breakSystemChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> controllerlogin =
        controllerLogic.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = controllerLogic.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": controllerLogic.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> powertrain =
        powertrainChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = powertrainChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": powertrainChecks.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> battery =
        batteryChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = batteryChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": batteryChecks.additional[count],
        "data_2":
            "${batteryChecks.additional2[count][0]},${batteryChecks.additional2[count][1]}",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": batteryChecks.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> charger =
        chargerChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = chargerChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": chargerChecks.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> meterial =
        meterialHandling.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = meterialHandling.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": meterialHandling.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> mast =
        mastChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = mastChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": mastChecks.additional[count],
        "data_2":
            "${mastChecks.additional2[count][0]},${mastChecks.additional2[count][1]}",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": mastChecks.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> ptos =
        ptPsOm.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = ptPsOm.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": ptPsOm.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": ptPsOm.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> vna =
        vnaOm.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = vnaOm.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": vnaOm.additional[count],
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": vnaOm.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> forspecial =
        forSpecial.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = forSpecial.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection) == 1 ? 1 : 0,
        "poor": statusToInt(selection) == 0 ? 1 : 0,
        "remark": forSpecial.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> combinedList = [
      ...intial,
      ...chassic,
      ...hydraulic,
      ...steering,
      ...auxiliary,
      ...drivemotor,
      ...brake,
      ...controllerlogin,
      ...powertrain,
      ...battery,
      ...charger,
      ...meterial,
      ...mast,
      ...ptos,
      ...vna,
      ...forspecial,
    ];
    if (sparepartList.sparePartList.isEmpty) {
      final SparePartModel defaultSparePart = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          quantity: 0,
          additional: 0,
          relationId: "");

      sparepartList.sparePartList.add(defaultSparePart);
    }
    List<Map<String, dynamic>> sparePartList =
        sparepartList.sparePartList.asMap().entries.map((entry) {
      int index = entry.key + 1;

      SparePartModel sparePart = entry.value;
      return {
        "no": index,
        "page_code": sparePart.cCodePage,
        "description": sparePart.partDetails,
        "part_number": sparePart.partNumber,
        "qty": sparePart.quantity,
      };
    }).toList();

    maintenance.maintenanceList.isEmpty
        ? maintenance.batteryUsageWrite()
        : maintenance.maintenanceList.first;
    maintenance.maintenanceList.first.chargingType.isEmpty
        ? maintenance.maintenanceList.first.chargingType.add('')
        : maintenance.maintenanceList.first.chargingType.first;
    var officer =
        processStaff.repairStaff.isEmpty ? '' : processStaff.repairStaff.first;
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
    final Map<String, dynamic> data = {
      "job_id": jobId.toString(),
      "safety_travel_alarm": safety.selections[0],
      "safety_rearview_mirror": safety.selections[1],
      "safety_seat_belt": safety.selections[2],
      "mt_service_result": maintenance.maintenanceList.first.chargingType.first,
      "officer_checking": officer,
      "customer_checking": "",
      "customer_score": 0,
      "customer_description": "",
      'customer_name': customerName.value.text,
      'department': department.value.text,
      'contacted_name': contactedName.value.text,
      'product': product.value.text,
      'model': model.value.text,
      'serial_no': serialNo.value.text,
      "operation_hour": operationHour.value.text,
      "mast_type": mastType.value.text,
      "lift_height": lifeHeight.value.text,
      "customer_fleet": customerFleetNo.value.text,
      "tech2": selectedUser.value == '' ? '-' : selectedUser.value,
      "hr": maintenance.maintenanceList.first.hr,
      "m": maintenance.maintenanceList.first.people,
      "created_by": userController.userInfo.first.id,
      "pvt_maintenance_details": combinedList,
      "dar_details": sparePartList
    };
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Authorization': '$token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        print('yes');
        showWaitMessage();
        if (readOnly.value == 'yes') {
          await fetchPreventiveReportData(jobId.toString(), token ?? '',
              ticketPmDetailController.reportPreventiveList);
        } else {
          // await jobDetailControllerPM.fetchData(jobId.toString());
          // await fetchCommentJobInfo(
          //     jobId.toString(), token ?? '', jobDetailControllerPM.comment);
          // jobDetailControllerPM.commentCheck.value = true;
          await fetchPreventiveReportData(jobId.toString(), token ?? '',
              jobDetailControllerPM.reportPreventiveList);
          jobDetailControllerPM.completeCheck.value = true;
        }
        showSaveMessage();
      } else {
        print('Failed to save report: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  String checkStatus(String ok, String poor) {
    if (ok == '1' && poor == '0') {
      return 'Good';
    } else if (ok == '0' && poor == '1') {
      return 'Poor';
    } else if (ok == '0' && poor == '0') {
      return '';
    } else
      return '';
  }
}
