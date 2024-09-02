import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/sparepartseach.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/SparepartDetail_widget/addsparepart.dart';
import 'package:toyotamobile/Widget/SparepartDetail_widget/editsparepart.dart';

class SparepartList extends GetxController {
  void sparePartListModal(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddSparePartDetail(
          title: 'Spare Part List',
          cCodePage: cCodePage,
          searchPartNumber: searchPartNumber,
          isLoading: isLoading,
          products: products,
          partNumber: partNumber,
          partDetails: partDetails,
          unitMeasure: unitMeasure,
          quantity: quantity,
          selectionsChoose: selectionsChoose,
          selectionsChoose2: selectionsChoose2,
          selections: selections,
          selections2: selections2,
          sparePartList: sparePartList,
          changeShow: 'yes',
          additional: '0',
        );
      },
    );
  }

  void sparePartListEditModal(BuildContext context, SparePartModel part) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return EditSparePartDetail(
          title: 'Spare Part List',
          part: part,
          cCodePage: cCodePage,
          searchPartNumber: searchPartNumber,
          isLoading: isLoading,
          products: products,
          partNumber: partNumber,
          partDetails: partDetails,
          unitMeasure: unitMeasure,
          quantity: quantity,
          selectionsChoose: selectionsChoose,
          selectionsChoose2: selectionsChoose2,
          selections: selections,
          selections2: selections2,
          sparePartList: sparePartList,
          changeShow: 'yes',
        );
      },
    );
  }

  var quantity = 1.obs;
  var sparePartList = <SparePartModel>[].obs;
  final searchPartNumber = TextEditingController().obs;
  final cCodePage = TextEditingController().obs;
  final partNumber = TextEditingController().obs;
  final partDetails = TextEditingController().obs;
  final unitMeasure = TextEditingController().obs;
  var selections = List<String>.filled(2, '').obs;
  var selections2 = List<String>.filled(2, '').obs;
  var selectionsChoose = List<String>.filled(2, '').obs;
  var selectionsChoose2 = List<String>.filled(2, '').obs;
  var products = <Product>[].obs;
  var isLoading = false.obs;
}
