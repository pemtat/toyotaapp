import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/sparepartseach.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/SparepartDetail_widget/addsparepart.dart';
import 'package:toyotamobile/Widget/SparepartDetail_widget/editsparepart.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class SparepartList extends GetxController {
  int space = 24;
  void sparePartListModal(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      enableDrag: false,
      builder: (BuildContext context) {
        return AddSparePartDetail(
          title: context.tr('pm_sparepart_1'),
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
      enableDrag: false,
      builder: (BuildContext context) {
        return EditSparePartDetail(
          title: context.tr('pm_sparepart_1'),
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
        );
      },
    );
  }

  var quantity = 1.obs;
  final searchPartNumber = TextEditingController().obs;
  var sparePartList = <SparePartModel>[].obs;
  final cCodePage = TextEditingController().obs;
  final partNumber = TextEditingController().obs;
  final partDetails = TextEditingController().obs;
  final unitMeasure = TextEditingController().obs;
  final changeNow = TextEditingController().obs;
  final changeonPM = TextEditingController().obs;
  var selections = List<String>.filled(2, '').obs;
  var selections2 = List<String>.filled(2, '').obs;
  var selectionsChoose = List<String>.filled(2, '').obs;
  var selectionsChoose2 = List<String>.filled(2, '').obs;
  var products = <Product>[].obs;
  var isLoading = false.obs;
}
