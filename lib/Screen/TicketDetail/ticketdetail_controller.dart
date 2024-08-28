import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Models/warrantybyid_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

class TicketDetailController extends GetxController {
  final notes = TextEditingController().obs;
  var pdfList = <Map<String, dynamic>>[].obs;
  var issueData = [].obs;
  var reportList = <RepairReportModel>[].obs;
  var additionalReportList = <RepairReportModel>[].obs;
  var savedDateStartTime = ''.obs;
  var warrantyInfo = <WarrantybyIdModel>[].obs;
  var customerInfo = <CustomerById>[].obs;
  var subJobSparePart = <SubJobSparePart>[].obs;
  var savedDateEndTime = ''.obs;
  var imagesBefore = <Map<String, String>>[].obs;
  var imagesAfter = <Map<String, String>>[].obs;
  var notesFiles = <Notes>[].obs;
  var moreTicketDetail = false.obs;
  var attatchments = <Map<String, dynamic>>[].obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var userData = <UserById>[].obs;

  var issueId;
  var jobId = ''.obs;
  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;
  var subJobs = <SubJobDetail>[].obs;

  final HomeController jobController = Get.put(HomeController());
  void fetchData(String ticketId, subjobId) async {
    final String apiUrl = getTicketbyId(ticketId);
    jobId.value = subjobId;
    String? token = await getToken();
    await fetchReportData(
        subjobId, token ?? '', reportList, additionalReportList);
    await fetchSubJob(subjobId, token ?? '', subJobs);
    await fetchUserById(subJobs.first.reporterId ?? '', userData);
    await fetchWarrantyById(ticketId, token ?? '', warrantyInfo);

    await fetchgetCustomerInfo(
        userData.first.users!.first.companyId ?? '', customerInfo);
    if (reportList.isNotEmpty || additionalReportList.isNotEmpty) {
      await fetchSubJobSparePartId();
    }

    savedDateStartTime.value = subJobs.first.timeStart ?? '';
    savedDateEndTime.value = subJobs.first.timeEnd ?? '';
    try {
      if (subJobs.first.imageUrlBefore != null &&
          subJobs.first.imageUrlBefore != '') {
        List<dynamic> imageBeforeList =
            jsonDecode(subJobs.first.imageUrlBefore!);

        for (int i = 0; i < imageBeforeList.length; i++) {
          imagesBefore.add({
            'filename': '',
            'content': imageBeforeList[i],
          });
        }
      }

      if (subJobs.first.imageUrlAfter != null &&
          subJobs.first.imageUrlAfter != '') {
        List<dynamic> imageAfterList = jsonDecode(subJobs.first.imageUrlAfter!);

        for (int i = 0; i < imageAfterList.length; i++) {
          imagesAfter.add({
            'filename': '',
            'content': imageAfterList[i],
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    // pdfList.clear;
    // fetchPdfData(ticketId, token ?? '', pdfList);

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      TicketByIdModel ticketModel = TicketByIdModel.fromJson(data);
      List<Issues>? issuesList = ticketModel.issues;
      issuesList!.map((issue) {
        issueId = issue.id;
        attatchments.clear;
        fetchReadAttachment(issueId, token ?? '', issue.attachments,
            attachmentsData, attatchments);
      }).toList();

      issueData.value = issuesList;
    } else {}
    notesFiles.assignAll(issueData.first.notes ?? []);
  }

  Future<void> fetchSubJobSparePartId() async {
    try {
      subJobSparePart.clear();
      final filteredSpareParts = jobController.subJobSparePart
          .where((element) => element.id == jobId.value)
          .toList();

      subJobSparePart.value = filteredSpareParts;
      subJobSparePart.refresh();
    } catch (e) {
      print(e);
    }
  }

  void showCompletedDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: complete,
        );
      },
    );
  }

  void complete() {}
}
