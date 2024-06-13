import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/pdfget.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class JobDetailController extends GetxController {
  final notes = TextEditingController().obs;
  final comment = TextEditingController().obs;
  var reportList = <RepairReportModel>[].obs;
  var pdfList = <Map<String, dynamic>>[].obs;
  var additionalReportList = <RepairReportModel>[].obs;
  var notesFiles = <Notes>[].obs;
  var isPicking = false.obs;
  var issueData = [].obs;
  List<String> notePic = [];
  var attatchments = <Map<String, dynamic>>[].obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var subJobs = <JobById>[].obs;
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

  void fetchData(String ticketId, String subjobId) async {
    final String apiUrl = getTicketbyId(ticketId);
    String? token = await getToken();
    jobId = ticketId;
    fetchReportData(subjobId, token ?? '');
    fetchPdfData(ticketId, token ?? '', pdfList);
    fetchSubJob(subjobId, token ?? '', subJobs);
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
        fetchNotesPic(issue.notes, notesFiles, notePic);
        checkWarranty(issue.serialNo ?? '', warrantyInfoList);
      }).toList();
      issueData.value = issuesList;
    } else {}
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

  Future<void> fetchReportData(String id, String token) async {
    try {
      final response = await http.get(
        Uri.parse(getRepairReportById(id)),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<RepairReportModel> loadedReports = responseData.map((reportJson) {
          return RepairReportModel.fromJson(reportJson);
        }).toList();

        reportList.value = loadedReports;
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await http.get(
        Uri.parse(getAdditionalRepairReportById(id)),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<RepairReportModel> loadedReports = responseData.map((reportJson) {
          return RepairReportModel.fromJson(reportJson);
        }).toList();

        additionalReportList.value = loadedReports;
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void addNote(Rx<TextEditingController> textControllerRx) async {
    final String addNoteUrl = createNoteById(issueId);

    String? token = await getToken();
    TextEditingController textController = textControllerRx.value;

    String noteText = textController.text;
    if (addAttatchments.isNotEmpty && noteText != '') {
      var file = addAttatchments.first;
      String name = file['name'];
      String content = file['base64'];

      Map<String, dynamic> body = {
        "text": noteText,
        "view_state": {"name": "public"},
        "files": [
          {"name": name, "content": content}
        ]
      };
      final response = await http.post(
        Uri.parse(addNoteUrl),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        fetchData(issueId.toString(), jobId.toString());
        notes.value.clear();
      }
    } else if (addAttatchments.isNotEmpty && noteText == '') {
      showMessage('โปรดเพิ่ม Note');
    } else {
      Map<String, dynamic> body = {
        "text": noteText,
        "view_state": {"name": "public"},
      };
      final response = await http.post(
        Uri.parse(addNoteUrl),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 201) {
        fetchData(issueId.toString(), jobId);
        notes.value.clear();
      }
    }
  }

  void addAttachment(Map<String, String> file) {
    addAttatchments.add(file);
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
          onRightButtonPressed: () {
            changeIssueStatus(issueId, 'closed');
          },
        );
      },
    );
  }
}
