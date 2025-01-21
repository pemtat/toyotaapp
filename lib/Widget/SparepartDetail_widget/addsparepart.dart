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
import 'package:toyotamobile/extensions/context_extension.dart';

class AddSparePartDetail extends StatelessWidget {
  final String title;
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
  final String additional;
  AddSparePartDetail({
    required this.title,
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
    required this.additional,
    super.key,
  });

  final salesPrice = TextEditingController().obs;
  final priceVat = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    sparePartClear();
    chooseClear();
    products.clear();
    int space = 24;
    return ShowModalWidget2(
      title: title,
      children: [
        TextFieldWidget(
          text: 'C-Code/Page',
          textSet: cCodePage.value,
        ),
        space.kH,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                decoration: InputDecoration2(
                    labelText: 'Enter Part Number',
                    function: () {
                      fetchProducts(
                          searchPartNumber.value.text, isLoading, products);
                    })),
            4.kH,
            Text(
              '(${context.tr('fill_more_4')})',
              style: TextStyleList.text1,
            ),
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
                    onTap: () async {
                      partNumber.value.text = product.no;
                      searchPartNumber.value.text = product.no;
                      partDetails.value.text = product.model;
                      unitMeasure.value.text = product.baseUnitOfMeasure;
                      await getSparePartDetails(
                          partNumber.value.text, salesPrice);
                      priceVat.value.text =
                          product.priceIncludesVat == true ? '1' : '0';
                      products.clear();
                      // FocusScope.of(context).requestFocus(FocusNode());
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
            Text(context.tr('quantity')),
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
                text: context.tr('change_now'),
                itemSet: selectionsChoose,
              ),
              space.kH,
              CheckBoxNew(
                text: context.tr('change_on_pm'),
                itemSet: selectionsChoose,
              ),
            ],
          ),
      ],
      onPressed: () {
        sparePartWrite();
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

  void sparePartClear() {
    cCodePage.value.clear();
    partNumber.value.clear();
    partDetails.value.clear();
    unitMeasure.value.clear();
    salesPrice.value.clear();
    priceVat.value.clear();
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
    String unitMeasureValue =
        unitMeasure.value.text != '' ? unitMeasure.value.text : '-';
    String salesPriceValue =
        salesPrice.value.text != '' ? salesPrice.value.text : '0';
    String priceVatValue =
        priceVat.value.text != '' ? priceVat.value.text : '0';
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
    if (additional == '0') {
      sparePartList.add(SparePartModel(
          cCodePage: cCodePageValue,
          partNumber: partNumberValue,
          partDetails: partDetailsValue,
          quantity: quantity.value,
          salesPrice: salesPriceValue,
          priceVat: priceVatValue,
          changeNow: changeNowValue,
          changeOnPM: changePMValue,
          unitMeasure: unitMeasureValue,
          additional: 0));
    } else if (additional == '1') {
      sparePartList.add(SparePartModel(
          cCodePage: cCodePageValue,
          partNumber: partNumberValue,
          partDetails: partDetailsValue,
          salesPrice: salesPriceValue,
          priceVat: priceVatValue,
          quantity: quantity.value,
          changeNow: changeNowValue,
          changeOnPM: changePMValue,
          unitMeasure: unitMeasureValue,
          additional: 1));
    }
  }
}
