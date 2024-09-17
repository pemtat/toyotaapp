import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class EditSparePartController extends GetxController {
  final List<Sparepart> sparepart = [];
  final List<Sparepart> additionalSparepart = [];
  final HomeController jobController = Get.put(HomeController());
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final rejectNote = TextEditingController().obs;
  var saveCompletedtime = ''.obs;
  var jobId = ''.obs;
  var readOnly = ''.obs;
  void fetchForm(String jobId, List<Sparepart> sparepart,
      final List<Sparepart> additionalSparepart) async {
    this.jobId.value = jobId;

    for (var reportDataList in sparepart + additionalSparepart) {
      if (reportDataList.additional == false &&
          reportDataList.quantity != '0') {
        sparePartListController.sparePartList.add(SparePartModel(
            cCodePage: reportDataList.cCode ?? '1',
            partNumber: reportDataList.partNumber ?? '',
            partDetails: reportDataList.description ?? '',
            unitMeasure: reportDataList.unitMeasure ?? '',
            salesPrice: reportDataList.salesPrice ?? '0',
            priceVat: reportDataList.priceVat == true ? '1' : '0',
            quantity: int.parse(reportDataList.quantity ?? ''),
            changeNow: reportDataList.changeNow ?? '',
            changeOnPM: reportDataList.changeOnPm ?? '',
            additional: 0));
      } else if (reportDataList.additional == true &&
          reportDataList.quantity != '0') {
        additSparePartListController.additSparePartList.add(SparePartModel(
            cCodePage: reportDataList.cCode ?? '1',
            partNumber: reportDataList.partNumber ?? '',
            partDetails: reportDataList.description ?? '',
            unitMeasure: reportDataList.unitMeasure ?? '',
            salesPrice: reportDataList.salesPrice ?? '0',
            priceVat: reportDataList.priceVat == true ? '1' : '0',
            quantity: int.parse(reportDataList.quantity ?? ''),
            changeNow: reportDataList.changeNow ?? '',
            changeOnPM: reportDataList.changeOnPm ?? '',
            additional: 1));
      }
    }
  }

  void showSavedDialog(
      BuildContext context, String title, String left, String right) async {
    if (jobController.techLevel.value == '2') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: white4,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.kH,
                TextFieldType(
                  hintText: 'Remark',
                  textSet: rejectNote.value,
                  maxLine: 5,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyleList.text1,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await updateJobSparePart(
                      jobId.value,
                      jobController.techManageId.value,
                      jobController.techLevel.value,
                      jobController.handlerIdTech.value,
                      rejectNote.value.text,
                      'update_sparepart');
                  saveReport(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Yes',
                  style: TextStyleList.text1,
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogAlert(
            title: title,
            leftButton: left,
            rightButton: right,
            rightColor: red1,
            onRightButtonPressed: () {
              saveReport(context);
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  Future<void> saveReport(BuildContext context) async {
    String? token = await getToken();
    try {
      List<SparePartModel> allSpareParts =
          List.from(sparePartListController.sparePartList);
      allSpareParts.addAll(additSparePartListController.additSparePartList);
      if (sparePartListController.sparePartList.isEmpty) {
        final SparePartModel defaultSparePart = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          unitMeasure: "-",
          salesPrice: "0",
          priceVat: '0',
          quantity: 0,
          changeNow: "-",
          changeOnPM: "-",
          additional: 0,
        );

        allSpareParts.add(defaultSparePart);
      }
      if (additSparePartListController.additSparePartList.isEmpty) {
        final SparePartModel defaultSparePart = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          unitMeasure: "-",
          salesPrice: "0",
          priceVat: '0',
          quantity: 0,
          changeNow: "-",
          changeOnPM: "-",
          additional: 1,
        );

        allSpareParts.add(defaultSparePart);
      }

      if (allSpareParts.isNotEmpty) {
        final body = {
          'job_issue_id': jobId.value,
          'sparepart':
              allSpareParts.map((sparePart) => sparePart.toJson()).toList(),
        };
        try {
          final response = await http.post(Uri.parse(updateSparepart()),
              headers: {
                'Authorization': '$token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(body));

          if (response.statusCode == 200) {
            print('Sparepart Updated successfully');
            await fetchSubJobSparePartOption();
            await fetchReportData(
                jobId.value,
                token ?? '',
                jobDetailController.reportList,
                jobDetailController.additionalReportList);
            await jobDetailController.fetchSubJobSparePartId();
          } else {
            print('Failed to save sparepart: ${response.body}');
          }
        } catch (e) {
          print('Error occurred while saving sparepart: $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
