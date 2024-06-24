import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/pdfget.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

class PeddingtaskController extends GetxController {
  var issueData = [].obs;
  var attachments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var pdfList = <Map<String, dynamic>>[].obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var userData = <UserById>[].obs;

  var issueId;
  var jobId;
  var subJobs = <SubJobDetail>[].obs;
  var notesFiles = <Notes>[].obs;

  var attatchments = <Map<String, dynamic>>[].obs;

  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;

  void fetchData(String ticketId, String subjobId) async {
    final String apiUrl = getTicketbyId(ticketId);
    String? token = await getToken();

    await fetchPdfData(ticketId, token ?? '', pdfList);
    await fetchSubJob(subjobId, token ?? '', subJobs);
    await fetchUserById(subJobs.first.reporterId ?? '', userData);

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
        jobId = subjobId;

        fetchReadAttachment(issueId, token ?? '', issue.attachments,
            attachmentsData, attatchments);

        fetchNotes(issue.notes, notesFiles);
        checkWarranty(issue.serialNo ?? '', warrantyInfoList);
      }).toList();
      issueData.value = issuesList;
    } else {}
  }

  String formatDateTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd MMMM yyyy, HH:mm').format(parsedDate);
  }

  void showAcceptDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          rightColor: red1,
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            changeIssueStatus(issueId, 'confirmed');
            updateAcceptStatusSubjobs(jobId, issueId.toString(), '102');
          },
        );
      },
    );
  }
}
