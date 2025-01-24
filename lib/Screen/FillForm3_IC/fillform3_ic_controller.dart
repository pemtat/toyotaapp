import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/fuelcell.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/hydraulic.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/powertrans.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/enginechecks.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/motorcheck.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/safetychecks.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/steering.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/maintenance.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/safety.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class FillformController3IC extends GetxController {
  var jobId = ''.obs;
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
  final customerName = TextEditingController().obs;
  final department = TextEditingController().obs;
  final contactedName = TextEditingController().obs;
  final serviceType = TextEditingController().obs;
  final product = TextEditingController().obs;
  final model = TextEditingController().obs;
  final serialNo = TextEditingController().obs;
  final operationHour = TextEditingController().obs;
  final mastType = TextEditingController().obs;
  final chassisNo = TextEditingController().obs;
  final lifeHeight = TextEditingController().obs;
  final customerFleetNo = TextEditingController().obs;
  final sparePartRemark = TextEditingController().obs;
  var userByZone = <UsersZone>[].obs;
  var selectedUser = ''.obs;
  final EngineChecks engineChecks = Get.put(EngineChecks());
  final SteeringChecks steeringChecks = Get.put(SteeringChecks());
  final MotorChecks motorChecks = Get.put(MotorChecks());
  final PowerTransChecks powerTransChecks = Get.put(PowerTransChecks());
  final BrakeSystemChecks breakSystemChecks = Get.put(BrakeSystemChecks());
  final Safety safety = Get.put(Safety());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());
  final SparepartList sparepartList = Get.put(SparepartList());
  final ProcessStaff processStaff = Get.put(ProcessStaff());
  final HydraulicChecks hydraulicChecks = Get.put(HydraulicChecks());
  final SafetyChecks safetyChecks = Get.put(SafetyChecks());
  final FuelCell fuelCell = Get.put(FuelCell());
  final Maintenance maintenance = Get.put(Maintenance());
  final TextEditingController signatureController = TextEditingController();
  final GlobalKey<SfSignaturePadState> signature = GlobalKey();
  final UserController userController = Get.put(UserController());

  var saveCompletedtime = ''.obs;
  void clearSignature() {
    isSignatureEmpty.value = true;
    signature.currentState!.clear();
  }

  void fetchData(String jobId) async {
    String? token = await getToken();
    this.jobId.value = jobId;
    await userController.fetchData();
    await fetchUserByZone(
      userController.userInfo.first.zone,
      token ?? '',
      userByZone,
    );

    if (jobDetailControllerPM.pmJobs.isNotEmpty) {
      customerName.value.text =
          jobDetailControllerPM.pmJobs.first.customerName ?? '';
      product.value.text = jobDetailControllerPM.pmJobs.first.tNo ?? '';
      model.value.text = jobDetailControllerPM.pmJobs.first.tModel ?? '';
      serialNo.value.text = jobDetailControllerPM.pmJobs.first.serialNo ?? '';
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
    if (status == '' || status == '0') {
      return 0;
    } else {
      return int.parse(status);
    }
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    String apiUrl = createPreventiveIcReport();
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
        salesPrice: "-",
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
    if (serviceType.value.text == '') {
      serviceType.value.text = '-';
    }
    if (chassisNo.value.text == '') {
      chassisNo.value.text = '-';
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
      "tech1": userController.userInfo.first.realName,
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

      if (response.statusCode == 201) {
        showWaitMessage();
        await fetchPreventiveICReportData(jobId.toString(), token ?? '',
            jobDetailControllerPM.reportPreventiveListIc);
        jobDetailControllerPM.completeCheck.value = true;
        // await jobDetailControllerPM.fetchData(jobId.toString());
        // await fetchCommentJobInfo(
        //     jobId.toString(), token ?? '', jobDetailControllerPM.comment);
        // jobDetailControllerPM.commentCheck.value = true;
        showSaveMessage();
        await fetchSubJobSparePartOption();
        await jobDetailControllerPM.fetchSubJobSparePartIdPM();
      } else {
        print('Failed to save report: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
