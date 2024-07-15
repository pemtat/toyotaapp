import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

// ignore: must_be_immutable
class SignatureWidget extends StatelessWidget {
  final String jobId;
  final String? ticketId;
  final String? option;

  SignatureWidget({
    super.key,
    required this.jobId,
    this.option,
    this.ticketId,
  });

  final TextEditingController signatureController = TextEditingController();
  final GlobalKey<SfSignaturePadState> signature = GlobalKey();
  final JobDetailController jobController = Get.put(JobDetailController());
  final JobDetailControllerPM jobControllerPM =
      Get.put(JobDetailControllerPM());

  var signaturePad = ''.obs;
  @override
  Widget build(BuildContext context) {
    var saveCompletedtime = ''.obs;
    return AlertDialog(
      backgroundColor: white4,
      title: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: white4,
        title: Text('บันทึกลายเซ็น', style: TextStyleList.title1),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: SfSignaturePad(
                key: signature,
                onDrawEnd: saveSignature,
                backgroundColor: Colors.white,
                strokeColor: Colors.black,
                minimumStrokeWidth: 1.0,
                maximumStrokeWidth: 4.0,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: clearSignature,
                  child: Text(
                    'Clear',
                    style: TextStyleList.text20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFieldWidget(text: 'ลงชื่อ', textSet: signatureController),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            saveCurrentDateTime(saveCompletedtime);
            if (ticketId != null) {
              updateSignatureJob(jobId, ticketId ?? '', saveCompletedtime.value,
                  signatureController.value.text, signaturePad.value);
              jobController.fetchData(ticketId.toString(), jobId.toString());
            } else {
              if (option == 'battery') {
                changeIssueSignaturePM(
                    jobId,
                    saveCompletedtime.value,
                    signatureController.value.text,
                    signaturePad.value,
                    'battery');
              } else {
                changeIssueSignaturePM(
                    jobId,
                    saveCompletedtime.value,
                    signatureController.value.text,
                    signaturePad.value,
                    'preventive');
              }
            }
            Navigator.pop(context);
          },
          child: Text(
            'บันทึก',
            style: TextStyleList.text5,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'ยกเลิก',
            style: TextStyleList.text5,
          ),
        ),
      ],
    );
  }

  void clearSignature() {
    signature.currentState!.clear();
  }

  Future<void> saveSignature() async {
    if (signature.currentState != null) {
      try {
        final data = await signature.currentState!.toImage(pixelRatio: 3.0);
        final byteData = await data.toByteData(format: ImageByteFormat.png);
        String base64String = base64Encode(byteData!.buffer.asUint8List());
        signaturePad.value = base64String;
      } catch (e) {
        print('Error saving signature: $e');
      }
    } else {
      print('Signature pad not initialized');
    }
  }
}
