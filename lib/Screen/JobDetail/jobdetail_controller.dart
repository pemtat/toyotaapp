import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/pdfget.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Models/warrantytruckbyid.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class JobDetailController extends GetxController {
  final notes = TextEditingController().obs;
  final comment = TextEditingController().obs;
  var reportList = <RepairReportModel>[].obs;
  var pdfList = <Map<String, dynamic>>[].obs;
  var additionalReportList = <RepairReportModel>[].obs;
  var warrantyInfo = <WarrantyTruckbyId>[].obs;
  var notesFiles = <Notes>[].obs;
  var isPicking = false.obs;
  var issueData = [].obs;
  var customerInfo = <CustomerById>[].obs;

  var saveCompletedtime = ''.obs;
  List<String> notePic = [];
  var attatchments = <Map<String, dynamic>>[].obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var userData = <UserById>[].obs;
  var isSignatureEmpty = true.obs;
  var subJobs = <SubJobDetail>[].obs;
  var moreTicketDetail = false.obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var issueId;
  var jobId;
  var status = RxString('');
  var imagesBefore = <Map<String, String>>[].obs;
  var imagesAfter = <Map<String, String>>[].obs;
  var savedDateStartTime = ''.obs;
  var savedDateEndTime = ''.obs;

  final HomeController jobController = Get.put(HomeController());
  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;
  final BottomBarController bottomController = Get.put(BottomBarController());

  Future<void> fetchData(String ticketId, String subjobId) async {
    try {
      final String apiUrl = getTicketbyId(ticketId);
      String? token = await getToken();

      issueId = ticketId;
      jobId = subjobId;
      pdfList.clear;
      fetchReportData(subjobId, token ?? '', reportList, additionalReportList);
      fetchPdfData(ticketId, token ?? '', pdfList);
      await fetchSubJob(subjobId, token ?? '', subJobs);
      await fetchUserById(subJobs.first.reporterId ?? '', userData);
      await fetchWarrantyById(ticketId, token ?? '', warrantyInfo);
      await fetchgetCustomerInfo(
          userData.first.users!.first.companyId ?? '', customerInfo);
      savedDateStartTime.value =
          formatDateTimeCut(subJobs.first.timeStart ?? '');
      savedDateEndTime.value = formatDateTimeCut(subJobs.first.timeEnd ?? '');
      if (imagesBefore.isNotEmpty) imagesBefore.clear();

      if (imagesAfter.isNotEmpty) imagesAfter.clear();
      try {
        if (subJobs.first.imageBefore != '' &&
            subJobs.first.contentBefore != '') {
          List<dynamic> imageBeforeList =
              jsonDecode(subJobs.first.imageBefore!);
          List<dynamic> contentBeforeList =
              jsonDecode(subJobs.first.contentBefore!);

          for (int i = 0; i < imageBeforeList.length; i++) {
            imagesBefore.add({
              'filename': imageBeforeList[i],
              'content': contentBeforeList[i],
            });
          }
        }

        if (subJobs.first.imageAfter != '' &&
            subJobs.first.contentAfter != '') {
          List<dynamic> imageAfterList = jsonDecode(subJobs.first.imageAfter!);
          List<dynamic> contentAfterList =
              jsonDecode(subJobs.first.contentAfter!);

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
          attatchments.clear();

          fetchReadAttachment(issueId, token ?? '', issue.attachments,
              attachmentsData, attatchments);
          fetchNotesPic(issue.notes, notesFiles, notePic);
          checkWarranty(issue.serialNo ?? '', warrantyInfoList);
        }).toList();
        issueData.value = issuesList;
      } else {}
    } catch (e) {
      Get.to(() => BottomBarView());
    }
  }

  void completeJob() async {
    final String updateStatus = updateIssueStatusById(issueId);

    String? token = await getToken();
    Map<String, dynamic> body = {
      "status": {"name": "closed"}
    };

    final response = await http.patch(
      Uri.parse(updateStatus),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      jobController.fetchDataFromAssignJob();
      bottomController.currentIndex.value = 0;
      Get.offAll(() => BottomBarView());
    }
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
      http.post(
        Uri.parse(addNoteUrl),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      fetchData(issueId.toString(), jobId.toString());
      notes.value.clear();
    } else if (addAttatchments.isNotEmpty && noteText == '') {
      showMessage('โปรดเพิ่ม Note');
    } else {
      Map<String, dynamic> body = {
        "text": noteText,
        "view_state": {"name": "public"},
      };
      http.post(
        Uri.parse(addNoteUrl),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      fetchData(issueId.toString(), jobId.toString());
      notes.value.clear();
    }
  }

  void showCompletedDialog(
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
            saveCurrentDateTime(saveCompletedtime);
            updateStatusSubjobs(jobId, comment.value.text, issueId.toString());
            jobController.fetchDataFromAssignJob();
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
