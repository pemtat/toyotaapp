import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/maintenance_model.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class Maintenance extends GetxController {
  int space = 24;
  void batteryUsageModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Maintenance and Service Result",
              style: TextStyleList.subheading,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset("assets/x.png"),
            ),
          ],
        ),
        6.kH,
        ListView.builder(
          shrinkWrap: true,
          itemCount: chargingTypeList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckBoxWidget(
                  text: chargingTypeList[index],
                  listItem: chargingTypeChoose,
                  itemSet: chargingTypeChoose,
                ));
          },
        ),
        space.kH,
        TextFieldWidget(
          text: 'ประมาณการซ่อมชั่วโมง (HR)',
          textSet: people.value,
          number: TextInputType.number,
        ),
        8.kH,
        TextFieldWidget(
          text: 'จำนวนคน (M)',
          textSet: hr.value,
          number: TextInputType.number,
        ),
        space.kH,
        EndButton(
          onPressed: () {
            batteryUsageWrite();
            batteryUsageClear();
            Navigator.pop(context);
          },
          text: 'Save',
        ),
      ],
    ).showModal(context);
  }

  void batteryUsageModalEditModal(
      BuildContext context, MaintenanceModel batteryInfo) {
    batteryUsageRead(batteryInfo);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Battery Usage",
              style: TextStyleList.subheading,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: chargingTypeList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckBoxWidget(
                  text: chargingTypeList[index],
                  listItem: chargingTypeChoose,
                  itemSet: chargingTypeChoose,
                ));
          },
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'ประมาณการซ่อม ชั่วโมง (HR)',
          textSet: hr.value,
        ),
        8.kH,
        TextFieldEditWidget(
          text: 'จำนวนคน (M)',
          textSet: people.value,
        ),
        space.kH,
        EndButton(
            onPressed: () {
              batteryUsageUpdate(batteryInfo);
              maintenanceList.refresh();
              batteryUsageClear();
              Navigator.pop(context);
            },
            text: 'Save')
      ],
    ).showModal(context);
  }

  var chargingTypeChoose = <String>[].obs;
  List<String> chargingType = [];
  List<String> chargingTypeList = [
    'พร้อมใช้งาน(Run)',
    'ใช้งานได้ชั่วคราว(Temporary)',
    'ใช้งานได้ชั่วคราว(Stop)',
  ];
  var maintenanceList = <MaintenanceModel>[].obs;
  final people = TextEditingController().obs;
  final hr = TextEditingController().obs;

  void batteryUsageRead(MaintenanceModel batteryInfo) {
    people.value.text = batteryInfo.people.toString();
    hr.value.text = batteryInfo.hr.toString();
    chargingTypeChoose.addAll(chargingType);
  }

  void batteryUsageClear() {
    people.value.clear();
    hr.value.clear();
    chargingTypeChoose.clear();
  }

  void batteryUsageWrite() {
    final chosenChargingTypes = chargingTypeChoose.toList();
    final newBatteryInfo = MaintenanceModel(
        people: double.tryParse(people.value.text) ?? 0,
        hr: double.tryParse(hr.value.text) ?? 0,
        chargingType: chosenChargingTypes);
    maintenanceList.add(newBatteryInfo);
  }

  void batteryUsageUpdate(MaintenanceModel batteryInfo) {
    batteryInfo.people = double.tryParse(people.value.text) ?? 0;
    batteryInfo.hr = double.tryParse(hr.value.text) ?? 0;
    batteryInfo.chargingType = chargingTypeChoose.toList();
  }
}
