import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/sparepartseach.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/inputdecoraton.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class EditSparePartDetail extends StatelessWidget {
  final String title;
  final SparePartModel part;
  final Rx<TextEditingController> cCodePage;
  final Rx<TextEditingController> searchPartNumber;
  final RxBool isLoading;
  final RxList<Product> products;
  final Rx<TextEditingController> partNumber;
  final Rx<TextEditingController> partDetails;
  final Rx<TextEditingController> unitMeasure;
  final RxInt quantity;
  final RxList<String> selectionsChoose;
  final RxList<String> selectionsChoose2;
  final RxList<String> selections;
  final RxList<String> selections2;
  final RxList<SparePartModel> sparePartList;
  final String? changeShow;
  const EditSparePartDetail({
    required this.title,
    required this.part,
    required this.cCodePage,
    required this.searchPartNumber,
    required this.isLoading,
    required this.products,
    required this.partNumber,
    required this.partDetails,
    required this.unitMeasure,
    required this.quantity,
    required this.selectionsChoose,
    required this.selectionsChoose2,
    required this.selections,
    required this.selections2,
    required this.sparePartList,
    this.changeShow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    sparePartRead(part);
    products.clear();
    int space = 24;
    return ShowModalWidget2(
      title: title,
      children: [
        Column(
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
                    onSubmitted: (String value) {
                      if (value.length >= 4) {
                        fetchProducts(
                            searchPartNumber.value.text, isLoading, products);
                      } else {
                        products.clear();
                      }
                    },
                    decoration:
                        InputDecoration2(labelText: 'Enter Part Number')),
                Obx(() {
                  if (isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Center(child: DataCircleLoading()),
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
                        trailing: Text(
                          product.inventory.toString(),
                          style: TextStyleList.text3,
                        ),
                        onTap: () {
                          partNumber.value.text = product.no;
                          searchPartNumber.value.text = product.no;
                          partDetails.value.text = product.model;
                          unitMeasure.value.text = product.baseUnitOfMeasure;
                          products.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
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
            if (changeShow != null)
              Column(
                children: [
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
              ),
          ],
        ),
      ],
      onPressed: () {
        sparePartUpdate(part);
        sparePartList.refresh();
        sparePartClear();

        Navigator.pop(context);
      },
    );
  }

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity.value--;
    }
  }

  void chooseClear() {
    selectionsChoose.clear();
    selectionsChoose2.clear();
  }

  void sparePartRead(SparePartModel part) {
    cCodePage.value.text = part.cCodePage;
    partNumber.value.text = part.partNumber;
    partDetails.value.text = part.partDetails;
    unitMeasure.value.text = part.unitMeasure;
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
    unitMeasure.value.clear();
  }

  void sparePartUpdate(SparePartModel part) {
    String cCodePageValue =
        cCodePage.value.text != '' ? cCodePage.value.text : '-';
    String partNumberValue =
        partNumber.value.text != '' ? partNumber.value.text : '-';
    String partDetailsValue =
        partDetails.value.text != '' ? partDetails.value.text : '-';
    String unitMeasureValue =
        unitMeasure.value.text != '' ? unitMeasure.value.text : '-';
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
    part.unitMeasure = unitMeasureValue;
  }
}
