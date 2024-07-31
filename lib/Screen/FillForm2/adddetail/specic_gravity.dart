import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/specigravity_model.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class SpecicGravity extends GetxController {
  int space = 24;
  void specicGravityModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Specic Gravity and Voltage Check",
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
          text: 'Temperature',
          textSet: temperature.value,
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Sp.Gr',
          textSet: thp.value,
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Voltage',
          textSet: voltage.value,
          number: TextInputType.number,
        ),
        space.kH,
        EndButton(
          onPressed: () {
            specicGravityWrite();
            specicGravityClear();
            Navigator.pop(context);
          },
          text: 'Save',
        ),
      ],
    ).showModal(context);
  }

  void specicGravityEditModal(BuildContext context, SpecicGravityModel info) {
    specicGravityRead(info);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Specic Gravity and Voltage Check",
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
          text: 'Temperature',
          textSet: temperature.value,
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Sp.Gr',
          textSet: thp.value,
          number: TextInputType.number,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Voltage',
          textSet: voltage.value,
          number: TextInputType.number,
        ),
        space.kH,
        EndButton(
            onPressed: () {
              specicGravityUpdate(info);
              specicGravityList.refresh();
              specicGravityClear();
              Navigator.pop(context);
            },
            text: 'Save')
      ],
    ).showModal(context);
  }

  var specicGravityList = <SpecicGravityModel>[].obs;
  final temperature = TextEditingController().obs;
  final thp = TextEditingController().obs;
  final voltage = TextEditingController().obs;

  void specicGravityRead(SpecicGravityModel info) {
    temperature.value.text = info.temperature.toString();
    thp.value.text = info.thp.toString();
    voltage.value.text = info.voltage.toString();
  }

  void specicGravityClear() {
    temperature.value.clear();
    thp.value.clear();
    voltage.value.clear();
  }

  void specicGravityWrite() {
    final newSpecicInfo = SpecicGravityModel(
      temperature: double.tryParse(temperature.value.text) ?? 0,
      thp: double.tryParse(thp.value.text) ?? 0,
      voltage: double.tryParse(voltage.value.text) ?? 0,
    );
    specicGravityList.add(newSpecicInfo);
  }

  void specicGravityUpdate(SpecicGravityModel info) {
    info.temperature = double.tryParse(temperature.value.text) ?? 0;
    info.thp = double.tryParse(thp.value.text) ?? 0;
    info.voltage = double.tryParse(voltage.value.text) ?? 0;
  }
}
