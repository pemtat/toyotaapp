// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/specigravity_model.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/specic_gravity.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class SpecicGravityWidget extends StatelessWidget {
  final SpecicGravityModel info;
  final int index;
  final SpecicGravity specicGravityController;
  const SpecicGravityWidget({
    super.key,
    required this.info,
    required this.index,
    required this.specicGravityController,
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
                  'Temperature',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.temperature}",
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  'TH.P',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.thp}",
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  'Voltage',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.voltage}",
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
                    specicGravityController.specicGravityEditModal(
                        context, info);
                  } else if (value == 'delete') {
                    specicGravityController.specicGravityList.removeAt(index);
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
