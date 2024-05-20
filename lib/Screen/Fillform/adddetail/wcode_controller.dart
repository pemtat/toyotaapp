import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodel_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class WcodeController extends GetxController {
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

  void wCodeModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "W Code",
              style: TextStyleList.headmodal,
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
                  itemSet: wCodes),
            );
          },
        ),
        8.kH,
        EndButton(
            onPressed: () {
              wCode.clear();
              wCode.addAll(wCodeChoose);

              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  String getDisplayString() {
    int displayCount = 3;
    if (wCode.length <= displayCount) {
      return wCode.join(', ');
    } else {
      String displayedItems = wCode.sublist(0, displayCount).join(', ');
      int remainingCount = wCode.length - displayCount;
      return '$displayedItems +$remainingCount more';
    }
  }

  void wCodes(String label) {
    if (wCodeChoose.contains(label)) {
      wCodeChoose.remove(label);
    } else {
      wCodeChoose.add(label);
    }
  }
}
