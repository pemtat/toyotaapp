import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Styles/text.dart';
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
          Text('View PDF', style: TextStyleList.subtext3),
        ],
      ),
    );
  }
}
