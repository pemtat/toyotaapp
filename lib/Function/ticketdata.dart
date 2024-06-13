import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/checklevel.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/pdfget.dart';
import 'package:toyotamobile/Models/subjobdetail_model.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

final BottomBarController bottomController = Get.put(BottomBarController());
final HomeController jobController = Get.put(HomeController());
void fetchSubJob(String subjobId, String token, RxList<JobById> subJobs) async {
  try {
    final response = await http.get(
      Uri.parse(getSubJobById(subjobId)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      SubJobDetail data = SubJobDetail.fromJson(
        jsonDecode(response.body),
      );
      if (data.jobById != null) {
        subJobs.value = data.jobById!;
      }
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void fetchReadAttachment(
    int issueId,
    String token,
    List<Attachments>? getAttachments,
    List<Map<String, dynamic>> attachmentsData,
    List<Map<String, dynamic>> attatchments) async {
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

void fetchNotes(List<Notes>? notes, RxList<Notes> notesFiles) {
  if (notes != null) {
    var issueNotes = notes as List<Notes>;
    notesFiles.assignAll(issueNotes);
  }
}

void fetchNotesPic(
    List<Notes>? notes, RxList<Notes> notesFiles, List<String> notePic) {
  if (notes != null) {
    var issueNotes = notes as List<Notes>;
    notesFiles.assignAll(issueNotes);

    notesFiles.forEach((note) async {
      var reporterId = note.reporter!.id;
      notePic.add(await checkLevel(reporterId ?? 0));
    });
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

Future<void> pickImage(
    RxList<Map<String, String>> file, Rx<bool> isPicking) async {
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

void saveCurrentDateTime(Rx<String> datetime) {
  DateTime now = DateTime.now();
  datetime.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
}
