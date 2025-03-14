import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class Wcode extends GetxController {
  void wCodeModal(BuildContext context) {
    wCodeChoose.clear();
    wCodeChoose.addAll(wCode);
    List<String> wCodeListTrans = [
      context.tr('cm'),
      context.tr('cmc'),
      context.tr('wa'),
      context.tr('ac'),
      context.tr('ff'),
      context.tr('sot'),
      context.tr('mo'),
      context.tr('sb'),
      context.tr('co'),
    ];

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
                  option: 'true',
                  text: wCodeList[index],
                  listItem: wCodeChoose,
                  itemSet: wCodeChoose,
                  transText: wCodeListTrans[index],
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
            text: context.tr('save'))
      ],
    ).showModal(context);
  }

  var wCode = <String>[].obs;
  var wCodeChoose = <String>[].obs;
  List<String> wCodeList = [
    'CM Repair works when the repair is first reported',
    'CMC Repair/part replacement work',
    'WA Inspection repair work that is in the conditions',
    'AC repair work result from an accident',
    'FF in-depth  problem anaylsis work',
    'SOT helps other people or other team',
    'MO Modification work, editing',
    'SB waiting/ standby',
    'CO assembly/installation work, dismantling',
  ];
}
