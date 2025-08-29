import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/pdfget.dart';
import 'package:toyotamobile/Models/batteryreport_model.dart';
import 'package:toyotamobile/Models/customersearch_model.dart';
import 'package:toyotamobile/Models/getattacthmentall.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/notificationhistory_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/pmcommentjob_model.dart';
import 'package:toyotamobile/Models/pmjobinfo_model.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Models/techreport_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Models/truck_by_id_model.dart';
import 'package:toyotamobile/Models/userallsales_model.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/usertoken.dart';
import 'package:toyotamobile/Models/versions_model.dart';
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
      Uri.parse(getSubJobByIdNew(subjobId)),
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

Future<void> fetchPMJob(
    String jobId, String token, RxList<PmModel> pmJobs) async {
  try {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(getPmJobbyId(jobId)),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      pmJobs.clear();
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      PmModel pmJob = PmModel.fromJson(jsonResponse);
      pmJobs.add(pmJob);
      pmJobs.refresh();
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

Future<void> fetchPmTruckById(
    String id,
    Rx<TextEditingController> product,
    Rx<TextEditingController> serialNo,
    Rx<TextEditingController> model,
    Rx<TextEditingController> customerName) async {
  try {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(getPmTruckById(id)),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        TruckByIdModel truckData = TruckByIdModel.fromJson(data);
        product.value.text = truckData.tNo ?? '';
        serialNo.value.text = truckData.tSerialNo ?? '';
        model.value.text = truckData.tModel ?? '';
        customerName.value.text = truckData.customerName ?? '';
      } else {}
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchJobTruckById(
    String id,
    Rx<TextEditingController> product,
    Rx<TextEditingController> serialNo,
    Rx<TextEditingController> model,
    Rx<TextEditingController> customerName,
    Rx<TextEditingController> contactName) async {
  try {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(getJobTruckById(id)),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        TruckByIdModel truckData = TruckByIdModel.fromJson(data);
        product.value.text = truckData.tNo ?? '';
        serialNo.value.text = truckData.tSerialNo ?? '';
        model.value.text = truckData.tModel ?? '';
        customerName.value.text = truckData.customerName ?? '';
        contactName.value.text = truckData.contactName ?? '';
      } else {}
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> fetchAllSales(RxList<UsersSales> userAllSales, String projectId,
    String jobId, String bugId) async {
  String? token = await getToken();
  try {
    final response = await http.get(
      Uri.parse(getAllSales()),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      UserAllSales userData = UserAllSales.fromJson(data);

      if (userData.users != null) {
        userAllSales.assignAll(userData.users!);
      } else {}
    } else {
      print('Failed to load data: ${response.statusCode}');
      userAllSales.clear();
    }
  } catch (e) {
    print('Error: $e');
    userAllSales.clear();
  }
}

Future<void> fetchAllSalesAdmin(RxList<UsersSales> userAllSales,
    String projectId, String jobId, String bugId) async {
  String? token = await getToken();
  try {
    final response = await http.get(
      Uri.parse(getAllSalesAdmin(jobId)),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      UserAllSales userData = UserAllSales.fromJson(data);

      if (userData.users != null) {
        userAllSales.assignAll(userData.users!);
      } else {}
    } else {
      print('Failed to load data: ${response.statusCode}');
      userAllSales.clear();
    }
  } catch (e) {
    print('Error: $e');
    userAllSales.clear();
  }
}

Future<void> fetchAllTech(RxList<UsersSales> userAllTech) async {
  String? token = await getToken();
  try {
    final response = await http.get(
      Uri.parse(getAllTech()),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      UserAllSales userData = UserAllSales.fromJson(data);

      if (userData.users != null) {
        userAllTech.assignAll(userData.users!);
      } else {}
    } else {
      print('Failed to load data: ${response.statusCode}');
      userAllTech.clear();
    }
  } catch (e) {
    print('Error: $e');
    userAllTech.clear();
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

Future<void> fetchSubJobImg(
    RxList<Map<String, String>> file, String subjobId, String option) async {
  try {
    String? token = await getToken();
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
      try {
        if (option == 'before') {
          if (dataList.first.imgUrlBefore != null &&
              dataList.first.imgUrlBefore != '') {
            file.clear();
            List<dynamic> imageBeforeList =
                jsonDecode(dataList.first.imgUrlBefore!);

            for (int i = 0; i < imageBeforeList.length; i++) {
              file.add({
                'filename': '',
                'content': imageBeforeList[i],
              });
            }
            file.refresh();
          }
        } else if (option == 'after') {
          if (dataList.first.imgUrlAfter != null &&
              dataList.first.imgUrlAfter != '') {
            file.clear();
            List<dynamic> imageAfterList =
                jsonDecode(dataList.first.imgUrlAfter!);

            for (int i = 0; i < imageAfterList.length; i++) {
              file.add({
                'filename': '',
                'content': imageAfterList[i],
              });
            }
            file.refresh();
          }
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
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

Future<Map<String, dynamic>> getVersions(
    String deviceType, String versionNow) async {
  String? token = await getToken();
  final response = await http.get(
    Uri.parse(getLatestVersions()),
    headers: {
      'Authorization': '$token',
    },
  );

  Map<String, dynamic> data = {'version': '', 'status': true};
  if (response.statusCode == 200) {
    final dynamic responseData = jsonDecode(response.body);

    if (responseData is Map<String, dynamic>) {
      Versions versions = Versions.fromJson(responseData);
      if (deviceType == 'Android') {
        data['version'] = versions.appVersionPlaystore ?? '';
        data['status'] = versions.status;
        return data;
      } else if (deviceType == 'iOS') {
        data['version'] = versions.appVersionAppstore ?? '';
        data['status'] = versions.status;
        return data;
      } else {
        return data;
      }
    } else {
      return data;
    }
  } else {
    return data;
  }
}

Future<String> getUserVersion(String deviceId) async {
  String? token = await getToken();
  final response = await http.get(
    Uri.parse(getUserTokenNotification(deviceId)),
    headers: {
      'Authorization': '$token',
    },
  );
  if (response.statusCode == 200) {
    final dynamic responseData = jsonDecode(response.body);

    if (responseData is Map<String, dynamic>) {
      UserToken userToken = UserToken.fromJson(responseData);
      return userToken.appVersion ?? '';
    } else {
      return '';
    }
  } else {
    return '';
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
  try {
    if (getAttachments != null) {
      var attachments = getAttachments as List<dynamic>;
      for (var attachment in attachments) {
        if (attachment.createdAt != null) {
          Map<String, dynamic> attachmentMap = {
            'id': attachment.id,
            'filename': attachment.filename,
          };
          attachmentsData.add(attachmentMap);
        }
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
  } catch (e) {
    attatchments = [];
  }
}

Future<void> fetchReadAttachmentList(
  String issueId,
  String token,
  List<Map<String, dynamic>> attachments,
) async {
  attachments.clear();
  try {
    final String getFileUrl = getAllAttachmentFile(issueId);

    final response = await http.get(
      Uri.parse(getFileUrl),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      GetAttatchmentAllModel dataList = GetAttatchmentAllModel.fromJson(data);
      List<Files>? filesList = dataList.files;
      List<Map<String, dynamic>> fileDataList = [];

      filesList?.forEach((file) {
        if (file.createdAt != null ||
            (file.imageUrl != null &&
                file.imageUrl != '' &&
                (file.filename!.endsWith('.jpg') ||
                    file.filename!.endsWith('.jpeg') ||
                    file.filename!.endsWith('.png') ||
                    file.filename!.endsWith('.heic') ||
                    file.filename!.endsWith('.heif')))) {
          Map<String, dynamic> fileData = {
            'id': file.id,
            'filename': file.filename,
            'content': file.imageUrl,
            'created_at': file.createdAt,
          };
          fileDataList.add(fileData);
        }
      });

      attachments.addAll(fileDataList);
    }
  } catch (e) {
    print('Error fetching attachments: $e');
    attachments.clear();
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

Future<void> fetchJobBatteryReportData(
  String id,
  String token,
  RxList<BatteryReportModel> reportBatteryList,
) async {
  try {
    final response = await http.get(
      Uri.parse(getJobBatteryReportById(id)),
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
        reportBatteryList.clear();
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

      reportBatteryList.add(batteryReport);
      reportBatteryList.refresh();
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

Future<void> fetchPreventiveICReportData(
  String id,
  String token,
  RxList<PreventivereportModel> reportList,
) async {
  try {
    final response = await http.get(
      Uri.parse(getPreventiveIcReportById(id)),
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

Future<void> fetchCustomerSearch(
  String id,
  String token,
  RxList<CustomerModel> customerList,
) async {
  try {
    final response = await http.get(
      Uri.parse(getCustomerBySearch(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      customerList.clear();
      var data = jsonDecode(response.body);
      var customerInfo = CustomerModel.fromJson(data);
      customerList.add(customerInfo);
      customerList.refresh();
    } else {}
  } catch (e) {
    print(e);
  }
}

Future<void> fetchPdfReport(
    String id, String token, RxString pdfReport, String option) async {
  try {
    String apiUrl = '';

    if (option == 'estimate') {
      apiUrl = getPdfEstimateReportById(id);
    } else if (option == 'estimate_pm') {
      apiUrl = getPdfEstimatePMReportById(id);
    } else if (option == 'fieldreport') {
      apiUrl = getPdfFieldReportById(id);
    } else if (option == 'fieldreport_btr') {
      apiUrl = getPdfJobsBtrReportById(id);
    } else if (option == 'btr') {
      apiUrl = getPdfBtrReportById(id);
    } else if (option == 'pvt') {
      apiUrl = getPdfPvtReportById(id);
    } else {
      apiUrl = getPdfPvtIcReportById(id);
    }
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('pdf_estimate')) {
        pdfReport.value = responseBody['pdf_estimate'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_estimate_pm')) {
        pdfReport.value = responseBody['pdf_estimate_pm'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_base64')) {
        pdfReport.value = responseBody['pdf_base64'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_btr')) {
        pdfReport.value = responseBody['pdf_btr'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_jobs_btr')) {
        pdfReport.value = responseBody['pdf_jobs_btr'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_report')) {
        pdfReport.value = responseBody['pdf_report'];
        pdfReport.refresh();
      } else if (responseBody.containsKey('pdf_ic_base64')) {
        pdfReport.value = responseBody['pdf_ic_base64'];
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
              'content': imageBeforeList[i].imgUrl,
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
              'content': imageAfterList[i].imgUrl,
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

Future<void> pickImage(BuildContext context, RxList<Map<String, String>> file,
    Rx<bool> isPicking, String option, String ticketId, String jobId) async {
  if (isPicking.value) return;
  isPicking.value = true;
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      io.File imageFile = io.File(pickedFile.path);
      final compressedImage = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 50,
        format: CompressFormat.png,
        minWidth: 800,
        minHeight: 600,
      );
      if (compressedImage != null) {
        final compressedFile = io.File('${imageFile.path}_compressed')
          ..writeAsBytesSync(compressedImage);

        String fileName = pickedFile.name;
        String base64Content = base64Encode(await compressedFile.readAsBytes());
        // String fileExtension = fileName.split('.').last.toLowerCase();
        // if (fileExtension == 'jpg' ||
        //     fileExtension == 'png' ||
        //     fileExtension == 'jpeg') {
        var images = <Map<String, String>>[].obs;
        images.add({
          'filename': fileName,
          'content': base64Content,
        });

        await updateImgSubjobs(jobId, ticketId, images, option);
        await fetchSubJobImg(file, jobId, option);
        // } else {
        //   showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return const AlertDialogPickImage();
        //       });
        // }
      }
    }
  } finally {
    isPicking.value = false;
  }
}

Future<void> pickImagePM(
    BuildContext context,
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
      final compressedImage = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 50,
        format: CompressFormat.png,
        minWidth: 800,
        minHeight: 600,
      );
      if (compressedImage != null) {
        final compressedFile = io.File('${imageFile.path}_compressed')
          ..writeAsBytesSync(compressedImage);
        String fileName = pickedFile.name;
        String base64Content = base64Encode(await compressedFile.readAsBytes());
        // String fileExtension = fileName.split('.').last.toLowerCase();
        // file.add({
        //   'filename': fileName,
        //   'content': base64Content,
        // });
        // if (fileExtension == 'jpg' ||
        //     fileExtension == 'png' ||
        //     fileExtension == 'jpeg') {
        Map<String, String> newImg = ({
          'filename': fileName,
          'content': base64Content,
        });

        await updateImgPMjobs(jobId, newImg, option, createById);
        await fetchPmJobImg(jobId, imagesBefore, imagesAfter, option);
        // } else {
        //   showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return const AlertDialogPickImage();
        //       });
        // }
      }
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

void changeIssueStatus(String issueId, String status) async {
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
    // jobController.fetchDataFromAssignJob();
    // bottomController.currentIndex.value = 0;
    // Get.offAll(() => BottomBarView());
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
    int customerChecking,
    int customerScore,
    String customerDescription) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};
    if (option == 'battery') {
      body = {
        "job_id": issueId,
        'name': 'ลายเซ็น.png',
        'content': signaturePad,
        "signature": signature,
        "save_time": saveCompletedtime,
        'customer_checking': customerChecking,
        'customer_score': customerScore,
        'customer_description': customerDescription,
      };

      final response2 = await http.post(
        Uri.parse(updateBatterySignatureUrl()),
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
    } else if (option == 'preventive') {
      body = {
        "job_id": issueId,
        'name': 'ลายเซ็น.png',
        'content': signaturePad,
        "signature": signature,
        "save_time": 0,
        'customer_checking': customerChecking,
        'customer_score': customerScore,
        'customer_description': customerDescription,
      };
      final response2 = await http.post(
        Uri.parse(updatePreventiveSignatureUrl()),
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
        'name': 'ลายเซ็น.png',
        'content': signaturePad,
        "signature": signature,
        "save_time": 0,
        'customer_checking': customerChecking,
        'customer_score': customerScore,
        'customer_description': customerDescription,
      };
      final response2 = await http.post(
        Uri.parse(updatePreventiveIcSignatureUrl()),
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
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> updateJobSparePart(
  String jobId,
  String techLevel,
  String handlerId,
  String remark,
  String option,
  String bugId,
  String techHandlerId,
  String reporterId,
  String projectId,
  String adminId,
) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};

    if (option == 'send') {
      body = {
        'estimate_status': 1,
        'purchase_order_status': 1,
        'tech_manager_id': 0,
        'tech_manager_status': 0,
        'tech_manager_remark': '',
        'customer_reject_remark': '',
        'admin_status': 0,
        'sales_id': 0,
        'sales_status': 0,
        'sales_manager_id': 0,
        'sales_manager_status': 0,
        'sales_director_id': 0,
        'sales_director_status': 0,
        'customer_status': 0,
        'quotation': 0,
        'condition': 0,
        'sales_admin_id': 0,
        'sales_admin_status': 0,
        'special_discount': 0,
        "bug_id": int.parse(bugId),
        if (projectId == '1') "job_issue_id": jobId else "bug_id": bugId,
      };
      createQuotationHistory(jobId, 'tech', bugId, handlerId, '1');
      projectId == '1'
          ? createHistoryJobs(
              handlerId,
              '0',
              'Job ID : ${jobId.toString().padLeft(7, '0')}',
              'มีรายการใบเบิก Spare Part รออนุมัติใหม่',
              'admin',
              bugId,
              jobId,
              'QT',
              'tech',
              '0',
              'group')
          : createHistoryJobs(
              handlerId,
              '0',
              'PM ID : ${bugId.toString().padLeft(7, '0')}',
              'มีรายการใบเบิก Spare Part รออนุมัติใหม่',
              'admin',
              bugId,
              jobId,
              'QT',
              'tech',
              '0',
              'group');
    } else if (option == 'approve') {
      body = {
        'tech_manager_status': 1,
        if (projectId == '1') "job_issue_id": jobId else "bug_id": bugId,
      };
      createQuotationHistory(jobId, 'tech_manager', bugId, handlerId, '1');
      projectId == '1'
          ? createHistoryJobs(
              handlerId,
              adminId,
              'Job ID : ${jobId.toString().padLeft(7, '0')}',
              'มีรายการใบเบิก Spare Part รอตรวจสอบเอกสาร PO ใหม่',
              adminId,
              bugId,
              jobId,
              'QT',
              'tech_manager',
              '0',
              'one')
          : createHistoryJobs(
              handlerId,
              adminId,
              'PM ID : ${bugId.toString().padLeft(7, '0')}',
              'มีรายการใบเบิก Spare Part รอตรวจสอบเอกสาร PO ใหม่',
              adminId,
              bugId,
              jobId,
              'QT',
              'tech_manager',
              '0',
              'one');
      // sendNotificationToUser(
      //     handlerId,
      //     techHandlerId,
      //     'Job ID : $jobId',
      //     'ใบเบิก Spare Part ของคุณผ่านการอนุมัติเเล้ว',
      //     reporterId,
      //     bugId,
      //     jobId);
    } else if (option.contains('approve_add_sales')) {
      var parts = option.split(':');
      var salesId = parts[1].trim();
      body = {
        'tech_manager_status': 1,
        'sales_admin_id': 1,
        if (projectId == '1') "job_issue_id": jobId else "bug_id": bugId,
      };
      createQuotationHistory(jobId, 'tech_manager', bugId, handlerId, '1');
      projectId == '1'
          ? createHistoryJobs(
              handlerId,
              salesId,
              'Job ID : ${jobId.toString().padLeft(7, '0')}',
              'มีรายการใบเบิก Spare Part รออนุมัติใหม่',
              'sales_admin',
              bugId,
              jobId,
              'QT',
              'tech_manager',
              salesId,
              'group')
          : createHistoryJobs(
              handlerId,
              salesId,
              'PM ID : ${bugId.toString().padLeft(7, '0')}',
              'มีรายการใบเบิก Spare Part รออนุมัติใหม่',
              'sales_admin',
              bugId,
              jobId,
              'QT',
              'tech_manager',
              salesId,
              'group');
    } else if (option == 'reject') {
      body = {
        'tech_manager_status': 2,
        'tech_manager_remark': remark,
        'estimate_status': 3,
        if (projectId == '1') "job_issue_id": jobId else "bug_id": bugId,
      };
      createQuotationHistory(jobId, 'tech_manager', bugId, handlerId, '2');
      projectId == '1'
          ? sendNotificationToUser(
              handlerId,
              techHandlerId,
              'Job ID : ${jobId.toString().padLeft(7, '0')}',
              'ใบเบิก Spare Part ของคุณไม่ผ่านการอนุมัติ',
              reporterId,
              bugId,
              jobId,
              'QT')
          : sendNotificationToUser(
              handlerId,
              techHandlerId,
              'PM ID : ${bugId.toString().padLeft(7, '0')}',
              'ใบเบิก Spare Part ของคุณไม่ผ่านการอนุมัติ',
              reporterId,
              bugId,
              jobId,
              'QT');
    } else if (option == 'update_sparepart') {
      body = {
        'tech_manager_remark': remark,
        if (projectId == '1') "job_issue_id": jobId else "bug_id": bugId,
      };
    }
    final response = await http.post(
      Uri.parse(option == 'send'
          ? projectId == '1'
              ? createQuotationReport()
              : createQuotationReportPM()
          : projectId == '1'
              ? updateQuotation()
              : updateQuotationPM()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Update status done');
      if (techLevel == '1') {
        await jobController.fetchSubJobSparePart(handlerId, 'tech');
      } else {
        await jobController.fetchSubJobSparePart(handlerId, 'techlead');
      }
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> updateJobSparePartReturn(
    String jobId,
    String techLevel,
    String handlerId,
    String remark,
    String option,
    String bugId,
    String techHandlerId,
    String reporterId,
    String projectId,
    String adminId,
    String returnId,
    String refNo) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};

    if (option == 'approve') {
      body = {'return_id': returnId, 'tech_manager_status': 1};

      createQuotationReturnHistory(
          jobId, 'tech_manager', bugId, handlerId, '1', refNo);
      projectId == '1'
          ? createHistoryJobs(
              handlerId,
              adminId,
              'Job ID : ${jobId.toString().padLeft(7, '0')}',
              'มีรายการใบคืน Spare Part รอตรวจสอบใหม่',
              adminId,
              bugId,
              jobId,
              'QTR',
              'tech_manager',
              '0',
              'one')
          : createHistoryJobs(
              handlerId,
              adminId,
              'PM ID : ${bugId.toString().padLeft(7, '0')}',
              'มีรายการใบคืน Spare Part รอตรวจสอบใหม่',
              adminId,
              bugId,
              jobId,
              'QTR',
              'tech_manager',
              '0',
              'one');
    } else if (option == 'reject') {
      body = {
        'tech_manager_status': 2,
        'remark': remark,
        'estimate_status': 3,
        'purchase_order_status': 3,
        'return_id': returnId,
      };
      createQuotationReturnHistory(
          jobId, 'tech_manager', bugId, handlerId, '2', refNo);
      projectId == '1'
          ? sendNotificationToUser(
              handlerId,
              techHandlerId,
              'Job ID : ${jobId.toString().padLeft(7, '0')}',
              'ใบคืน Spare Part ของคุณไม่ผ่านการอนุมัติ',
              reporterId,
              bugId,
              jobId,
              'QTR')
          : sendNotificationToUser(
              handlerId,
              techHandlerId,
              'PM ID : ${bugId.toString().padLeft(7, '0')}',
              'ใบคืน Spare Part ของคุณไม่ผ่านการอนุมัติ',
              reporterId,
              bugId,
              jobId,
              'QTR');
    }
    final response = await http.post(
      Uri.parse(updateQuotationReturn()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Update status done');
      if (techLevel == '1') {
        await jobController.fetchSubJobSparePartReturn(handlerId, 'tech');
      } else {
        await jobController.fetchSubJobSparePartReturn(handlerId, 'techlead');
      }
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('Error: $e');
  }
}

// void refreshSparePartJob($bugId, $jobId, projectId) {
//   if (projectId == '2') {
//     filteredSubJobSparePart = jobController.subJobSparePart
//         .where((sparePart) => sparePart.bugId == $bugId)
//         .toList();
//   } else {
//     filteredSubJobSparePart = jobController.subJobSparePart
//         .where((sparePart) => sparePart.id == notification.jobId)
//         .toList();
//   }
// }

Future<void> createSparepartNote(String jobId, String techManagerId,
    String techLevel, String handlerId, List<String> remarkList) async {
  try {
    List<Map<String, dynamic>> noteList =
        remarkList.map((remark) => {'details': remark}).toList();
    String? token = await getToken();
    Map<String, dynamic> body = {
      'job_issue_id': jobId,
      'note': noteList,
    };

    final response = await http.post(
      Uri.parse(createSparepartNotes()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Update status done');
      if (techLevel == '1') {
        await jobController.fetchSubJobSparePart(handlerId, 'tech');
      } else {
        await jobController.fetchSubJobSparePart(techManagerId, 'techlead');
      }
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> createQuotationHistory(
  String jobId,
  String details,
  String bugId,
  String createBy,
  String status,
) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {
      'job_issue_id': jobId,
      "details": details,
      "bug_id": int.parse(bugId),
      "create_by": int.parse(createBy),
      "status": int.parse(status)
    };

    final response = await http.post(
      Uri.parse(createHistoryQuotation()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Update Done');
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> createQuotationReturnHistory(
  String jobId,
  String details,
  String bugId,
  String createBy,
  String status,
  String refNo,
) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {
      'job_issue_id': jobId,
      "details": details,
      "bug_id": int.parse(bugId),
      "create_by": int.parse(createBy),
      "status": int.parse(status),
      if (refNo != 'none') "ref_no": int.parse(refNo)
    };

    final response = await http.post(
      Uri.parse(createHistoryReturnQuotation()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Update Done');
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> updateTokenNotification(
  String deviceId,
  String appVersion,
) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {
      'device_id': deviceId,
      "app_version": appVersion,
    };

    final response = await http.post(
      Uri.parse(updateUserTokenNotification()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Update App Version Done');
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> sendNotificationToUser(
    String handlerId,
    String techHandlerId,
    String details,
    String bodyDetail,
    String reporterId,
    String bugId,
    String jobId,
    String notifyType) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {
      'handler_id': techHandlerId,
      "detail": details,
      "body": bodyDetail
    };

    final response = await http.post(
      Uri.parse(sendUserNotification()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Sent Notifcation');
    } else {
      print(response.statusCode);
    }
    try {
      Map<String, dynamic> body2 = {
        "title": details,
        "details": bodyDetail,
        "bug_id": int.parse(bugId),
        "user_id": int.parse(techHandlerId),
        "report_by": int.parse(handlerId),
        "group_notify": "one",
        "group_report_by": "tech_manager",
        "reference_code": reporterId,
        "job_id": int.parse(jobId),
        "sales_id": 0,
        "notify_type": notifyType
      };
      final response = await http.post(
        Uri.parse(createJobNotificationHistory()),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body2),
      );
      if (response.statusCode == 201) {
        print('Updated History Notification');
      }
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> createHistoryJobs(
  String handlerId,
  String receiverId,
  String details,
  String bodyDetail,
  String reporterId,
  String bugId,
  String jobId,
  String notifyType,
  String groupReportBy,
  String salesId,
  String groupNotify,
) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body2 = {
      "title": details,
      "details": bodyDetail,
      "bug_id": int.parse(bugId),
      "user_id": receiverId,
      "report_by": int.parse(handlerId),
      "group_notify": groupNotify,
      "group_report_by": groupReportBy,
      "reference_code": reporterId,
      "job_id": int.parse(jobId),
      "sales_id": int.parse(salesId),
      "notify_type": notifyType
    };
    final response = await http.post(
      Uri.parse(createJobNotificationHistory()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body2),
    );
    if (response.statusCode == 201) {
      print('Updated History Notification');
    }
  } catch (e) {
    print(e);
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

Future<void> updateSignatureJob(
    String jobId,
    String ticketId,
    String saveCompletedtime,
    String signature,
    String signaturePad,
    int customerChecking,
    int customerScore,
    String customerDescription) async {
  try {
    String? token = await getToken();

    Map<String, dynamic> body = {
      'job_issue_id': jobId,
      'name': 'ลายเซ็น.png',
      'content': signaturePad,
      'save_time': saveCompletedtime,
      'signature': signature,
      'customer_checking': customerChecking,
      'customer_score': customerScore,
      'customer_description': customerDescription,
    };
    final response = await http.post(
      Uri.parse(updateJobsSignatureUrl()),
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

Future<void> updateJobSignatureBattery(
    String issueId,
    String saveCompletedtime,
    String signature,
    String signaturePad,
    int customerChecking,
    int customerScore,
    String customerDescription) async {
  try {
    String? token = await getToken();
    Map<String, dynamic> body = {};

    body = {
      "job_issue_id": issueId,
      'name': 'ลายเซ็น.png',
      'content': signaturePad,
      "signature": signature,
      "save_time": saveCompletedtime,
      'customer_checking': customerChecking,
      'customer_score': customerScore,
      'customer_description': customerDescription,
    };

    final response2 = await http.post(
      Uri.parse(updateJobsBatterySignatureUrl()),
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
  } catch (e) {
    print(e);
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
      // jobDetailController.fetchData(ticketId, jobId);
      changeIssueStatus(ticketId, 'onprocess');
    } else {
      print('Failed to update status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void finishedQuoteJobs(String jobId, String ticketId, String projectId,
    String referenceCode, String userId) async {
  try {
    String? token = await getToken();

    Map<String, dynamic> body = {
      'bug_id': ticketId,
      'job_issue_id': jobId,
      'project_id': projectId,
      'reference_code': referenceCode,
      'user_id': userId
    };

    final response = await http.post(
      Uri.parse(finishedQuote()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Finished Quote Done: ${response.body}');
    } else {
      print('Failed to update quote: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void createQuotation(String jobId, int ticketId, String projectId) async {
  try {
    String? token = await getToken();

    Map<String, dynamic> body = {'bug_id': ticketId, 'job_issue_id': jobId};

    final response = await http.post(
      Uri.parse(projectId == '1'
          ? createQuotationReport()
          : createQuotationReportPM()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Created Done');
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
    for (var data in imageData) {
      filenames.add(data['filename'] ?? '');
      contents.add(data['content'] ?? '');
    }
    if (option == 'before') {
      body = {'img_url_before': contents};
    } else {
      body = {'img_url_after': contents};
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

Future<void> deleteS3Image(String imageUrl) async {
  try {
    String? token = await getToken();
    Uri uri = Uri.parse(imageUrl);
    Map<String, dynamic> body = {"path": uri.toString()};
    http.post(
      Uri.parse(deleteS3ImageJob()),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  } catch (e) {
    print('Error deleting image: $e');
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

Future<void> fetchSubJobSparePartOption() async {
  if (jobController.techLevel.value == '1') {
    await jobController.fetchSubJobSparePart(
        jobController.handlerIdTech.toString(), 'tech');
  } else {
    await jobController.fetchSubJobSparePart(
        jobController.handlerIdTech.value, 'leadtech');
  }
}

Future<void> fetchTechReport(
    RxList<TechReportModel> techReport, String id, int year) async {
  try {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(getTechReport(id, year.toString())),
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      techReport.value =
          data.map((item) => TechReportModel.fromJson(item)).toList();
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {}
}

Future<bool> checkJobsOnProcess(
  String handlerId,
  String token,
) async {
  try {
    final response = await http.get(
      Uri.parse(getJobsOnProcess(handlerId)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      bool status = data['status'] ?? false;
      return status;
    }
    return false;
  } catch (e) {
    print('Error : $e');
    return false;
  }
}

Future<bool> checkTicketOnProcess(
  String handlerId,
  String token,
) async {
  try {
    final response = await http.get(
      Uri.parse(getTicketOnProcess(handlerId)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      bool status = data['status'] ?? false;
      return status;
    }
    return false;
  } catch (e) {
    print('Error : $e');
    return false;
  }
}

Future<void> fetchSparepartById(String ticketId, String jobId, String option,
    RxList<SubJobSparePart> subJobSparePart) async {
  try {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(getSparepartJobId(jobId, option)),
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final List<SubJobSparePart> spareparts =
          data.map((e) => SubJobSparePart.fromJson(e)).toList();

      subJobSparePart.assignAll(spareparts);
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print(e);
  }
}
