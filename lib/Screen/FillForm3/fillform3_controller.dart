import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/auxiliarymotor.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/batterychecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/chargerchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/chassischeck.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/controllerlogic.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/drivemotorchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/forspecial.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/hydraulicmotor.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/initialchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/maintenance.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/mastchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/meterialhandling.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/powertrainchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/ptpsos.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/safety.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/steeringmotor.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/vnaom.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class FillformController3 extends GetxController {
  var jobId = ''.obs;
  var isSignatureEmpty = true.obs;
  var signaturePad = ''.obs;
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

    customerName.value.text =
        jobDetailControllerPM.customer.value.customerName ?? '';

    if (jobDetailControllerPM.warrantyInfoList.isNotEmpty) {
      product.value.text =
          jobDetailControllerPM.warrantyInfoList.first.productName;
      model.value.text = jobDetailControllerPM.warrantyInfoList.first.model;
      serialNo.value.text = jobDetailControllerPM.warrantyInfoList.first.serial;
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
    String apiUrl = createPreventiveReport();
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
          relationId: "",
          unitMeasure: "-");

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
        "unit_of_measure": sparePart.unitMeasure
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
      "tech1": userController.userInfo.first.realName,
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

      if (response.statusCode == 201) {
        print('yes');
        showWaitMessage();
        await fetchPreventiveReportData(jobId.toString(), token ?? '',
            jobDetailControllerPM.reportPreventiveList);
        jobDetailControllerPM.completeCheck.value = true;
        // await jobDetailControllerPM.fetchData(jobId.toString());
        // await fetchCommentJobInfo(
        //     jobId.toString(), token ?? '', jobDetailControllerPM.comment);
        // jobDetailControllerPM.commentCheck.value = true;
        showSaveMessage();
      } else {
        print('Failed to save report: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
