// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/battery_condition.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class BatteryConditionWidget extends StatelessWidget {
  final BatteryCondition controller;
  const BatteryConditionWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    int space = 4;
    int space2 = 6;
    return Obx(() => Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tray',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.tray.isNotEmpty ? controller.tray.first : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.trayDescription.value.text,
                        hintText: controller.trayDescription.value.text),
                    8.kH,
                    Text(
                      'Container',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.container.isNotEmpty
                          ? controller.container.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.connectorDescription.value.text,
                        hintText: controller.connectorDescription.value.text),
                    8.kH,
                    Text(
                      'Vent Plug',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.ventPug.isNotEmpty
                          ? controller.ventPug.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space.kH,
                    Text(
                      controller.ventPugOption.isNotEmpty
                          ? controller.ventPugOption.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.ventPlugDescription.value.text,
                        hintText: controller.ventPlugDescription.value.text),
                    8.kH,
                    Text(
                      'Connector',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.connector.isNotEmpty
                          ? controller.connector.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.connectorDescription.value.text,
                        hintText: controller.connectorDescription.value.text),
                    8.kH,
                    Text(
                      'Cover',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.cover.isNotEmpty ? controller.cover.first : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.covertDescription.value.text,
                        hintText: controller.covertDescription.value.text),
                    8.kH,
                    Text(
                      'Terminal',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.terminal.isNotEmpty
                          ? controller.terminal.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.terminalDescription.value.text,
                        hintText: controller.terminalDescription.value.text),
                    8.kH,
                    Text(
                      'Cable + Plug',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.cablePlug.isNotEmpty
                          ? controller.cablePlug.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.cablePlugDescriptionPlug.value.text,
                        hintText:
                            controller.cablePlugDescriptionPlug.value.text),
                    8.kH,
                    Text(
                      'Voltage',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.voltage.isNotEmpty
                          ? controller.voltage.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.voltageDescription.value.text,
                        hintText: controller.voltageDescription.value.text),
                    8.kH,
                    Text(
                      'Sp.Gr.',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.spGr.isNotEmpty ? controller.spGr.first : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.spGrDescription.value.text,
                        hintText: controller.spGrDescription.value.text),
                    8.kH,
                    Text(
                      'Temperature',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.temperature.isNotEmpty
                          ? controller.temperature.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.temperatureDescription.value.text,
                        hintText: controller.temperatureDescription.value.text),
                    8.kH,
                    Text(
                      'Acid',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.acid.isNotEmpty ? controller.acid.first : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.acidDescription.value.text,
                        hintText: controller.acidDescription.value.text),
                    8.kH,
                    Text(
                      'Plates',
                      style: TextStyleList.subtext1,
                    ),
                    space.kH,
                    Text(
                      controller.plates.isNotEmpty
                          ? controller.plates.first
                          : '',
                      style: TextStyleList.text15,
                    ),
                    space2.kH,
                    ShowTextFieldWidget(
                        text: controller.platesDescription.value.text,
                        hintText: controller.platesDescription.value.text),
                    8.kH,
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    popupMenuTheme: const PopupMenuThemeData(
                      color: white3,
                    ),
                  ),
                  child: PopupMenuButton(
                    offset: const Offset(0, 30),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(
                          'Edit',
                          style: TextStyleList.text9,
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete', style: TextStyleList.text9),
                      ),
                    ],
                    child: Image.asset(
                      'assets/boxedit.png',
                      width: 24,
                      height: 24,
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        controller.batteryConditionModal(context);
                      } else if (value == 'delete') {
                        controller.listClear();
                        controller.descriptionClear();
                        controller.isAllFieldsFilled.value = false;
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
