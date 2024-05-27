import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class Base64ImageWidget extends StatelessWidget {
  final Uint8List imageData;

  Base64ImageWidget(this.imageData);

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageData,
      fit: BoxFit.cover,
    );
  }
}

class PeddingtaskController extends GetxController {
  var issueData = [].obs;
  var moreDetail = false.obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  var issueId;

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
          attachments.forEach((attachment) {
            Map<String, dynamic> attachmentMap = {
              'id': attachment['id'],
              'filename': attachment['filename'],
            };
            attachmentsData.add(attachmentMap);
          });
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

      if (attachmentsData.isNotEmpty) {
        int firstAttachmentId = attachmentsData[0]['id'];
        final String getFileUrl =
            '$getAttachmentFileById/$issueId/files/$firstAttachmentId';

        final response2 = await http.get(
          Uri.parse(getFileUrl),
          headers: {
            'Authorization': '$token',
          },
        );
        if (response2.statusCode == 200) {
          print(response2.body);
        } else {}
      }

      issueData.value = extractedData;
      print(issueData);
      print(attachmentsData);
    } else {
      print('Failed to load data. Error ${response.statusCode}');
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
          onRightButtonPressed: complete,
        );
      },
    );
  }

  Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }

  void complete() {}
}
