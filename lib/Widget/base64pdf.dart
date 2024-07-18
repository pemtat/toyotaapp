import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:toyotamobile/Service/api.dart';
import 'dart:io';

import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AttachmentsListPdfWidget extends StatelessWidget {
  final List<Map<String, dynamic>> attachments;

  const AttachmentsListPdfWidget(this.attachments, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: attachments.map((attachment) {
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: GestureDetector(
              onTap: () async {
                // String pdfFilePath =
                //     await _createPdfFile(attachment['content']);
                openPdf(attachment['filepath']);
                // Get.to(
                //     () => PdfViewerScreen(pdfFilePath, attachment['filename']));
              },
              child: Column(
                children: [
                  SizedBox(
                    width: 46,
                    height: 46,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.asset(
                        'assets/pdf.png',
                      ),
                    ),
                  ),
                  4.kH,
                  Text(attachment['filename'], style: TextStyleList.subtext3),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<String> _createPdfFile(String base64String) async {
    Uint8List pdfBytes = base64Decode(base64String);
    final directory = await getApplicationDocumentsDirectory();
    final pdfFile = File(
        '${directory.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await pdfFile.writeAsBytes(pdfBytes);
    return pdfFile.path;
  }
}

Future<void> openPdf(String path) async {
  String googleUrl = "$url/$path";

  if (await canLaunchUrlString(googleUrl)) {
    await launchUrlString(googleUrl);
  } else {
    print('Could not launch $googleUrl');
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfFilePath;
  final String filename;

  const PdfViewerScreen(this.pdfFilePath, this.filename, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filename),
      ),
      body: PDFView(
        filePath: pdfFilePath,
      ),
    );
  }
}
