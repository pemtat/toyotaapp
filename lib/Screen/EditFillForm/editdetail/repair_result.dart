import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class RepairResult extends GetxController {
  void repairResultModal(BuildContext context) {
    repairResultChoose.clear();
    repairResultChoose.addAll(repairResult);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Result",
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
          itemCount: repairResultList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CheckBoxWidget(
                  text: repairResultList[index],
                  listItem: repairResultChoose,
                  itemSet: repairResultChoose),
            );
          },
        ),
        8.kH,
        EndButton(
            onPressed: () {
              repairResult.clear();
              repairResult
                  .addAll(repairResultChoose.where((code) => code.isNotEmpty));

              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  var repairResult = <String>[].obs;
  var repairResultChoose = <String>[].obs;
  List<String> repairResultList = [
    'Run',
    'Temporary',
    'Stop',
    'H',
    'M',
  ];
}
