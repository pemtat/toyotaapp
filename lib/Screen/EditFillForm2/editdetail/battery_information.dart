import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/batteryInformation_model.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class BatteryInformation extends GetxController {
  int space = 24;
  void batteryInformationModal(BuildContext context) {
    batteryInfoClear();
    ShowModalWidget2(
      title: 'Battery Information',
      children: [
        TextFieldWidget(
          text: 'Battery Band',
          textSet: batteryBand.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Battery Model',
          textSet: batteryModel.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Manufacturer No.',
          textSet: mfgNo.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Serial No.',
          textSet: serialNo.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Battery Lifespan',
          textSet: batteryLifespan.value,
          number: TextInputType.number,
          addtionalText: 'Y',
        ),
        space.kH,
        TextFieldWidget(
          text: 'Voltage',
          textSet: voltage.value,
          number: TextInputType.number,
          addtionalText: 'V',
        ),
        space.kH,
        TextFieldWidget(
          text: 'Capacity',
          textSet: capacity.value,
          number: TextInputType.number,
          addtionalText: 'Ah',
        ),
        space.kH,
      ],
      onPressed: () {
        batteryInfoWrite();
        batteryInfoClear();
        Navigator.pop(context);
      },
    ).showModal(context);
  }

  void batteryInformationEditModal(
      BuildContext context, BatteryInformationModel batteryInfo) {
    batteryInfoRead(batteryInfo);
    ShowModalWidget2(
      title: 'Battery Information',
      children: [
        space.kH,
        TextFieldEditWidget(
          text: 'Battery Band',
          textSet: batteryBand.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Battery Model',
          textSet: batteryModel.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Manufacturer No.',
          textSet: mfgNo.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Serial No.',
          textSet: serialNo.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Battery Lifespan',
          textSet: batteryLifespan.value,
          addtionalText: 'Y',
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Voltage',
          textSet: voltage.value,
          addtionalText: 'V',
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Capacity',
          textSet: capacity.value,
          addtionalText: 'Ah',
          number: TextInputType.number,
        ),
        space.kH,
      ],
      onPressed: () {
        batteryInfoUpdate(batteryInfo);
        batteryInformationList.refresh();
        batteryInfoClear();
        Navigator.pop(context);
      },
    ).showModal(context);
  }

  var batteryInformationList = <BatteryInformationModel>[].obs;
  final batteryBand = TextEditingController().obs;
  final batteryModel = TextEditingController().obs;
  final mfgNo = TextEditingController().obs;
  final serialNo = TextEditingController().obs;
  final batteryLifespan = TextEditingController().obs;
  final voltage = TextEditingController().obs;
  final capacity = TextEditingController().obs;

  void batteryInfoRead(BatteryInformationModel batteryInfo) {
    batteryBand.value.text = batteryInfo.batteryBand;
    batteryModel.value.text = batteryInfo.batteryModel;
    mfgNo.value.text = batteryInfo.mfgNo;
    serialNo.value.text = batteryInfo.serialNo;
    batteryLifespan.value.text = batteryInfo.batteryLifespan.toString();
    voltage.value.text = batteryInfo.voltage.toString();
    capacity.value.text = batteryInfo.capacity.toString();
  }

  void batteryInfoClear() {
    batteryBand.value.clear();
    batteryModel.value.clear();
    mfgNo.value.clear();
    serialNo.value.clear();
    batteryLifespan.value.clear();
    voltage.value.clear();
    capacity.value.clear();
  }

  void batteryInfoWrite() {
    final newBatteryInfo = BatteryInformationModel(
      batteryBand:
          batteryBand.value.text.isNotEmpty ? batteryBand.value.text : '-',
      batteryModel:
          batteryModel.value.text.isNotEmpty ? batteryModel.value.text : '-',
      mfgNo: mfgNo.value.text.isNotEmpty ? mfgNo.value.text : '-',
      serialNo: serialNo.value.text.isNotEmpty ? serialNo.value.text : '-',
      batteryLifespan: double.tryParse(batteryLifespan.value.text) ?? 0,
      voltage: double.tryParse(voltage.value.text) ?? 0,
      capacity: double.tryParse(capacity.value.text) ?? 0,
    );
    batteryInformationList.add(newBatteryInfo);
  }

  void batteryInfoUpdate(BatteryInformationModel batteryInfo) {
    batteryInfo.batteryBand =
        batteryBand.value.text.isNotEmpty ? batteryBand.value.text : '-';
    batteryInfo.batteryModel =
        batteryModel.value.text.isNotEmpty ? batteryModel.value.text : '-';
    batteryInfo.mfgNo = mfgNo.value.text.isNotEmpty ? mfgNo.value.text : '-';
    batteryInfo.serialNo =
        serialNo.value.text.isNotEmpty ? serialNo.value.text : '-';
    batteryInfo.batteryLifespan =
        double.tryParse(batteryLifespan.value.text) ?? 0;
    batteryInfo.voltage = double.tryParse(voltage.value.text) ?? 0;
    batteryInfo.capacity = double.tryParse(capacity.value.text) ?? 0;
  }
}
