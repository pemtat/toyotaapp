import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class AdditSparepartList extends GetxController {
  var quantity = 1.obs;
  var additSparePartList = <SparePartModel>[].obs;
  var additSparePartListChoose = <String>[].obs;
  final cCodePage = TextEditingController().obs;
  final partNumber = TextEditingController().obs;
  final partDetails = TextEditingController().obs;
  final changeNow = TextEditingController().obs;
  final changeonPM = TextEditingController().obs;
  int space = 24;
  void additSparePartListModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Additional spare part list",
              style: TextStyleList.headmodal,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        space.kH,
        TextFieldWidget(
          text: 'C-Code/Page',
          textSet: cCodePage.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Part Number',
          textSet: partNumber.value,
        ),
        space.kH,
        TextFieldType(
          hintText: 'Part Details (Description)',
          textSet: partDetails.value,
        ),
        space.kH,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quantity"),
            4.kH,
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: decrement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonbackground,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                      ),
                      child: Image.asset(
                        'assets/minus.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: buttonbackground,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Obx(() => Text(
                          '$quantity',
                          style: TextStyleList.texttitle,
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: increment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonbackground,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Image.asset(
                        'assets/plusint.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        space.kH,
        TextFieldWidget(
          text: 'Change Now',
          textSet: changeNow.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Change on PM',
          textSet: changeonPM.value,
        ),
        space.kH,
        EndButton(
            onPressed: () {
              additSparePartWrite();
              additSparePartClear();
              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  void additSparePartListEditModal(BuildContext context, SparePartModel part) {
    additSparePartRead(part);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Spare part list",
              style: TextStyleList.headmodal,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'C-Code/Page',
          textSet: cCodePage.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Part Number',
          textSet: partNumber.value,
        ),
        space.kH,
        TextFieldEditType(
          hintText: 'Part Details (Description)',
          textSet: partDetails.value,
        ),
        space.kH,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quantity"),
            4.kH,
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: decrement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonbackground,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                      ),
                      child: Image.asset(
                        'assets/minus.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: buttonbackground,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Obx(() => Text(
                          '$quantity',
                          style: TextStyleList.texttitle,
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: increment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonbackground,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Image.asset(
                        'assets/plusint.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Change Now',
          textSet: changeNow.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Change on PM',
          textSet: changeonPM.value,
        ),
        space.kH,
        EndButton(
            onPressed: () {
              additSparePartUpdate(part);
              additSparePartList.refresh();
              additSparePartClear();
              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

  String getDisplayString() {
    int displayCount = 3;
    if (additSparePartList.length <= displayCount) {
      return additSparePartList.join(', ');
    } else {
      String displayedItems =
          additSparePartList.sublist(0, displayCount).join(', ');
      int remainingCount = additSparePartList.length - displayCount;
      return '$displayedItems +$remainingCount more';
    }
  }

  void additSparePartLists(String label) {
    if (additSparePartListChoose.contains(label)) {
      additSparePartListChoose.remove(label);
    } else {
      additSparePartListChoose.add(label);
    }
  }

  void additSparePartRead(SparePartModel part) {
    cCodePage.value.text = part.cCodePage;
    partNumber.value.text = part.partNumber;
    partDetails.value.text = part.partDetails;
    quantity.value = part.quantity;
    changeNow.value.text = part.changeNow;
    changeonPM.value.text = part.changeOnPM;
  }

  void additSparePartClear() {
    cCodePage.value.clear();
    partNumber.value.clear();
    partDetails.value.clear();
    quantity.value = 1;
    changeNow.value.clear();
    changeonPM.value.clear();
  }

  void additSparePartWrite() {
    String cCodePageValue =
        cCodePage.value.text != '' ? cCodePage.value.text : '-';
    String partNumberValue =
        partNumber.value.text != '' ? partNumber.value.text : '-';
    String partDetailsValue =
        partDetails.value.text != '' ? partDetails.value.text : '-';
    String changeNowValue =
        changeNow.value.text != '' ? changeNow.value.text : '-';
    String changeOnPMValue =
        changeonPM.value.text != '' ? changeonPM.value.text : '-';
    additSparePartList.add(SparePartModel(
      cCodePage: cCodePageValue,
      partNumber: partNumberValue,
      partDetails: partDetailsValue,
      quantity: quantity.value,
      changeNow: changeNowValue,
      changeOnPM: changeOnPMValue,
    ));
  }

  void additSparePartUpdate(SparePartModel part) {
    String cCodePageValue =
        cCodePage.value.text != '' ? cCodePage.value.text : '-';
    String partNumberValue =
        partNumber.value.text != '' ? partNumber.value.text : '-';
    String partDetailsValue =
        partDetails.value.text != '' ? partDetails.value.text : '-';
    String changeNowValue =
        changeNow.value.text != '' ? changeNow.value.text : '-';
    String changeOnPMValue =
        changeonPM.value.text != '' ? changeonPM.value.text : '-';
    part.cCodePage = cCodePageValue;
    part.partNumber = partNumberValue;
    part.partDetails = partDetailsValue;
    part.quantity = quantity.value;
    part.changeNow = changeNowValue;
    part.changeOnPM = changeOnPMValue;
  }
}
