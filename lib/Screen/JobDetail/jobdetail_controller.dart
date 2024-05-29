import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

class JobDetailController extends GetxController {
  final notes = TextEditingController().obs;
  var issueData = [].obs;
  var attatchments = <Map<String, dynamic>>[].obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  var issueId;
  final HomeController jobController = Get.put(HomeController());
  void fetchData(String ticketId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String apiUrl = '$getTicketbyId$ticketId';
    String? token = prefs.getString('token');

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

        return {
          'id': issue['id'],
          'summary': issue['summary'],
          'description': issue['description'],
          'created_at': issue['created_at'],
          'reporter': issue['reporter']['name'],
          'email': issue['reporter']['email'],
          'category': issue['category']['name'],
          'severity': issue['severity']['name'],
          'relations': '-',
        };
      }).toList();

      for (var attachment in attachmentsData) {
        int attachmentId = attachment['id'];
        final String getFileUrl =
            '$getAttachmentFileById/$issueId/files/$attachmentId';

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
    } else {
      print('Failed to load data. Error ${response.statusCode}');
    }
  }

  Future<void> pickFile() async {
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
      } else {
        print('File path is null');
      }
    } else {
      print('No file picked');
    }
  }

  void addAttachment(Map<String, String> file) {
    addAttatchments.add(file);
  }

  void submitNote() {
    if (addAttatchments.isNotEmpty) {
      var file = addAttatchments.first;
      String name = file['name'];
      String content = file['base64'];
    }
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
