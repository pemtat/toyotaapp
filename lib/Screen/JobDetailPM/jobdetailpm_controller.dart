import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/batteryreport_model.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/pmjobinfo_model.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
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

class JobDetailControllerPM extends GetxController {
  final notes = TextEditingController().obs;
  var notesFiles = <Notes>[].obs;
  final comment = TextEditingController().obs;
  final comment2 = TextEditingController().obs;
  var subJobSparePart = <SubJobSparePart>[].obs;
  var reportList = <BatteryReportModel>[].obs;
  var pmInfo = <PMJobInfoModel>[].obs;
  var pmJobs = <PmModel>[].obs;
  var reportPreventiveList = <PreventivereportModel>[].obs;
  var reportPreventiveListIc = <PreventivereportModel>[].obs;
  var saveCompletedtime = ''.obs;
  var isPicking = false.obs;
  var commentCheck = false.obs;
  var canEdit = true.obs;
  var issueData = [].obs;
  var saveCompletedtime2 = ''.obs;
  var attatchments = <Map<String, dynamic>>[].obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var completeCheck = false.obs;
  var moreTicketDetail = false.obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var issueId;
  var jobId;
  var userData = <UserById>[].obs;
  PmModel? pmData;
  Rx<CustomerById> customer = CustomerById.getEmpty().obs;
  var pdfList = <Map<String, dynamic>>[].obs;
  var status = RxString('');
  List<String> notePic = [];
  var imagesBefore = <Map<String, String>>[].obs;
  var imagesAfter = <Map<String, String>>[].obs;
  var savedDateStartTime = ''.obs;
  var savedDateEndTime = ''.obs;
  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;

  final HomeController jobController = Get.put(HomeController());
  final BottomBarController bottomController = Get.put(BottomBarController());

  Future<void> fetchData(String ticketId) async {
    reportList = <BatteryReportModel>[].obs;
    reportPreventiveList = <PreventivereportModel>[].obs;
    reportPreventiveListIc = <PreventivereportModel>[].obs;
    jobId = ticketId;
    final String apiUrl = getTicketbyId(ticketId);

    String? token = await getToken();

    canEdit.value = true;
    await fetchBatteryReportData(jobId, token ?? '', reportList);
    await fetchPreventiveReportData(jobId, token ?? '', reportPreventiveList);
    await fetchPreventiveICReportData(
        jobId, token ?? '', reportPreventiveListIc);
    await fetchPMJob(ticketId, token ?? '', pmJobs);
    await fetchPmJobInfo(jobId, token ?? '', pmInfo);
    if (reportList.isNotEmpty ||
        (reportPreventiveList.isNotEmpty &&
            reportPreventiveList.first.pvtMaintenance != null) ||
        (reportPreventiveListIc.isNotEmpty &&
            reportPreventiveListIc.first.pvtMaintenance != null)) {
      completeCheck.value = true;
      await fetchSubJobSparePartIdPM();
    }
    savedDateStartTime = ''.obs;
    savedDateEndTime = ''.obs;
    comment2.value.clear();
    if (pmInfo.first.comment != null && pmInfo.first.comment != '') {
      comment.value.text = pmInfo.first.comment ?? '';
    } else {
      comment.value.text = '';
    }
    if (pmInfo.first.tStart != null && pmInfo.first.tStart != '') {
      DateTime startTime = DateTime.parse(pmInfo.first.tStart!);
      DateTime adjustedStartTime = startTime.add(const Duration(hours: 7));

      String formattedStartTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(adjustedStartTime);

      savedDateStartTime.value = formattedStartTime;
    }
    if (pmInfo.first.tEnd != null && pmInfo.first.tEnd != '') {
      DateTime endTime = DateTime.parse(pmInfo.first.tEnd!);
      DateTime adjustedEndTime = endTime.add(const Duration(hours: 7));

      String formattedEndTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(adjustedEndTime);

      savedDateEndTime.value = formattedEndTime;
    }
    if (imagesBefore.isNotEmpty) {
      imagesBefore.clear();
    }
    if (imagesAfter.isNotEmpty) {
      imagesAfter.clear();
    }
    try {
      if (pmInfo.first.jobImageStart!.isNotEmpty) {
        List<dynamic> imageBeforeList = pmInfo.first.jobImageStart!;
        imagesBefore.clear();
        for (int i = 0; i < imageBeforeList.length; i++) {
          imagesBefore.add({
            'id': imageBeforeList[i].id,
            'filename': imageBeforeList[i].name,
            'content': imageBeforeList[i].imgUrl,
          });
        }
      }

      if (pmInfo.first.jobImageEnd!.isNotEmpty) {
        List<dynamic> imageAfterList = pmInfo.first.jobImageEnd!;
        imagesAfter.clear();
        for (int i = 0; i < imageAfterList.length; i++) {
          imagesAfter.add({
            'id': imageAfterList[i].id,
            'filename': imageAfterList[i].name,
            'content': imageAfterList[i].imgUrl,
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
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

  Future<void> fetchSubJobSparePartIdPM() async {
    try {
      jobController.subJobSparePart.refresh();
      subJobSparePart.clear();
      final filteredSpareParts = jobController.subJobSparePart
          .where((element) => element.bugId == jobId)
          .toList();

      subJobSparePart.value = filteredSpareParts;
      subJobSparePart.refresh();
    } catch (e) {
      print(e);
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
      await http.post(
        Uri.parse(addNoteUrl),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      fetchData(issueId.toString());
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
      fetchData(issueId.toString());
      notes.value.clear();
    }
  }

  void showCompletedDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          rightColor: red1,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            showWaitMessageNew(context);
            saveCurrentDateTime(saveCompletedtime);
            changeIssueStatusPM(jobId, 103, comment.value.text);
            jobController.fetchDataFromAssignJob();
            Navigator.pop(context);
            showSaveMessageNew(context);
          },
        );
      },
    );
  }
}
