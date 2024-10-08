import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';

class PdfBase64View extends StatefulWidget {
  final String name;
  final String path;
  const PdfBase64View({super.key, required this.name, required this.path});

  @override
  _PdfBase64ViewState createState() => _PdfBase64ViewState();
}

class _PdfBase64ViewState extends State<PdfBase64View> {
  bool _isLoading = true;
  PDFDocument? _document;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    String base64String = widget.path;
    Uint8List bytes = base64Decode(base64String);

    Directory tempDir = await getTemporaryDirectory();
    String randomNumber = (Random().nextInt(900000000) + 100000000).toString();

    File tempFile = File('${tempDir.path}/temp_$randomNumber.pdf');
    await tempFile.writeAsBytes(bytes);
    PDFDocument document = await PDFDocument.fromFile(tempFile);

    setState(() {
      _document = document;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackIcon(),
        title: Text(
          widget.name,
          style: TextStyleList.headtitle,
        ),
      ),
      body: _isLoading
          ? const Center(child: DataCircleLoading())
          : PDFViewer(document: _document!),
    );
  }
}
