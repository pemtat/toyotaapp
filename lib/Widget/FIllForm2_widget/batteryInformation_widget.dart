// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/batteryInformation_model.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/battery_information.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class BatteryInfoDetailWidget extends StatelessWidget {
  final BatteryInformationModel info;
  final int index;
  final BatteryInformation batteryInfoController;
  const BatteryInfoDetailWidget({
    super.key,
    required this.info,
    required this.index,
    required this.batteryInfoController,
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
                  context.tr('battery_band'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  info.batteryBand,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('battery_model'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  info.batteryModel,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('mfg_no'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  info.mfgNo,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('battery_serial'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  info.serialNo,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('battery_lifespan'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.batteryLifespan}",
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('voltage'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.voltage}",
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  context.tr('capacity'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.capacity}",
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
                      context.tr('edit'),
                      style: TextStyleList.text9,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child:
                        Text(context.tr('delete'), style: TextStyleList.text9),
                  ),
                ],
                child: Image.asset(
                  'assets/boxedit.png',
                  width: 24,
                  height: 24,
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    batteryInfoController.batteryInformationEditModal(
                        context, info);
                  } else if (value == 'delete') {
                    batteryInfoController.batteryInformationList
                        .removeAt(index);
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
