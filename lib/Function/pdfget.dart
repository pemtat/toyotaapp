import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Models/pdf_model.dart';
import 'package:toyotamobile/Service/api.dart';

Future<void> fetchPdfData(
    String id, String token, RxList<Map<String, dynamic>> pdfList) async {
  pdfList.clear();
  try {
    final response = await http.get(
      Uri.parse(getPdfById(id)),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var pdfModel = PdfModel.fromJson(data);
      pdfList
          .assignAll(pdfModel.pdfs?.map((pdf) => pdf.toJson()).toList() ?? []);
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
