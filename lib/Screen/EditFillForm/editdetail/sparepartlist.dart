import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/sparepartseach.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/inputdecoraton.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class SparepartList extends GetxController {
  int space = 24;
  void sparePartListModal(BuildContext context) {
    sparePartClear();
    chooseClear();
    ShowModalWidget2(
      title: "Spare part list",
      children: [
        TextFieldWidget(
          text: 'C-Code/Page',
          textSet: cCodePage.value,
        ),
        space.kH,
        Column(
          children: [
            TextField(
                controller: searchPartNumber.value,
                onChanged: (String value) {
                  if (value.length >= 4) {
                    fetchProducts(
                        searchPartNumber.value.text, isLoading, products);
                  } else {
                    products.clear();
                  }
                },
                decoration: InputDecoration2(labelText: 'Enter Part Number')),
            Obx(() {
              if (isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length > 20 ? 20 : products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(
                      product.model,
                      style: TextStyleList.text6,
                    ),
                    subtitle: Text(
                      'No: ${product.no}',
                      style: TextStyleList.text3,
                    ),
                    onTap: () {
                      partNumber.value.text = product.no;
                      searchPartNumber.value.text = product.no;
                      partDetails.value.text = product.model;
                      products.clear();
                    },
                  );
                },
              );
            })
          ],
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
                        backgroundColor: white5,
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
                        color: white5,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Obx(() => Text(
                          '$quantity',
                          style: TextStyleList.text12,
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
                        backgroundColor: white5,
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
        CheckBoxNew(
          text: 'Change Now',
          itemSet: selectionsChoose,
        ),
        space.kH,
        CheckBoxNew(
          text: 'Change on PM',
          itemSet: selectionsChoose,
        ),
      ],
      onPressed: () {
        sparePartWrite();
        sparePartClear();
        Navigator.pop(context);
      },
    ).showModal(context);
  }

  void sparePartListEditModal(BuildContext context, SparePartModel part) {
    sparePartRead(part);
    ShowModalWidget2(
      title: "Spare part list",
      children: [
        TextFieldEditWidget(
          text: 'C-Code/Page',
          textSet: cCodePage.value,
        ),
        space.kH,
        Column(
          children: [
            TextField(
                controller: searchPartNumber.value,
                onChanged: (String value) {
                  if (value.length >= 4) {
                    fetchProducts(
                        searchPartNumber.value.text, isLoading, products);
                  } else {
                    products.clear();
                  }
                },
                decoration: InputDecoration2(labelText: 'Enter Part Number')),
            Obx(() {
              if (isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length > 20 ? 20 : products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(
                      product.model,
                      style: TextStyleList.text6,
                    ),
                    subtitle: Text(
                      'No: ${product.no}',
                      style: TextStyleList.text3,
                    ),
                    onTap: () {
                      partNumber.value.text = product.no;
                      searchPartNumber.value.text = product.no;
                      partDetails.value.text = product.model;
                      products.clear();
                    },
                  );
                },
              );
            })
          ],
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
                        backgroundColor: white5,
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
                        color: white5,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Obx(() => Text(
                          '$quantity',
                          style: TextStyleList.text12,
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
                        backgroundColor: white5,
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
        CheckBoxNew(
          text: 'Change Now',
          itemSet: selectionsChoose,
        ),
        space.kH,
        CheckBoxNew(
          text: 'Change on PM',
          itemSet: selectionsChoose,
        ),
      ],
      onPressed: () {
        sparePartUpdate(part);
        sparePartList.refresh();
        sparePartClear();
        Navigator.pop(context);
      },
    ).showModal(context);
  }

  var quantity = 1.obs;
  var sparePartList = <SparePartModel>[].obs;
  final cCodePage = TextEditingController().obs;
  final partNumber = TextEditingController().obs;
  final partDetails = TextEditingController().obs;
  final changeNow = TextEditingController().obs;
  final changeonPM = TextEditingController().obs;
  final searchPartNumber = TextEditingController().obs;
  var selections = List<String>.filled(2, '').obs;
  var selections2 = List<String>.filled(2, '').obs;
  var selectionsChoose = List<String>.filled(2, '').obs;
  var selectionsChoose2 = List<String>.filled(2, '').obs;
  var products = <Product>[].obs;
  var isLoading = false.obs;
  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

  void chooseAdd() {
    selectionsChoose.addAll(selections);
    selectionsChoose2.addAll(selections2);
  }

  void chooseClear() {
    selectionsChoose.clear();
    selectionsChoose2.clear();
  }

  void listAdd() {
    selections.assignAll(selectionsChoose);
    selections2.assignAll(selectionsChoose2);
  }

  void listClear() {
    selections.clear();
    selections2.clear();
  }

  void sparePartRead(SparePartModel part) {
    cCodePage.value.text = part.cCodePage;
    partNumber.value.text = part.partNumber;
    partDetails.value.text = part.partDetails;
    quantity.value = part.quantity;
    chooseClear();
    if (part.changeNow == '-') {
      selectionsChoose.add(part.changeOnPM ?? '-');
    } else if (part.changeOnPM == '-') {
      selectionsChoose.add(part.changeNow ?? '-');
    }

    searchPartNumber.value.text = part.partNumber;
  }

  void sparePartClear() {
    cCodePage.value.clear();
    partNumber.value.clear();
    partDetails.value.clear();
    quantity.value = 1;
    searchPartNumber.value.clear();
  }

  void sparePartWrite() {
    String cCodePageValue =
        cCodePage.value.text != '' ? cCodePage.value.text : '-';
    String partNumberValue =
        partNumber.value.text != '' ? partNumber.value.text : '-';
    String partDetailsValue =
        partDetails.value.text != '' ? partDetails.value.text : '-';
    String changeNowValue = '-';
    String changePMValue = '-';
    String changeValue =
        selectionsChoose.isEmpty ? '-' : selectionsChoose.first;
    if (changeValue == 'Change Now') {
      changeNowValue = changeValue;
      changePMValue = '-';
    } else if (changeValue == 'Change on PM') {
      changeNowValue = '-';
      changePMValue = changeValue;
    }
    sparePartList.add(SparePartModel(
        cCodePage: cCodePageValue,
        partNumber: partNumberValue,
        partDetails: partDetailsValue,
        quantity: quantity.value,
        changeNow: changeNowValue,
        changeOnPM: changePMValue,
        additional: 0));
  }

  void sparePartUpdate(SparePartModel part) {
    String cCodePageValue =
        cCodePage.value.text != '' ? cCodePage.value.text : '-';
    String partNumberValue =
        partNumber.value.text != '' ? partNumber.value.text : '-';
    String partDetailsValue =
        partDetails.value.text != '' ? partDetails.value.text : '-';
    String changeNowValue = '-';
    String changePMValue = '-';
    String changeValue =
        selectionsChoose.isEmpty ? '-' : selectionsChoose.first;
    if (changeValue == 'Change Now') {
      changeNowValue = changeValue;
      changePMValue = '-';
    } else if (changeValue == 'Change on PM') {
      changeNowValue = '-';
      changePMValue = changeValue;
    }
    part.cCodePage = cCodePageValue;
    part.partNumber = partNumberValue;
    part.partDetails = partDetailsValue;
    part.quantity = quantity.value;
    part.changeNow = changeNowValue;
    part.changeOnPM = changePMValue;
  }
}
