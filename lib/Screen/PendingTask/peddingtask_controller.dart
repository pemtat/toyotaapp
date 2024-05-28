import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PeddingtaskController extends GetxController {
  var issueData = [].obs;
  var attatchments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  var issueId;
  final BottomBarController bottomController = Get.put(BottomBarController());

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
        List<Map<String, dynamic>> attachments = [];
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

  void acceptTicket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String updateStatus = '$updateIssueStatusById/$issueId';

    String? token = prefs.getString('token');
    Map<String, dynamic> body = {
      "status": {"name": "assigned"}
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
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: acceptTicket,
        );
      },
    );
  }
}
