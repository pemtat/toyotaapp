// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/forkliftinformation.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/forklife_information.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class ForkliftinformationWidget extends StatelessWidget {
  final ForkliftInformationModel info;
  final int index;
  final ForklifeInformation controller;
  const ForkliftinformationWidget({
    super.key,
    required this.info,
    required this.index,
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
                  context.tr('forklift_brand'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  info.forkLifeBrand,
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  context.tr('forklift_model'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  info.forkLifeModel,
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  context.tr('forklift_serial_no'),
                  style: TextStyleList.subtext1,
                ),
                8.kH,
                Text(
                  info.serialNo,
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  context.tr('forklift_operation'),
                  style: TextStyleList.subtext1,
                ),
                8.kH,
                Text(
                  "${info.forkLifeOperation}",
                  style: TextStyleList.text15,
                ),
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
                    controller.forklifeEditModal(context, info);
                  } else if (value == 'delete') {
                    controller.forklifeList.removeAt(index);
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
