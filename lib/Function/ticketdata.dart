import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/pdfget.dart';
import 'package:toyotamobile/Models/batteryreport_model.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/pmcommentjob_model.dart';
import 'package:toyotamobile/Models/pmjobinfo_model.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/warrantybyid_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart' as ticket;

final BottomBarController bottomController = Get.put(BottomBarController());
final HomeController jobController = Get.put(HomeController());
final JobDetailController jobDetailController = Get.put(JobDetailController());
final JobDetailControllerPM jobDetailControllerPM =
    Get.put(JobDetailControllerPM());

Future<void> fetchSubJob(
    String subjobId, String token, RxList<SubJobDetail> subJobs) async {
  try {
    final response = await http.get(
      Uri.parse(getSubJobById(subjobId)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      List<SubJobDetail> dataList =
          jsonResponse.map((json) => SubJobDetail.fromJson(json)).toList();
      subJobs.assignAll(dataList);
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchUserByZone(
    String zone, String token, RxList<UsersZone> userByZone) async {
  try {
    final response = await http.get(
      Uri.parse(getUserByZone(zone)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      UserByZone userData = UserByZone.fromJson(data);

      if (userData.users != null) {
        userByZone.assignAll(userData.users!);
      } else {}
    } else {
      print('Failed to load data: ${response.statusCode}');
      userByZone.clear();
    }
  } catch (e) {
    print('Error: $e');
    userByZone.clear();
  }
}

Future<void> fetchCommentSubJob(
    String subjobId, Rx<TextEditingController> comment) async {
  String? token = await getToken();
  try {
    final response = await http.get(
      Uri.parse(getSubJobById(subjobId)),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      List<SubJobDetail> dataList =
          jsonResponse.map((json) => SubJobDetail.fromJson(json)).toList();
      comment.value.text = dataList.first.comment ?? '';
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchNotes(String ticketId, RxList<Notes> notesFiles) async {
  String? token = await getToken();
  final response = await http.get(
    Uri.parse(getTicketbyId(ticketId)),
    headers: {
      'Authorization': '$token',
    },
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    TicketByIdModel ticketModel = TicketByIdModel.fromJson(data);
    List<Issues>? issuesList = ticketModel.issues;
    issuesList!.map((issue) {
      notesFiles.clear();
      notesFiles.assignAll(issue.notes ?? []);
      notesFiles.refresh();
    }).toList();
  } else {
    notesFiles.refresh();
  }
  notesFiles.refresh();
}

Future<void> fetchWarrantyById(
    String ticketId, String token, RxList<WarrantybyIdModel> info) async {
  try {
    final response = await http.get(
      Uri.parse(getWarrantyTruckByTicketId(ticketId)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      List<WarrantybyIdModel> dataList =
          jsonResponse.map((json) => WarrantybyIdModel.fromJson(json)).toList();
      info.assignAll(dataList);
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchUserById(String id, RxList<UserById> userData) async {
  String? token = await getToken();
  final response = await http.get(
    Uri.parse(getUserInfoById(id)),
    headers: {
      'Authorization': '$token',
    },
  );
  if (response.statusCode == 200) {
    final dynamic responseData = jsonDecode(response.body);

    if (responseData is Map<String, dynamic>) {
      UserById user = UserById.fromJson(responseData);
      userData.value = [user];
    } else {
      print('Invalid data format');
    }
  } else {
    print('Failed to load data: ${response.statusCode}');
  }
}

Future<String> getReportById(
  String id,
) async {
  String? token = await getToken();
  final response = await http.get(
    Uri.parse(getUserInfoById(id)),
    headers: {
      'Authorization': '$token',
    },
  );
  if (response.statusCode == 200) {
    final dynamic responseData = jsonDecode(response.body);

    if (responseData is Map<String, dynamic>) {
      UserById user = UserById.fromJson(responseData);
      return user.users!.first.name ?? '';
    } else {
      print('Invalid data format');
      return '-';
    }
  } else {
    print('Failed to load data: ${response.statusCode}');
    return '-';
  }
}

Future<void> fetchReadAttachment(
    int issueId,
    String token,
    List<Attachments>? getAttachments,
    List<Map<String, dynamic>> attachmentsData,
    List<Map<String, dynamic>> attatchments) async {
  attatchments.clear();
  attachmentsData.clear();
  if (getAttachments != null) {
    var attachments = getAttachments as List<dynamic>;
    for (var attachment in attachments) {
      Map<String, dynamic> attachmentMap = {
        'id': attachment.id,
        'filename': attachment.filename,
      };
      attachmentsData.add(attachmentMap);
    }

    for (var attachment in attachmentsData) {
      int attachmentId = attachment['id'];
      final String getFileUrl = getAttachmentFileById(issueId, attachmentId);

      final response2 = await http.get(
        Uri.parse(getFileUrl),
        headers: {
          'Authorization': token,
        },
      );
      if (response2.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response2.body);
        var files = data['files'] as List<dynamic>;
        var fileData = files.map((file) {
          return {
            'id': file['id'],
            'filename': file['filename'],
            'content': file['content'],
          };
        }).toList();
        attatchments.addAll(fileData);
      } else {}
    }
  }
}

Future<void> fetchNotesPic(
  List<Notes>? notes,
  RxList<Notes> notesFiles,
) async {
  if (notes != null) {
    // ignore: unnecessary_cast
    var issueNotes = notes as List<Notes>;
    notesFiles.assignAll(issueNotes);

    // notesFiles.forEach((note) async {
    //   var reporterId = note.reporter!.id;
    //   notePic.add(await checkLevel(reporterId ?? 0));
    // });
  }
}

String calculateTimeDifference(RxString timeStart, RxString timeEnd) {
  // สมมติว่าเวลามีรูปแบบเป็น 'HH:mm'

  // แปลง RxString เป็น DateTime
  final format = DateFormat('yyyy-MM-dd HH:mm:ss');

  // แปลง RxString เป็น DateTime
  DateTime startTime = format.parse(timeStart.value);
  DateTime endTime = format.parse(timeEnd.value);

  // คำนวณส่วนต่างเวลา
  Duration difference = endTime.difference(startTime);

  // ดึงจำนวนชั่วโมงและนาทีจาก Duration
  int hours = difference.inHours;
  int minutes = difference.inMinutes.remainder(60);

  return '$hours ชั่วโมง $minutes นาที';
}

Future<void> fetchReportData(
  String id,
  String token,
  RxList<RepairReportModel> reportList,
  RxList<RepairReportModel> additionalReportList,
) async {
  try {
    final response = await http.get(
      Uri.parse(getRepairReportById(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      reportList.clear();
      List<dynamic> responseData = jsonDecode(response.body);
      List<RepairReportModel> loadedReports = responseData.map((reportJson) {
        return RepairReportModel.fromJson(reportJson);
      }).toList();

      reportList.value = loadedReports;
      reportList.refresh();
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
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      additionalReportList.clear();
      List<dynamic> responseData = jsonDecode(response.body);
      List<RepairReportModel> loadedReports = responseData.map((reportJson) {
        return RepairReportModel.fromJson(reportJson);
      }).toList();

      additionalReportList.value = loadedReports;
      additionalReportList.refresh();
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchBatteryReportData(
  String id,
  String token,
  RxList<BatteryReportModel> reportList,
) async {
  try {
    final response = await http.get(
      Uri.parse(getBatteryReportById(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;
      Map<String, dynamic>? responseData = jsonDecode(responseBody);
      BtrMaintenance? btrMaintenance;
      List<BtrSpareparts>? btrSpareparts;
      List<BtrConditions>? btrConditions;
      List<SpecicVoltageCheck>? specicVoltageCheck;

      if (responseData != null) {
        reportList.clear();
        btrMaintenance = responseData['btr_maintenance'] != null
            ? BtrMaintenance.fromJson(responseData['btr_maintenance'])
            : null;

        btrSpareparts = responseData['btr_spareparts'] != null
            ? List<BtrSpareparts>.from(responseData['btr_spareparts']
                .map((x) => BtrSpareparts.fromJson(x)))
            : [];

        btrConditions = responseData['btr_conditions'] != null
            ? List<BtrConditions>.from(responseData['btr_conditions']
                .map((x) => BtrConditions.fromJson(x)))
            : [];

        specicVoltageCheck = responseData['specic_voltage_check'] != null
            ? List<SpecicVoltageCheck>.from(responseData['specic_voltage_check']
                .map((x) => SpecicVoltageCheck.fromJson(x)))
            : [];
      } else {
        print('No data found');
      }

      BatteryReportModel batteryReport = BatteryReportModel(
        btrMaintenance: btrMaintenance,
        btrSpareparts: btrSpareparts,
        btrConditions: btrConditions,
        specicVoltageCheck: specicVoltageCheck,
      );

      reportList.add(batteryReport);
      reportList.refresh();
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchPreventiveReportData(
  String id,
  String token,
  RxList<PreventivereportModel> reportList,
) async {
  try {
    final response = await http.get(
      Uri.parse(getPreventiveReportById(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;
      Map<String, dynamic>? responseData = jsonDecode(responseBody);
      PvtMaintenance? pvtMaintenance;
      List<PvtCheckingTypeMaster>? pvtCheckingTypeMaster;
      List<DarDetails>? darDetails;
      List<MaintenanceRecords>? maintenanceRecords;

      if (responseData != null) {
        reportList.clear();
        pvtMaintenance = responseData['pvt_maintenance'] is Map<String, dynamic>
            ? PvtMaintenance.fromJson(responseData['pvt_maintenance'])
            : null;

        pvtCheckingTypeMaster = responseData['pvt_checking_type_master'] is List
            ? List<PvtCheckingTypeMaster>.from(
                responseData['pvt_checking_type_master']
                    .map((x) => PvtCheckingTypeMaster.fromJson(x)))
            : [];

        darDetails = responseData['dar_details'] is List
            ? List<DarDetails>.from(
                responseData['dar_details'].map((x) => DarDetails.fromJson(x)))
            : [];

        maintenanceRecords = responseData['maintenance_records'] is List
            ? List<MaintenanceRecords>.from(responseData['maintenance_records']
                .map((x) => MaintenanceRecords.fromJson(x)))
            : [];
      } else {
        print('No data found');
      }

      PreventivereportModel preventiveReport = PreventivereportModel(
          pvtMaintenance: pvtMaintenance,
          pvtCheckingTypeMaster: pvtCheckingTypeMaster,
          darDetails: darDetails,
          maintenanceRecords: maintenanceRecords);

      reportList.add(preventiveReport);
      reportList.refresh();
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchPmJobInfo(
  String id,
  String token,
  RxList<PMJobInfoModel> reportList,
) async {
  try {
    final response = await http.get(
      Uri.parse(getPmJobInfoById(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      reportList.clear();
      var data = jsonDecode(response.body);
      var pmJobInfo = PMJobInfoModel.fromJson(data);
      reportList.add(pmJobInfo);
      reportList.refresh();
    } else {}
  } catch (e) {
    print(e);
  }
}

Future<void> fetchPdfReport(
    String id, String token, RxString pdfReport, String option) async {
  try {
    String apiUrl = '';

    if (option == 'fieldreport') {
      apiUrl = getPdfFieldReportById(id);
    } else if (option == 'btr') {
      apiUrl = getPdfBtrReportById(id);
    } else {
      apiUrl = getPdfPvtReportById(id);
    }
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('pdf_base64')) {
        pdfReport.value = responseBody['pdf_base64'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_btr')) {
        pdfReport.value = responseBody['pdf_btr'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_report')) {
        pdfReport.value = responseBody['pdf_report'];
        pdfReport.refresh();
      } else {
        pdfReport.value = '';
        pdfReport.refresh();
      }
    } else {}
  } catch (e) {
    print(e);
  }
}

Future<void> fetchPmJobImg(String id, RxList<Map<String, String>> imagesBefore,
    RxList<Map<String, String>> imagesAfter, option) async {
  String? token = await getToken();
  try {
    final response = await http.get(
      Uri.parse(getPmJobInfoById(id)),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var pmJobInfo = PMJobInfoModel.fromJson(data);
      if (option == 'before') {
        if (pmJobInfo.jobImageStart!.isNotEmpty) {
          List<dynamic> imageBeforeList = pmJobInfo.jobImageStart!;
          imagesBefore.clear();
          for (int i = 0; i < imageBeforeList.length; i++) {
            imagesBefore.add({
              'id': imageBeforeList[i].id,
              'filename': imageBeforeList[i].name,
              'content': imageBeforeList[i].content,
            });
          }
          imagesBefore.refresh();
        }
      } else {
        if (pmJobInfo.jobImageEnd!.isNotEmpty) {
          List<dynamic> imageAfterList = pmJobInfo.jobImageEnd!;
          imagesAfter.clear();
          for (int i = 0; i < imageAfterList.length; i++) {
            imagesAfter.add({
              'id': imageAfterList[i].id,
              'filename': imageAfterList[i].name,
              'content': imageAfterList[i].content,
            });
          }
          imagesAfter.refresh();
        }
      }
    } else {}
  } catch (e) {
    print(e);
  }
}

Future<void> fetchPmJobInfo2(
    String id, String token, Rx<TextEditingController> comment) async {
  try {
    final response = await http.get(
      Uri.parse(getPmJobInfoById(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var pmJobInfo = PMJobInfoModel.fromJson(data);
      comment.value.text = pmJobInfo.comment ?? '';
    } else {}
  } catch (e) {
    print(e);
  }
}

Future<void> fetchCommentJobInfo(
    String id, String token, Rx<TextEditingController> comment) async {
  try {
    final response = await http.get(
      Uri.parse(getPmJobCommentById(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var pmJobInfo = PmJobComment.fromJson(data);
      comment.value.text = pmJobInfo.comment ?? '';
    } else {}
  } catch (e) {
    print(e);
  }
}

void addAttachment(
    Map<String, String> file, RxList<Map<String, dynamic>> addAttatchments) {
  addAttatchments.add(file);
}

Future<void> pickFile(
    RxList<Map<String, dynamic>> addAttatchments, Rx<bool> isPicking) async {
  if (isPicking.value) return;

  isPicking.value = true;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      String? filePath = result.files.single.path;
      String fileName = result.files.single.name;

      if (filePath != null) {
        io.File file = io.File(filePath);
        List<int> fileBytes = await file.readAsBytes();
        String base64Content = base64Encode(fileBytes);
        addAttachment({
          'filename': fileName,
          'path': filePath,
          'content': base64Content,
        }, addAttatchments);
      } else {}
    } else {}
  } finally {
    isPicking.value = false;
  }
}

void addNote(
    Rx<TextEditingController> textControllerRx,
    int issueId,
    String jobId,
    RxList<Map<String, dynamic>> addAttatchments,
    Rx<TextEditingController> notes,
    RxList<Map<String, dynamic>> pdfList) async {
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
    final response = await http.post(
      Uri.parse(addNoteUrl),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      fetchPdfData(issueId.toString(), jobId.toString(), pdfList);
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
      fetchPdfData(issueId.toString(), jobId, pdfList);
      notes.value.clear();
    }
  }
}

Future<void> pickImage(RxList<Map<String, String>> file, Rx<bool> isPicking,
    String option, String ticketId, String jobId) async {
  if (isPicking.value) return;
  isPicking.value = true;
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      io.File imageFile = io.File(pickedFile.path);
      String fileName = pickedFile.name;
      String base64Content = base64Encode(await imageFile.readAsBytes());
      file.add({
        'filename': fileName,
        'content': base64Content,
      });
      updateImgSubjobs(jobId, ticketId, file, option);
    }
  } finally {
    isPicking.value = false;
  }
}

Future<void> pickImagePM(
    RxList<Map<String, String>> file,
    Rx<bool> isPicking,
    String option,
    String jobId,
    String createById,
    RxList<Map<String, String>> imagesBefore,
    RxList<Map<String, String>> imagesAfter) async {
  if (isPicking.value) return;
  isPicking.value = true;
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      io.File imageFile = io.File(pickedFile.path);
      String fileName = pickedFile.name;
      String base64Content = base64Encode(await imageFile.readAsBytes());
      // file.add({
      //   'filename': fileName,
      //   'content': base64Content,
      // });

      Map<String, String> newImg = ({
        'filename': fileName,
        'content': base64Content,
      });

      await updateImgPMjobs(jobId, newImg, option, createById);
      await fetchPmJobImg(jobId, imagesBefore, imagesAfter, option);
    }
  } finally {
    isPicking.value = false;
  }
}

void showTimeDialog(
    BuildContext context,
    String title,
    String left,
    String right,
    Rx<String> datetime,
    String jobId,
    String option,
    String ticketId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DialogAlert(
        title: title,
        leftButton: left,
        rightButton: right,
        rightColor: red1,
        onRightButtonPressed: () {
          saveCurrentDateTimeToSubJob(datetime, jobId, option, ticketId);
        },
      );
    },
  );
}

void showTimeDialogPM(
  BuildContext context,
  String title,
  String left,
  String right,
  Rx<String> datetime,
  String jobId,
  String option,
  String createById,
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
          saveCurrentDateTimeToPMJob(datetime, jobId, option, createById);
        },
      );
    },
  );
}

void changeIssueStatus(int issueId, String status) async {
  final String updateStatus = updateIssueStatusById(issueId);

  String? token = await getToken();
  Map<String, dynamic> body = {
    "status": {"name": status}
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

Future<void> changeIssueStatusPM(
  String issueId,
  int status,
  String comment,
) async {
  final String updateStatus = updateJobStatusByIdPM();
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};
    if (comment != '-') {
      body = {"job_id": issueId, "status": status, "comment": comment};
    } else {
      body = {"job_id": issueId, "status": status};
    }
    final response = await http.post(
      Uri.parse(updateStatus),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 201) {
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> changeIssueStatusPMComment(
  String issueId,
  int status,
  String comment,
  Rx<TextEditingController> comment2,
) async {
  final String updateStatus = updateJobStatusByIdPM();
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};
    if (comment != '-') {
      body = {"job_id": issueId, "status": status, "comment": comment};
    } else {
      body = {"job_id": issueId, "status": status};
    }
    final response = await http.post(
      Uri.parse(updateStatus),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 201) {
      comment2.value.text = comment;
      comment2.refresh();
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> updateJobPM(String issueId, int status, String comment,
    String customerStatus, String refresh) async {
  final String updateStatus = updateTechInfoJob();
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};
    if (comment != '-') {
      body = {"job_id": issueId, "tech_status": status, "tech_remark": comment};
    } else {
      body = {"job_id": issueId, "tech_status": status, "tech_remark": null};
    }
    final response = await http.post(
      Uri.parse(updateStatus),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      if (status == 1) {
        await changeIssueStatusPM(
          issueId,
          102,
          '-',
        );
      }
      if (refresh == 'yes') {
        jobController.fetchDataFromAssignJob();
      }
      print('Update Done');
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> changeIssueSignaturePM(
  String issueId,
  String saveCompletedtime,
  String signature,
  String signaturePad,
  String option,
) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};
    if (option == 'battery') {
      body = {
        "job_id": issueId,
        "signature": signature,
        "signature_pad": signaturePad,
        "save_time": saveCompletedtime
      };

      final response2 = await http.post(
        Uri.parse(updateBatterySignature()),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response2.statusCode == 200) {
        print('update succesful');
      } else {
        return;
      }
    } else {
      body = {
        "job_id": issueId,
        "signature": signature,
        "signature_pad": signaturePad,
        "save_time": 0
      };
      final response2 = await http.post(
        Uri.parse(updatePreventiveSignature()),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response2.statusCode == 200) {
        print('update succesful');
      } else {
        return;
      }
    }
  } catch (e) {
    print(e);
  }
}

void saveCurrentDateTime(Rx<String> datetime) {
  DateTime now = DateTime.now();
  datetime.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
}

void saveCurrentDateTimeToSubJob(
    Rx<String> datetime, String jobId, String option, String ticketId) async {
  try {
    DateTime now = DateTime.now();
    String? token = await getToken();
    datetime.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    Map<String, dynamic> body = {
      if (option == 'timestart') 'time_start': datetime.value,
      if (option == 'timeend') 'time_end': datetime.value,
    };

    final response = await http.put(
      Uri.parse(updateSubJobs(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Update time done');
    } else {
      print('Failed to update time: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void saveCurrentDateTimeToPMJob(
    Rx<String> datetime, String jobId, String option, String createById) async {
  try {
    DateTime now = DateTime.now();
    String? token = await getToken();
    datetime.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    Map<String, dynamic> body = {
      'job_id': jobId,
      'created_by': createById,
      if (option == 'timestart') 'status': 'start',
      'time_start': datetime.value,
      if (option == 'timeend') 'status': 'end',
      'time_end': datetime.value,
    };

    final response = await http.post(
      Uri.parse(updateJobIssueByIdPM()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Update time done');
    } else {
      print('Failed to update time: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void updateStatusSubjobs(
  String jobId,
  String ticketId,
) async {
  try {
    String? token = await getToken();

    Map<String, dynamic> body = {'status': '103'};

    final response = await http.put(
      Uri.parse(updateSubJobs(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Update status done');
    } else {}
  } catch (e) {
    print('Error: $e');
  }
}

void updateTechSubjob(
    String jobId, String ticketId, String remark, int status) async {
  try {
    String? token = await getToken();
    String remark2 = remark == '-' ? '' : remark;
    Map<String, dynamic> body = {'tech_status': status, 'tech_remark': remark2};

    final response = await http.put(
      Uri.parse(updateSubJobs(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Update status done');
      // jobDetailController.fetchData(ticketId, jobId);
    } else {}
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> updateCommentJobs(String jobId, String comment, String ticketId,
    Rx<TextEditingController> commentfield) async {
  try {
    String? token = await getToken();

    Map<String, dynamic> body = {'comment': comment};

    final response = await http.put(
      Uri.parse(updateSubJobs(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      commentfield.value.text = comment;
      commentfield.refresh();

      print('Update comment done');
    } else {}
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> updateSignatureJob(String jobId, String ticketId,
    String saveCompletedtime, String signature, String signaturePad) async {
  try {
    String? token = await getToken();

    Map<String, dynamic> body = {
      'save_time': saveCompletedtime,
      'signature_pad': signaturePad,
      'signature': signature
    };
    final response = await http.put(
      Uri.parse(updateReportById(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Update status done');
    } else {
      return;
    }
  } catch (e) {
    print('Error: $e');
  }
}

void updateAcceptStatusSubjobs(
    String jobId, String ticketId, String status) async {
  try {
    String? token = await getToken();

    Map<String, dynamic> body = {'status': status, 'tech_status': 1};

    final response = await http.put(
      Uri.parse(updateSubJobs(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      jobDetailController.fetchData(ticketId, jobId);
    } else {
      print('Failed to update status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> updateImgSubjobs(String jobId, String ticketId,
    RxList<Map<String, dynamic>> imageData, String option) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};
    List<String> filenames = [];
    List<String> contents = [];
    // Prepare the body by extracting the content and filename
    for (var data in imageData) {
      filenames.add(data['filename'] ?? '');
      contents.add(data['content'] ?? '');
    }
    if (option == 'before') {
      body = {'image_before': filenames, 'content_before': contents};
    } else {
      body = {'image_after': filenames, 'content_after': contents};
    }
    final response = await http.put(
      Uri.parse(updateSubJobs(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
    } else {
      print('Failed to update status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> updateImgPMjobs(String jobId, Map<String, dynamic> imageData,
    String option, String createById) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};

    if (option == 'before') {
      body = {
        'job_code': jobId,
        'name': imageData['filename'],
        'content': imageData['content'],
        'status': 'start',
        'created_by': createById
      };
    } else {
      body = {
        'job_code': jobId,
        'name': imageData['filename'],
        'content': imageData['content'],
        'status': 'end',
        'created_by': createById
      };
    }
    final response = await http.post(
      Uri.parse(updatePmJobImage()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Image Updated ');
    } else {
      print('Failed to update status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> deletePMImage(
    String jobId, String imageId, String option, String createById) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};

    body = {
      'id': imageId,
    };

    final response = await http.post(
      Uri.parse(deletePmJobImage()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Image Deleted ');
    } else {
      print('Failed to update status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> deleteImgSubJob(
    String jobId, List<Map<String, dynamic>> imageData, String option) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};
    List<String> filenames = [];
    List<String> contents = [];
    // Prepare the body by extracting the content and filename
    for (var data in imageData) {
      filenames.add(data['filename'] ?? '');
      contents.add(data['content'] ?? '');
    }
    if (option == 'before') {
      body = {'image_before': filenames, 'content_before': contents};
    } else {
      body = {'image_after': filenames, 'content_after': contents};
    }
    final response = await http.put(
      Uri.parse(updateSubJobs(jobId)),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
    } else {
      print('Failed to update status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<Map<String, String>> fetchTicketById(String id) async {
  String? token = await getToken();
  final response = await http.get(
    Uri.parse(getTicketbyId(id)),
    headers: {
      'Authorization': '$token',
    },
  );
  if (response.statusCode == 200) {
    var userInfo = <UserById>[].obs;
    var truckInfo = <WarrantybyIdModel>[].obs;
    Map<String, dynamic> data = json.decode(response.body);
    ticket.TicketByIdModel ticketModel = ticket.TicketByIdModel.fromJson(data);

    List<ticket.Issues>? issuesList = ticketModel.issues;
    final response2 = await http.get(
      Uri.parse(getUserInfoById(issuesList!.first.reporter!.id.toString())),
      headers: {
        'Authorization': '$token',
      },
    );
    if (response2.statusCode == 200) {
      final dynamic responseData = jsonDecode(response2.body);

      if (responseData is Map<String, dynamic>) {
        UserById user = UserById.fromJson(responseData);
        userInfo.value = [user];
      } else {
        print('Invalid data format');
      }
    }
    CustomerById customerInfo = await fetchCustomerInfo(
        userInfo.first.users!.first.companyId.toString());

    final response3 = await http.get(
      Uri.parse(getWarrantyTruckByTicketId(id)),
      headers: {
        'Authorization': '$token',
      },
    );
    if (response3.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response3.body);

      List<WarrantybyIdModel> dataList =
          jsonResponse.map((json) => WarrantybyIdModel.fromJson(json)).toList();
      truckInfo.assignAll(dataList);
    } else {
      print('Failed to load data: ${response.statusCode}');
    }

    return {
      'name': issuesList.first.reporter!.name ?? '',
      'location': customerInfo.customerAddress ?? '',
      'model': truckInfo.first.model ?? '',
      'serial': truckInfo.first.serial ?? '',
    };
  } else {
    print('Failed to load data: ${response.statusCode} $id ');
    return {};
  }
}

Future<Map<String, String>> fetchTicketById2(String id, String serialNo) async {
  String? token = await getToken();
  try {
    final response = await http.get(
      Uri.parse(getTicketbyId(id)),
      headers: {
        'Authorization': '$token',
      },
    );
    if (response.statusCode == 200) {
      var userInfo = <UserById>[].obs;
      var truckInfo = <WarrantybyIdModel>[].obs;
      Map<String, dynamic> data = json.decode(response.body);
      ticket.TicketByIdModel ticketModel =
          ticket.TicketByIdModel.fromJson(data);

      List<ticket.Issues>? issuesList = ticketModel.issues;
      final response2 = await http.get(
        Uri.parse(getUserInfoById(issuesList!.first.reporter!.id.toString())),
        headers: {
          'Authorization': '$token',
        },
      );
      if (response2.statusCode == 200) {
        final dynamic responseData = jsonDecode(response2.body);

        if (responseData is Map<String, dynamic>) {
          UserById user = UserById.fromJson(responseData);
          userInfo.value = [user];
        } else {
          print('Invalid data format');
        }
      }
      CustomerById customerInfo = await fetchCustomerInfo(
          userInfo.first.users!.first.companyId.toString());

      final response3 = await http.get(
        Uri.parse(getTrickdetailById(serialNo)),
        headers: {
          'Authorization': '$token',
        },
      );
      if (response3.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response3.body);

        List<WarrantybyIdModel> dataList = jsonResponse
            .map((json) => WarrantybyIdModel.fromJson(json))
            .toList();
        truckInfo.assignAll(dataList);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }

      return {
        'name': issuesList.first.reporter!.name ?? '',
        'location': customerInfo.customerAddress ?? '',
        'model': truckInfo.first.model ?? '',
        'serial': truckInfo.first.serial ?? '',
      };
    } else {
      print('Failed to load data: ${response.statusCode} $id ');
      return {};
    }
  } catch (e) {
    print(e);
    return {};
  }
}

Future<Map<String, String>> fetchLocationById(String id) async {
  String? token = await getToken();
  var userInfo = <UserById>[].obs;

  final response2 = await http.get(
    Uri.parse(getUserInfoById(id)),
    headers: {
      'Authorization': '$token',
    },
  );
  if (response2.statusCode == 200) {
    final dynamic responseData = jsonDecode(response2.body);

    if (responseData is Map<String, dynamic>) {
      UserById user = UserById.fromJson(responseData);
      userInfo.value = [user];
    } else {
      print('Invalid data format');
    }
  }
  CustomerById customerInfo =
      await fetchCustomerInfo(userInfo.first.users!.first.companyId.toString());

  return {'location': customerInfo.customerAddress ?? ''};
}

Future<Map<String, String>> fetchLocationByCustomerId(String id) async {
  CustomerById customerInfo = await fetchCustomerInfo(id);

  return {'location': customerInfo.customerAddress ?? ''};
}

Future<void> selectDate(
    BuildContext context, Rx<DateTime?> selectedDateTime) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    selectTime(context, picked, selectedDateTime);
  }
}

void setDateTime(DateTime dateTime, Rx<DateTime?> selectedDateTime) {
  selectedDateTime.value = dateTime;
}

Future<void> selectTime(BuildContext context, DateTime pickedDate,
    Rx<DateTime?> selectedDateTime) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime != null) {
    final DateTime pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    setDateTime(pickedDateTime, selectedDateTime);
  }
}

Future<CustomerById> fetchCustomerInfo(String id) async {
  String username = usernameProduct;
  String password = passwordProduct;

  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  try {
    final response = await http.get(
      Uri.parse(getCustomerInfoById(id.toString())),
      headers: {'Authorization': basicAuth},
    );
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomerById customer = CustomerById.fromJson(responseData);
        return customer;
      } else {
        throw const FormatException('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

Future<void> fetchgetCustomerInfo(
    String id, RxList<CustomerById> customerInfo) async {
  String username = usernameProduct;
  String password = passwordProduct;

  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  try {
    final response = await http.get(
      Uri.parse(getCustomerInfoById(id.toString())),
      headers: {'Authorization': basicAuth},
    );
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomerById customer = CustomerById.fromJson(responseData);
        customerInfo.add(customer);
      } else {
        Get.offAll(BottomBarView());
        bottomController.currentIndex.value = 0;
      }
    } else {
      Get.offAll(BottomBarView());
      bottomController.currentIndex.value = 0;
    }
  } catch (e) {
    print('Error: $e');
    Get.offAll(BottomBarView());
    bottomController.currentIndex.value = 0;
  }
}
