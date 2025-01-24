import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class Rcode extends GetxController {
  void rCodeModal(BuildContext context) {
    rCodeChoose.clear();
    rCodeChoose.addAll(rCode);
    List<String> rCodeListTrans = [
      context.tr('broken'),
      context.tr('lack_of_grease'),
      context.tr('lack_of_oil'),
      context.tr('incorrect_assembly'),
      context.tr('dirty'),
      context.tr('worn_out'),
      context.tr('short_circuit'),
      context.tr('corroded'),
      context.tr('vibration'),
      context.tr('mechanically_locked'),
      context.tr('leakage'),
      context.tr('loose'),
      context.tr('abnormal_noise'),
      context.tr('missing_part'),
      context.tr('overheated'),
      context.tr('other'),
    ];
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "R Code",
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
          itemCount: rCodeList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CheckBoxWidget(
                text: rCodeList[index],
                listItem: rCodeChoose,
                itemSet: rCodeChoose,
                transText: rCodeListTrans[index],
              ),
            );
          },
        ),
        8.kH,
        EndButton(
          onPressed: () {
            rCode.clear();
            rCode.addAll(rCodeChoose.where((code) => code.isNotEmpty));
            Navigator.pop(context);
          },
          text: context.tr('save'),
        )
      ],
    ).showModal(context);
  }

  var rCode = <String>[].obs;
  var rCodeChoose = <String>[].obs;
  List<String> rCodeList = [
    'Broken',
    'Lack of grease',
    'Lack of oil',
    'Incorrect Assembly',
    'Dirty',
    'Worn out',
    'Short circuit',
    'Corroded',
    'Vibration',
    'Mechanically Locked',
    'Leakage',
    'Loose',
    'Abnormal noise',
    'Missing part',
    'Overheated',
    'Other'
  ];
}
