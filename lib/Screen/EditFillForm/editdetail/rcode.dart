import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class Rcode extends GetxController {
  void rCodeModal(BuildContext context) {
    rCodeChoose.clear();
    rCodeChoose.addAll(rCode);
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
                  itemSet: rCodeChoose),
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
            text: 'Save')
      ],
    ).showModal(context);
  }

  var rCode = <String>[].obs;
  var rCodeChoose = <String>[].obs;
  List<String> rCodeList = [
    'Broken',
    'No grease',
    'No oil',
    'Misassembled',
    'Dirty',
    'Eroded',
    'Short circuit',
    'Disintegrated',
    'Loose',
    'Vibrating',
    'Stuck',
    'Leaking',
    'Usually loud noise',
    'Wrong equipment installed',
    'Overheating',
    'Other'
  ];
}
