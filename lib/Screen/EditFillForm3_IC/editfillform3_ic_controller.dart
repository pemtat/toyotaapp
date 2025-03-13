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
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/enginechecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/fuelcell.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/hydraulic.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/maintenance.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/motorcheck.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/powertrans.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/safety.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/safetychecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/steering.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class FillformController3IC extends GetxController {
  var jobId = ''.obs;
  var readOnly = ''.obs;
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
  var reportPreventiveListIc = <PreventivereportModel>[].obs;
  final customerName = TextEditingController().obs;
  final department = TextEditingController().obs;
  final contactedName = TextEditingController().obs;
  final product = TextEditingController().obs;
  final serviceType = TextEditingController().obs;
  final model = TextEditingController().obs;
  final chassisNo = TextEditingController().obs;
  final serialNo = TextEditingController().obs;
  final operationHour = TextEditingController().obs;
  final mastType = TextEditingController().obs;
  final lifeHeight = TextEditingController().obs;
  final customerFleetNo = TextEditingController().obs;
  var userByZone = <UsersZone>[].obs;
  var selectedUser = ''.obs;
  final sparePartRemark = TextEditingController().obs;
  final Safety safety = Get.put(Safety());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());
  final SparepartList sparepartList = Get.put(SparepartList());
  final ProcessStaff processStaff = Get.put(ProcessStaff());
  final Maintenance maintenance = Get.put(Maintenance());
  final TextEditingController signatureController = TextEditingController();
  final GlobalKey<SfSignaturePadState> signature = GlobalKey();
  final UserController userController = Get.put(UserController());
  final TicketPmDetailController ticketPmDetailController =
      Get.put(TicketPmDetailController());
  final EngineChecks engineChecks = Get.put(EngineChecks());
  final SteeringChecks steeringChecks = Get.put(SteeringChecks());
  final MotorChecks motorChecks = Get.put(MotorChecks());
  final PowerTransChecks powerTransChecks = Get.put(PowerTransChecks());
  final BrakeSystemChecks breakSystemChecks = Get.put(BrakeSystemChecks());
  final HydraulicChecks hydraulicChecks = Get.put(HydraulicChecks());
  final SafetyChecks safetyChecks = Get.put(SafetyChecks());
  final FuelCell fuelCell = Get.put(FuelCell());

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
    await fetchPreventiveICReportData(
        jobId, token ?? '', reportPreventiveListIc);
    await fetchUserByZone(
      userController.userInfo.first.zone,
      token ?? '',
      userByZone,
    );
    var data = reportPreventiveListIc.first;
    var fullMaintenanceRecords = data.pvtCheckingTypeMaster;
    var maintenances = data.pvtMaintenance;
    var sparePart = data.darDetails;

    if (fullMaintenanceRecords != []) {
      for (var i = 0; i < fullMaintenanceRecords!.length; i++) {
        final data = fullMaintenanceRecords[i];

        for (var j = 0; j < data.maintenanceRecords!.length; j++) {
          final subData = data.maintenanceRecords![j];
          String choose = subData.ok ?? '0';

          if (choose != '' ||
              subData.data1 != '' ||
              subData.data2 != '' ||
              subData.remark != '') {
            if (i == 0) {
              motorChecks.selections[j] = choose;
              motorChecks.remarks[j] = subData.remark ?? '';
              motorChecks.remarksChoose[j] = subData.remark ?? '';
              motorChecks.isAllFieldsFilled.value = true;
            } else if (i == 1) {
              engineChecks.selections[j] = choose;
              engineChecks.remarks[j] = subData.remark ?? '';
              engineChecks.remarksChoose[j] = subData.remark ?? '';
              engineChecks.isAllFieldsFilled.value = true;
            } else if (i == 2) {
              powerTransChecks.selections[j] = choose;
              powerTransChecks.remarks[j] = subData.remark ?? '';
              powerTransChecks.remarksChoose[j] = subData.remark ?? '';
              powerTransChecks.isAllFieldsFilled.value = true;
            } else if (i == 3) {
              steeringChecks.selections[j] = choose;
              steeringChecks.remarks[j] = subData.remark ?? '';
              steeringChecks.remarksChoose[j] = subData.remark ?? '';
              steeringChecks.isAllFieldsFilled.value = true;
            } else if (i == 4) {
              breakSystemChecks.selections[j] = choose;
              breakSystemChecks.remarks[j] = subData.remark ?? '';
              breakSystemChecks.remarksChoose[j] = subData.remark ?? '';
              breakSystemChecks.isAllFieldsFilled.value = true;
            } else if (i == 5) {
              hydraulicChecks.selections[j] = choose;
              hydraulicChecks.remarks[j] = subData.remark ?? '';
              hydraulicChecks.remarksChoose[j] = subData.remark ?? '';
              hydraulicChecks.isAllFieldsFilled.value = true;
            } else if (i == 6) {
              safetyChecks.selections[j] = choose;
              safetyChecks.remarks[j] = subData.remark ?? '';
              safetyChecks.remarksChoose[j] = subData.remark ?? '';
              safetyChecks.isAllFieldsFilled.value = true;
            } else if (i == 7) {
              fuelCell.selections[j] = choose;
              fuelCell.remarks[j] = subData.remark ?? '';
              fuelCell.remarksChoose[j] = subData.remark ?? '';
              fuelCell.isAllFieldsFilled.value = true;
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
      serviceType.value.text = maintenances.serviceType ?? '';
      chassisNo.value.text = maintenances.chassicNo ?? '';
      if ((maintenances.sparePartRemark ?? '') != '') {
        sparePartRemark.value.text = maintenances.sparePartRemark ?? '';
        sparePartRemark.refresh();
      }
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

      for (var i = 0; i < sparePart!.length; i++) {
        if (sparePart[i].qty != '0') {
          sparePartListData.add(SparePartModel(
              cCodePage: sparePart[i].pageCode ?? '',
              partNumber: sparePart[i].partNumber ?? '',
              partDetails: sparePart[i].description ?? '',
              quantity: int.tryParse(sparePart[i].qty ?? '') ?? 0,
              salesPrice: sparePart[i].salesPrice ?? '0',
              priceVat: sparePart[i].priceVat == true ? '1' : '0',
              changeNow: "",
              changeOnPM: "",
              relationId: "",
              unitMeasure: sparePart[i].unitMeasure ?? '',
              additional: 0));
        }
      }
      sparepartList.sparePartList.addAll(sparePartListData);
    }
    // await fetchPmTruckById(jobId, product, serialNo, model, customerName);
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
    if (status == '' || status == '0') {
      return 0;
    } else {
      return int.parse(status);
    }
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    String apiUrl = updatePreventiveIcReport();
    int index = 0;
    List<Map<String, dynamic>> motor =
        motorChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = motorChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": motorChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> engine =
        engineChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = engineChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": engineChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> powertrans =
        powerTransChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;

      String selection = powerTransChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": powerTransChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> steering =
        steeringChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = steeringChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": steeringChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> brake =
        breakSystemChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = breakSystemChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": breakSystemChecks.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> hydraulic =
        hydraulicChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = hydraulicChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": hydraulicChecks.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> safetychecks =
        safetyChecks.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = safetyChecks.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": safetyChecks.remarks[count]
      };
    }).toList();
    List<Map<String, dynamic>> fuelcell =
        fuelCell.ListData.asMap().entries.map((entry) {
      index = index + 1;
      int count = entry.key;
      String selection = fuelCell.selections[count];
      return {
        "pvt_maintenance_code": index,
        "data_1": "",
        "data_2": "",
        "ok": statusToInt(selection),
        "poor": 0,
        "remark": fuelCell.remarks[count]
      };
    }).toList();

    List<Map<String, dynamic>> combinedList = [
      ...motor,
      ...engine,
      ...powertrans,
      ...steering,
      ...brake,
      ...hydraulic,
      ...safetychecks,
      ...fuelcell,
    ];
    if (sparepartList.sparePartList.isEmpty) {
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

      sparepartList.sparePartList.add(defaultSparePart);
    }
    List<Map<String, dynamic>> sparePartList =
        sparepartList.sparePartList.asMap().entries.map((entry) {
      int index = entry.key + 1;

      SparePartModel sparePart = entry.value;
      var price = double.tryParse(sparePart.salesPrice) ?? 0.0;
      return {
        "no": index,
        "page_code": sparePart.cCodePage,
        "description": sparePart.partDetails,
        "part_number": sparePart.partNumber,
        "qty": sparePart.quantity,
        "unit_of_measure": sparePart.unitMeasure,
        "price": price,
        "price_includes_vat": sparePart.priceVat == '1' ? 1 : 0
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
    if (serviceType.value.text == '') {
      serviceType.value.text = '-';
    }
    if (chassisNo.value.text == '') {
      chassisNo.value.text = '-';
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

    if (sparePartRemark.value.text.isEmpty) {
      sparePartRemark.value.text = '';
    }

    final Map<String, dynamic> data = {
      "job_id": jobId.toString(),
      "safety_travel_alarm": safety.selections[0],
      "safety_rearview_mirror": safety.selections[1],
      "safety_seat_belt": safety.selections[2],
      "mt_service_result": maintenance.maintenanceList.first.chargingType.first,
      "officer_checking": officer,
      "customer_checking": 0,
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
      "dar_details": sparePartList,
      'spare_part_remark': sparePartRemark.value.text,
      'service_type': serviceType.value.text,
      'chassis_no': chassisNo.value.text
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
          await fetchPreventiveICReportData(jobId.toString(), token ?? '',
              ticketPmDetailController.reportPreventiveListIc);
          await fetchSubJobSparePartOption();
          await ticketPmDetailController.fetchSubJobSparePartIdPM();
        } else {
          // await jobDetailControllerPM.fetchData(jobId.toString());
          // await fetchCommentJobInfo(
          //     jobId.toString(), token ?? '', jobDetailControllerPM.comment);
          // jobDetailControllerPM.commentCheck.value = true;
          await fetchPreventiveICReportData(jobId.toString(), token ?? '',
              jobDetailControllerPM.reportPreventiveListIc);
          jobDetailControllerPM.completeCheck.value = true;
          await fetchSubJobSparePartOption();
          await jobDetailControllerPM.fetchSubJobSparePartIdPM();
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
