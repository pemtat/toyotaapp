import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/pdfviewer_widget.dart';

class PdfFile extends StatelessWidget {
  final String path;
  final String name;
  final String option;
  const PdfFile(
      {super.key,
      required this.path,
      required this.name,
      required this.option});

  @override
  Widget build(BuildContext context) {
    RxString pdfReport = ''.obs;

    return GestureDetector(
      onTap: () async {
        String? token = await getToken();
        showDialog(
            context: context,
            barrierColor: Color.fromARGB(59, 0, 0, 0),
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: DataCircleLoading());
            });
        await fetchPdfReport(path, token ?? '', pdfReport, option);
        Navigator.pop(context);
        if (pdfReport.value != '') {
          Get.to(() => PdfBase64View(name: name, path: pdfReport.value));
        }
      },
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/pdf.png',
              ),
            ),
          ),
          // Text('View PDF', style: TextStyleList.subtext3),
          // SizedBox(height: 10),
          // ElevatedButton(
          //   onPressed: () async {
          //     String? token = await getToken();
          //     showDialog(
          //         context: context,
          //         barrierColor: Color.fromARGB(59, 0, 0, 0),
          //         barrierDismissible: false,
          //         builder: (BuildContext context) {
          //           return const Center(child: DataCircleLoading());
          //         });
          //     await fetchPdfReport(path, token ?? '', pdfReport, option);
          //     Navigator.pop(context);
          //     if (pdfReport.value.isNotEmpty) {
          //       XFile pdfFile = await base64ToPdfFile(pdfReport.value, name);
          //       Share.shareXFiles([pdfFile]);
          //     }
          //   },
          //   child: Text('แชร์'),
          // ),
        ],
      ),
    );
  }

  Future<XFile> base64ToPdfFile(String base64String, String fileName) async {
    final bytes = base64Decode(base64String);
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.pdf';
    final file = File(filePath);

    await file.writeAsBytes(bytes);

    return XFile(filePath);
  }
}
