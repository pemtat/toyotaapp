// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/batteryusage_model.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editdetail/batteryusage_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class BatteryUsageWidget extends StatelessWidget {
  final BatteryUsageModel info;
  final int index;
  final BatteryUsage batteryUsageController;
  const BatteryUsageWidget({
    super.key,
    required this.info,
    required this.index,
    required this.batteryUsageController,
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
                  'Shift Time',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.shiftTime}",
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  'Hrs. per shift',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.hrsPerShift}",
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  'Ratio',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.ratio}",
                  style: TextStyleList.text15,
                ),
                if (info.chargingType.isNotEmpty)
                  Text(
                    getDisplayString2(info.chargingType),
                    style: TextStyleList.text12,
                  )
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
                    batteryUsageController.batteryUsageModalEditModal(
                        context, info);
                  } else if (value == 'delete') {
                    batteryUsageController.batteryUsageList.removeAt(index);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
