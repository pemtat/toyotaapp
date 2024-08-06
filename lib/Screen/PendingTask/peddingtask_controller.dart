import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Models/warrantybyid_model.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class PeddingtaskController extends GetxController {
  var issueData = [].obs;
  var attachments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  final cancelNote = TextEditingController().obs;

  var addAttatchments = <Map<String, dynamic>>[].obs;
  var pdfList = <Map<String, dynamic>>[].obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var userData = <UserById>[].obs;
  var warrantyInfo = <WarrantybyIdModel>[].obs;
  var customerInfo = <CustomerById>[].obs;
  var issueId;
  var jobId;
  var subJobs = <SubJobDetail>[].obs;
  var notesFiles = <Notes>[].obs;
  final notes = TextEditingController().obs;
  var isPicking = false.obs;
  List<String> notePic = [];
  var attatchments = <Map<String, dynamic>>[].obs;

  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;

  void fetchData(String ticketId, String subjobId) async {
    final String apiUrl = getTicketbyId(ticketId);
    String? token = await getToken();
    jobId = subjobId;
    // await fetchPdfData(ticketId, token ?? '', pdfList);
    await fetchSubJob(subjobId, token ?? '', subJobs);
    await fetchUserById(subJobs.first.reporterId ?? '', userData);
    await fetchWarrantyById(ticketId, token ?? '', warrantyInfo);
    await fetchgetCustomerInfo(
        userData.first.users!.first.companyId ?? '', customerInfo);
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

        fetchReadAttachment(issueId, token ?? '', issue.attachments,
            attachmentsData, attatchments);
      }).toList();
      issueData.value = issuesList;
      notesFiles.assignAll(issueData.first.notes ?? []);
    } else {}
  }

  void addNote(Rx<TextEditingController> textControllerRx) async {
    final String addNoteUrl = createNoteById(issueId);

    String? token = await getToken();
    TextEditingController textController = textControllerRx.value;

    String noteText = textController.text;
    if (addAttatchments.isNotEmpty && noteText != '') {
      var file = addAttatchments.first;
      String name = file['filename'];
      String content = file['content'];

      Map<String, dynamic> body = {
        "text": noteText,
        "view_state": {"name": "public"},
        "files": [
          {"name": name, "content": content}
        ]
      };
      await http.post(
        Uri.parse(addNoteUrl),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      await fetchNotes(issueId.toString(), notesFiles);
      notes.value.clear();
    } else if (addAttatchments.isNotEmpty && noteText == '') {
      showMessage('โปรดเพิ่ม Note');
    } else {
      Map<String, dynamic> body = {
        "text": noteText,
        "view_state": {"name": "public"},
      };
      await http.post(
        Uri.parse(addNoteUrl),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      await fetchNotes(issueId.toString(), notesFiles);
      notes.value.clear();
    }
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
            // changeIssueStatus(issueId, 'confirmed');

            updateAcceptStatusSubjobs(jobId, issueId.toString(), '102');
            jobController.fetchDataFromAssignJob();
            Navigator.pop(context);
            showSaveMessage();
          },
        );
      },
    );
  }
}
