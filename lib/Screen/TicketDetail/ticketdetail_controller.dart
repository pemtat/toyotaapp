import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/jobprogress_model.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
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
  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;
  var subJobs = <SubJobDetail>[].obs;

  final List<JobItemData> jobTimeLineItems = [
    JobItemData(
        imagePath: 'assets/search.png',
        jobid: '0001',
        description: 'Investigation issue ',
        datetime: '28 January 2024 at 08:15 PM',
        status: 'done'),
    JobItemData(
        imagePath: 'assets/briefcase.png',
        jobid: '0002',
        description: 'Replace spare parts',
        datetime: '29 January 2024 at 15:10 PM',
        status: 'pending'),
    JobItemData(
        imagePath: 'assets/briefcase.png',
        jobid: '0003',
        description: 'Replace spare parts',
        datetime: '30 January 2024 at 10:20 PM',
        status: 'pending'),
  ];

  final HomeController jobController = Get.put(HomeController());
  void fetchData(String ticketId, subjobId) async {
    final String apiUrl = getTicketbyId(ticketId);
    String? token = await getToken();
    await fetchReportData(
        subjobId, token ?? '', reportList, additionalReportList);
    await fetchSubJob(subjobId, token ?? '', subJobs);
    await fetchUserById(subJobs.first.reporterId ?? '', userData);
    await fetchWarrantyById(ticketId, token ?? '', warrantyInfo);

    await fetchgetCustomerInfo(
        userData.first.users!.first.companyId ?? '', customerInfo);
    savedDateStartTime.value = subJobs.first.timeStart ?? '';
    savedDateEndTime.value = subJobs.first.timeEnd ?? '';
    try {
      if (subJobs.first.imageBefore != '' &&
          subJobs.first.contentBefore != '') {
        List<dynamic> imageBeforeList = jsonDecode(subJobs.first.imageBefore!);
        List<dynamic> contentBeforeList =
            jsonDecode(subJobs.first.contentBefore!);
        imagesBefore.clear();
        for (int i = 0; i < imageBeforeList.length; i++) {
          imagesBefore.add({
            'filename': imageBeforeList[i],
            'content': contentBeforeList[i],
          });
        }
      }

      if (subJobs.first.imageAfter != '' && subJobs.first.contentAfter != '') {
        List<dynamic> imageAfterList = jsonDecode(subJobs.first.imageAfter!);
        List<dynamic> contentAfterList =
            jsonDecode(subJobs.first.contentAfter!);
        imagesAfter.clear();
        for (int i = 0; i < contentAfterList.length; i++) {
          imagesAfter.add({
            'filename': imageAfterList[i],
            'content': contentAfterList[i],
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
