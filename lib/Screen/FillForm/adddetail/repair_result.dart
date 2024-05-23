import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class RepairResult extends GetxController {
  var repairResult = <String>[].obs;
  var repairResultChoose = <String>[].obs;
  List<String> repairResultList = [
    'Run',
    'Temporary',
    'Stop',
    'H',
    'M',
  ];

  void repairResultModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Process",
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
          itemCount: repairResultList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CheckBoxWidget(
                  text: repairResultList[index],
                  listItem: repairResultChoose,
                  itemSet: repairResults),
            );
          },
        ),
        8.kH,
        EndButton(
            onPressed: () {
              repairResult.clear();
              repairResult.addAll(repairResultChoose);

              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  String getDisplayString() {
    int displayCount = 3;
    if (repairResult.length <= displayCount) {
      return repairResult.join(', ');
    } else {
      String displayedItems = repairResult.sublist(0, displayCount).join(', ');
      int remainingCount = repairResult.length - displayCount;
      return '$displayedItems +$remainingCount more';
    }
  }

  void repairResults(String label) {
    if (repairResultChoose.contains(label)) {
      repairResultChoose.remove(label);
    } else {
      repairResultChoose.add(label);
    }
  }
}
