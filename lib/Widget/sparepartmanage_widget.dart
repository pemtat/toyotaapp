// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';

class SparePartManageWidget extends StatelessWidget {
  final SparePartModel part;
  final int index;
  final VoidCallback editFunction;
  final RxList<SparePartModel> sparePartList;
  const SparePartManageWidget({
    super.key,
    required this.part,
    required this.index,
    required this.editFunction,
    required this.sparePartList,
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
                  'C-Code/Page',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  part.cCodePage,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Part Number',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  part.partNumber,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Part Details (Description)',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  part.partDetails,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Quantity',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  "${part.quantity}",
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Change Now',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  part.changeNow ?? '-',
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  'Change on PM',
                  style: TextStyleList.subtext1,
                ),
                Text(
                  part.changeOnPM ?? '-',
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
                    editFunction();
                  } else if (value == 'delete') {
                    sparePartList.removeAt(index);
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
