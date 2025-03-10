// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/maintenance_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class MaintenanceShowWidget extends StatelessWidget {
  final MaintenanceModel info;
  final int index;
  final VoidCallback editFunction;
  final RxList<MaintenanceModel> maintenanceList;
  final String? readOnly;
  const MaintenanceShowWidget(
      {super.key,
      required this.info,
      required this.index,
      required this.editFunction,
      required this.maintenanceList,
      this.readOnly});

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
                if (info.chargingType.isNotEmpty)
                  Text(
                    getDisplayString2(info.chargingType),
                    style: TextStyleList.text12,
                  ),
                8.kH,
                Text(
                  'ประมาณการซ่อม ชั่วโมง (HR)',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.hr}",
                  style: TextStyleList.text15,
                ),
                8.kH,
                Text(
                  'จำนวนคน (M)',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${info.people}",
                  style: TextStyleList.text15,
                ),
                8.kH,
              ],
            ),
          ),
          if (readOnly == null)
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
                      child: Text(context.tr('delete'),
                          style: TextStyleList.text9),
                    ),
                  ],
                  child: Image.asset(
                    'assets/boxedit.png',
                    width: 24,
                    height: 24,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      editFunction();
                    } else if (value == 'delete') {
                      maintenanceList.removeAt(index);
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
