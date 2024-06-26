import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class Wcode extends GetxController {
  void wCodeModal(BuildContext context) {
    wCodeChoose.clear();
    wCodeChoose.addAll(wCode);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "W Code",
              style: TextStyleList.subheading,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        8.kH,
        ListView.builder(
          shrinkWrap: true,
          itemCount: wCodeList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckBoxWidget(
                  text: wCodeList[index],
                  listItem: wCodeChoose,
                  itemSet: wCodeChoose,
                ));
          },
        ),
        8.kH,
        EndButton(
            onPressed: () {
              wCode.clear();
              wCode.addAll(wCodeChoose.where((code) => code.isNotEmpty));

              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  var wCode = <String>[].obs;
  var wCodeChoose = <String>[].obs;
  List<String> wCodeList = [
    'CM Repair works when the repair is first reported',
    'CMC Repair/part replacement work',
    'Inspection repair work that is in the conditions',
    'AC repair work result from an accident',
    'FF in-depth  problem anaylsis work',
    'SOT helps other people or other team',
    'MO Modification work, editing',
    'SB waiting/ standby',
    'CO assembly/installation work, dismantling',
  ];
}
