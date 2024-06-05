import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/gettoken.dart';
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
  var notesFiles = <dynamic>[].obs;

  var isPicking = false.obs;
  var issueData = [].obs;
  var attatchments = <Map<String, dynamic>>[].obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var issueId;
  var status = RxString('');
  final HomeController jobController = Get.put(HomeController());
  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;
  final BottomBarController bottomController = Get.put(BottomBarController());

  void fetchData(String ticketId) async {
    final String apiUrl = getTicketbyId(ticketId);
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var issues = data['issues'] as List<dynamic>;

      var extractedData = issues.map((issue) {
        if (issue['attachments'] != null) {
          var attachments = issue['attachments'] as List<dynamic>;
          for (var attachment in attachments) {
            Map<String, dynamic> attachmentMap = {
              'id': attachment['id'],
              'filename': attachment['filename'],
            };
            attachmentsData.add(attachmentMap);
          }
        }
        issueId = issue['id'];
        status.value = issue['status']['name'];

        if (issue['notes'] != null) {
          var issueNotes = issue['notes'] as List<dynamic>;
          notesFiles.assignAll(issueNotes);
        }
        var issueDetails = {
          'id': issue['id'],
          'summary': issue['summary'],
          'description': issue['description'],
          'created_at': issue['created_at'],
          'reporter': issue['reporter']['name'],
          'status': issue['status']['name'],
          'serialNumber': 'CE429423',
          'email': issue['reporter']['email'],
          'category': issue['category']['name'],
          'severity': issue['severity']['name'],
          'relations': '-',
        };
        checkWarranty(issueDetails['serialNumber'], warrantyInfoList);

        return issueDetails;
      }).toList();
      for (var attachment in attachmentsData) {
        int attachmentId = attachment['id'];
        final String getFileUrl = getAttachmentFileById(issueId, attachmentId);

        final response2 = await http.get(
          Uri.parse(getFileUrl),
          headers: {
            'Authorization': '$token',
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

      issueData.value = extractedData;
    } else {}
  }

  Future<void> pickFile() async {
    if (isPicking.value) return;

    isPicking.value = true;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.isNotEmpty) {
        String? filePath = result.files.single.path;
        String fileName = result.files.single.name;

        if (filePath != null) {
          File file = File(filePath);
          List<int> fileBytes = await file.readAsBytes();
          String base64Content = base64Encode(fileBytes);
          addAttachment({
            'name': fileName,
            'path': filePath,
            'base64': base64Content,
          });
        } else {}
      } else {}
    } finally {
      isPicking.value = false;
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
        fetchData(issueId.toString());
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
        fetchData(issueId.toString());
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
          onRightButtonPressed: completeJob,
        );
      },
    );
  }
}
