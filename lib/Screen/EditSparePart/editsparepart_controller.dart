import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/sparepart_model.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/btr_sparepartlist.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/pvt_sparepartlist.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
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
  final List<Sparepart> btrSparepart = [];
  final List<Sparepart> pvtSparepart = [];
  final HomeController jobController = Get.put(HomeController());
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final BtrSparepartList btrSparepartListController =
      Get.put(BtrSparepartList());
  final PvtSparepartList pvtSparepartListController =
      Get.put(PvtSparepartList());
  final rejectNote = TextEditingController().obs;
  var saveCompletedtime = ''.obs;
  var jobId = ''.obs;
  var bugId = ''.obs;
  var projectId = ''.obs;
  var readOnly = ''.obs;
  void fetchForm(
      String jobId,
      String bugId,
      List<Sparepart> sparepart,
      List<Sparepart> additionalSparepart,
      List<Sparepart> btrSparepart,
      List<Sparepart> pvtSparepart,
      String projectId) async {
    this.jobId.value = jobId;
    this.bugId.value = bugId;
    this.projectId.value = projectId;
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

    for (var reportDataList in btrSparepart) {
      if (reportDataList.quantity != '0') {
        btrSparepartListController.btrSparePartList.add(SparePartModel(
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
      }
    }
    for (var reportDataList in pvtSparepart) {
      if (reportDataList.quantity != '0') {
        pvtSparepartListController.pvtSparePartList.add(SparePartModel(
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
                      jobController.techLevel.value,
                      jobController.handlerIdTech.value,
                      rejectNote.value.text,
                      'update_sparepart',
                      bugId.value,
                      '',
                      '',
                      projectId.value);
                  if (projectId.value == '1') {
                    saveReport(context);
                  } else {
                    saveReportPM(context);
                  }
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
              if (projectId.value == '1') {
                saveReport(context);
              } else {
                saveReportPM(context);
              }
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
      //Jobs
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
          } else {
            print('Failed to save sparepart: ${response.body}');
          }
        } catch (e) {
          print('Error occurred while saving sparepart: $e');
        }
      }

      if (btrSparepartListController.btrSparePartList.isEmpty) {
        final SparePartModel defaultSparePartBtr = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          quantity: 0,
          additional: 0,
          relationId: "",
          unitMeasure: "-",
          salesPrice: "0",
          priceVat: "0",
        );

        btrSparepartListController.btrSparePartList.add(defaultSparePartBtr);
      }
      List<Map<String, dynamic>> btrSparePartList =
          btrSparepartListController.btrSparePartList.map((sparePart) {
        var price = double.tryParse(sparePart.salesPrice) ?? 0.0;
        return {
          "c_code": sparePart.cCodePage,
          "part_number": sparePart.partNumber,
          "description": sparePart.partDetails,
          "quantity": sparePart.quantity,
          "additional": "recommended",
          "relation_id": "",
          "unit_of_measure": sparePart.unitMeasure,
          "price": price,
          "price_includes_vat": sparePart.priceVat == '1' ? 1 : 0
        };
      }).toList();

      final Map<String, dynamic> data = {
        "job_id": bugId.value,
        "job_issue_id": jobId.value,
        "created_by": int.parse(jobController.handlerIdTech.value),
        "btr_sparepart": btrSparePartList,
      };

      try {
        final response = await http.post(Uri.parse(updateJobsSparepartBtr()),
            headers: {
              'Authorization': '$token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data));

        if (response.statusCode == 200) {
          print('Btr Sparepart Updated successfully');
        } else {
          print('Failed to save sparepart: ${response.body}');
        }
      } catch (e) {
        print('Error occurred while saving sparepart: $e');
      }

      await fetchSubJobSparePartOption();
      await fetchReportData(
          jobId.value,
          token ?? '',
          jobDetailController.reportList,
          jobDetailController.additionalReportList);
      await fetchJobBatteryReportData(
          jobId.value, token ?? '', jobDetailController.reportBatteryList);
      await jobDetailController.fetchSubJobSparePartId();
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveReportPM(BuildContext context) async {
    String? token = await getToken();
    try {
      //Btr
      if (btrSparepartListController.btrSparePartList.isEmpty) {
        final SparePartModel defaultSparePartBtr = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          quantity: 0,
          additional: 0,
          relationId: "",
          unitMeasure: "-",
          salesPrice: "0",
          priceVat: "0",
        );

        btrSparepartListController.btrSparePartList.add(defaultSparePartBtr);
      }
      List<Map<String, dynamic>> btrSparePartList =
          btrSparepartListController.btrSparePartList.map((sparePart) {
        var price = double.tryParse(sparePart.salesPrice) ?? 0.0;
        return {
          "c_code": sparePart.cCodePage,
          "part_number": sparePart.partNumber,
          "description": sparePart.partDetails,
          "quantity": sparePart.quantity,
          "additional": "recommended",
          "relation_id": "",
          "unit_of_measure": sparePart.unitMeasure,
          "price": price,
          "price_includes_vat": sparePart.priceVat == '1' ? 1 : 0
        };
      }).toList();

      final Map<String, dynamic> data = {
        "job_id": bugId.value,
        "job_issue_id": '0',
        "created_by": int.parse(jobController.handlerIdTech.value),
        "btr_sparepart": btrSparePartList,
      };

      try {
        final response = await http.post(Uri.parse(updateSparepartBtr()),
            headers: {
              'Authorization': '$token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data));

        if (response.statusCode == 200) {
          print('Btr Sparepart Updated successfully');
        } else {
          print('Failed to save sparepart: ${response.body}');
        }
      } catch (e) {
        print('Error occurred while saving sparepart: $e');
      }

      if (pvtSparepartListController.pvtSparePartList.isEmpty) {
        final SparePartModel defaultSparePartPvt = SparePartModel(
          cCodePage: "-",
          partNumber: "-",
          partDetails: "-",
          quantity: 0,
          additional: 0,
          relationId: "",
          unitMeasure: "-",
          salesPrice: "0",
          priceVat: "0",
        );

        pvtSparepartListController.pvtSparePartList.add(defaultSparePartPvt);
      }
      List<Map<String, dynamic>> sparePartListPvt = pvtSparepartListController
          .pvtSparePartList
          .asMap()
          .entries
          .map((entry) {
        int index = entry.key + 1;

        SparePartModel sparePart = entry.value;
        var price = double.tryParse(sparePart.salesPrice) ?? 0.0;
        return {
          "no": index,
          "page_code": sparePart.cCodePage,
          "description": sparePart.partDetails,
          "part_number": sparePart.partNumber,
          "qty": sparePart.quantity,
          "unit_of_measure": sparePart.unitMeasure,
          "price": price,
          "price_includes_vat": sparePart.priceVat == '1' ? 1 : 0
        };
      }).toList();
      final Map<String, dynamic> data2 = {
        "job_id": bugId.value,
        "created_by": int.parse(jobController.handlerIdTech.value),
        "dar_details": sparePartListPvt,
      };
      try {
        final response = await http.post(Uri.parse(updateSparepartPvt()),
            headers: {
              'Authorization': '$token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data2));

        if (response.statusCode == 200) {
          print('Pvt Sparepart Updated successfully');
        } else {
          print('Failed to save sparepart: ${response.body}');
        }
      } catch (e) {
        print('Error occurred while saving sparepart: $e');
      }

      await fetchSubJobSparePartOption();
      await fetchBatteryReportData(
          bugId.value, token ?? '', jobDetailControllerPM.reportList);
      await fetchPreventiveReportData(
          bugId.value, token ?? '', jobDetailControllerPM.reportPreventiveList);
      await jobDetailControllerPM.fetchSubJobSparePartIdPM();
    } catch (e) {
      print(e);
    }
  }
}
