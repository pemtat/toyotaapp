import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/batteryreport_model.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class PendingTaskControllerPM extends GetxController {
  final notes = TextEditingController().obs;
  final cancelNote = TextEditingController().obs;
  var notesFiles = <Notes>[].obs;
  final comment = TextEditingController().obs;
  var reportList = <BatteryReportModel>[].obs;
  var reportPreventiveList = <PreventivereportModel>[].obs;
  var userData = <UserById>[].obs;
  var pmJobs = <PmModel>[].obs;
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  var isPicking = false.obs;
  var issueData = [].obs;
  var confirm = false.obs;
  var moreHistory = false.obs;
  var attatchments = <Map<String, dynamic>>[].obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var moreTicketDetail = false.obs;

  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var issueId;
  var jobId;
  Rx<CustomerById> customer = CustomerById.getEmpty().obs;
  PmModel? pmData;
  var pdfList = <Map<String, dynamic>>[].obs;
  var status = RxString('');
  List<String> notePic = [];
  var imagesBefore = <Map<String, String>>[].obs;
  var imagesAfter = <Map<String, String>>[].obs;
  var savedDateStartTime = ''.obs;
  var savedDateEndTime = ''.obs;
  final RxInt expandedIndex = (-2).obs;

  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;

  final HomeController jobController = Get.put(HomeController());
  final BottomBarController bottomController = Get.put(BottomBarController());

  void fetchData(String ticketId) async {
    reportList = <BatteryReportModel>[].obs;
    reportPreventiveList = <PreventivereportModel>[].obs;
    jobId = ticketId;

    String? token = await getToken();
    final String apiUrl = getTicketbyId(ticketId);
    await fetchPMJob(ticketId, token ?? '', pmJobs);
    await fetchReadAttachmentList(ticketId, token ?? '', attatchments);
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
      issuesList!.map((issue) async {
        issueId = issue.id;
        // checkWarranty(
        //     issue.getCustomFieldValue('Serial No') ?? '', warrantyInfoList);
        // String customerNo = issue.getCustomFieldValue('Customer No') ?? '';
        // if (customerNo.isNotEmpty) {
        //   try {
        //     customer.value = await fetchCustomerInfo(customerNo);
        //   } catch (e) {
        //     customer.value = CustomerById.getEmpty();
        //   }
        // } else {
        //   customer.value = CustomerById.getEmpty();
        // }
      }).toList();
      issueData.value = issuesList;
    } else {}
    // await fetchUserById(
    //     issueData.first.history.first.user.id.toString(), userData);
    // notesFiles.assignAll(issueData.first.notes ?? []);
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
    }
  }

  void showTimeDialog(
    BuildContext context,
    String title,
    String left,
    String right,
    Rx<String> datetime,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          rightColor: red1,
          onRightButtonPressed: () {
            saveCurrentDateTime(datetime);
          },
        );
      },
    );
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
          onRightButtonPressed: () async {
            updateJobPM(jobId, 1, '-', issueData.first.customerStatus, 'yes');
            Navigator.pop(context);
            // createQuotation('', issueId, '2');
            showSaveMessageNew(context);
          },
        );
      },
    );
  }
}
