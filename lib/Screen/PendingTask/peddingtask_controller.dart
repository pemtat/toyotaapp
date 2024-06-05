import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:http/http.dart' as http;

class PeddingtaskController extends GetxController {
  var issueData = [].obs;
  var attachments = <Map<String, dynamic>>[].obs;
  var moreDetail = false.obs;
  var addAttatchments = <Map<String, dynamic>>[].obs;
  var attachmentsData = <Map<String, dynamic>>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var issueId;
  RxList<WarrantyInfo> warrantyInfoList = <WarrantyInfo>[].obs;

  final BottomBarController bottomController = Get.put(BottomBarController());
  final HomeController jobController = Get.put(HomeController());
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

        var issueDetails = {
          'id': issue['id'],
          'summary': issue['summary'],
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
          attachments.addAll(fileData);
        } else {}
      }

      issueData.value = extractedData;
    } else {}
  }

  void acceptTicket() async {
    final String updateStatus = updateIssueStatusById(issueId);

    String? token = await getToken();
    Map<String, dynamic> body = {
      "status": {"name": "confirm"}
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
