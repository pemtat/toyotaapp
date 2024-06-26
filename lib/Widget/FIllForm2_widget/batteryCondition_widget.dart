// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/battery_condition.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class BatteryConditionWidget extends StatelessWidget {
  final BatteryCondition controller;
  const BatteryConditionWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                Text(
                  controller.tray.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Container',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  controller.container.first,
                  style: TextStyleList.text15,
                ),
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
                  } else if (value == 'delete') {}
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
