import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/batteryusage_model.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class BatteryUsage extends GetxController {
  int space = 24;
  void batteryUsageModal(BuildContext context) {
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
              child: Image.asset("assets/x.png"),
            ),
          ],
        ),
        space.kH,
        TextFieldWidget(
          text: 'Shift time',
          textSet: shiftTime.value,
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Hrs. per shift',
          textSet: hrsPerShift.value,
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Ratio',
          textSet: ratio.value,
          number: TextInputType.number,
        ),
        space.kH,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Charging Type',
              style: TextStyleList.subtitle3,
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: chargingTypeList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckBoxWidget(
                  option: 'yes',
                  text: chargingTypeList[index],
                  listItem: chargingTypeChoose,
                  itemSet: chargingTypeChoose,
                ));
          },
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
      BuildContext context, BatteryUsageModel batteryInfo) {
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
        space.kH,
        TextFieldEditWidget(
          text: 'Shift time',
          textSet: shiftTime.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Hrs. per shift',
          textSet: hrsPerShift.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Ratio',
          textSet: ratio.value,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Charging Type',
              style: TextStyleList.subtitle3,
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: chargingTypeList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckBoxWidget(
                  option: 'yes',
                  text: chargingTypeList[index],
                  listItem: chargingTypeChoose,
                  itemSet: chargingTypeChoose,
                ));
          },
        ),
        space.kH,
        EndButton(
            onPressed: () {
              batteryUsageUpdate(batteryInfo);
              batteryUsageList.refresh();
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
    'Charge when needed',
    'Only 1 time/day',
  ];
  var batteryUsageList = <BatteryUsageModel>[].obs;
  final shiftTime = TextEditingController().obs;
  final hrsPerShift = TextEditingController().obs;
  final ratio = TextEditingController().obs;

  void batteryUsageRead(BatteryUsageModel batteryInfo) {
    shiftTime.value.text = batteryInfo.shiftTime.toString();
    hrsPerShift.value.text = batteryInfo.hrsPerShift.toString();
    ratio.value.text = batteryInfo.ratio.toString();
    chargingTypeChoose.value = batteryInfo.chargingType.toList();
  }

  void batteryUsageClear() {
    shiftTime.value.clear();
    hrsPerShift.value.clear();
    ratio.value.clear();
    chargingTypeChoose.clear();
  }

  void batteryUsageWrite() {
    final chosenChargingTypes = chargingTypeChoose.toList();
    final newBatteryInfo = BatteryUsageModel(
        shiftTime: double.tryParse(shiftTime.value.text) ?? 0,
        hrsPerShift: double.tryParse(hrsPerShift.value.text) ?? 0,
        ratio: double.tryParse(ratio.value.text) ?? 0,
        chargingType: chosenChargingTypes);
    batteryUsageList.add(newBatteryInfo);
  }

  void batteryUsageUpdate(BatteryUsageModel batteryInfo) {
    batteryInfo.shiftTime = double.tryParse(shiftTime.value.text) ?? 0;
    batteryInfo.hrsPerShift = double.tryParse(hrsPerShift.value.text) ?? 0;
    batteryInfo.ratio = double.tryParse(ratio.value.text) ?? 0;
    batteryInfo.chargingType = chargingTypeChoose.toList();
  }
}
