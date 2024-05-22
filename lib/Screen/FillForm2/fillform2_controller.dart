import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';

class FillformController2 extends GetxController {
  final fault = TextEditingController().obs;
  final errorCode = TextEditingController().obs;
  final workorderNumber = TextEditingController().obs;
  var batteryMaintenanceReports = <BatteryModel>[].obs;
  var batteryMaintenanceReport = <String>[].obs;

  var detail = <String>[].obs;

  List<String> batteryMaintenanceReportList = [
    'Battery Information',
    'Battery Usage',
    'Specic Gravity and Voltage Check',
    'Battery Condition',
    'Corective Action',
    'Repair P.M Battery',
    'Action & Result /Change spare parts',
  ];
  List<String> batteryMaintenanceReportShow = [
    'Battery Brand',
    'Battery Model',
    'Mfg.no',
    'Serial. No',
    'Battery Lifespan',
    'Voltage',
    'Capacity',
  ];
  void aWrite() {
    batteryMaintenanceReports.add(BatteryModel(
      a: 'a',
      b: 'b',
      c: 'c',
      d: 'd',
      e: 'e',
      f: 'g',
      g: 'hs',
    ));
  }

  void fieldService(String label) {
    if (batteryMaintenanceReport.contains(label)) {
      batteryMaintenanceReport.remove(label);
    } else {
      batteryMaintenanceReport.add(label);
    }
  }
}
