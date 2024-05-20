import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/showmodel_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class RcodeController extends GetxController {
  var rCode = <String>[].obs;
  List<String> rCodeList = [
    'Broken',
    'No grease',
    'No oil',
    'Dirty',
    'Eroded',
    'Short circuit',
    'Disintegrated',
    'Loose',
    'Usually loud noise',
    'Wrong equipment installed',
    'Overheating',
    'Other'
  ];

  void rCodeModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "R Code",
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
          itemCount: rCodeList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RcodeCheckbox(text: rCodeList[index]),
            );
          },
        ),
        8.kH,
        EndButton(onPressed: () {}, text: 'Confirm')
      ],
    ).showModal(context);
  }

  void rCodes(String label) {
    if (rCode.contains(label)) {
      rCode.remove(label);
    } else {
      rCode.add(label);
    }
  }
}

class RcodeCheckbox extends StatelessWidget {
  final String text;
  final RcodeController controller = Get.put(RcodeController());

  RcodeCheckbox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            controller.rCodes(text);
          },
          child: Obx(
            () => Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: !controller.rCode.contains(text)
                    ? Border.all(color: Colors.grey)
                    : Border.all(color: Colors.transparent),
                color: controller.rCode.contains(text)
                    ? Colors.red
                    : Colors.transparent,
              ),
              child: Center(
                child: controller.rCode.contains(text)
                    ? Icon(Icons.check, color: Colors.white, size: 16)
                    : SizedBox(),
              ),
            ),
          ),
        ),
        8.wH,
        Expanded(
          child: Text(text, style: TextStyleList.subdetail),
        ),
      ],
    );
  }
}
