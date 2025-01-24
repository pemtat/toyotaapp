import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Widget/loadingdata.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

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
  var customerChecking = 0.obs;
  var customerScore = 0.obs;
  var customerDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var saveCompletedtime = ''.obs;
    return AlertDialog(
      backgroundColor: white4,
      title: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: white4,
        title: Text(context.tr('save_signature'), style: TextStyleList.title1),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr('customer_checking'),
                style: TextStyleList.detail2
                    .copyWith(decoration: TextDecoration.underline)),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      activeColor: Colors.red,
                      value: 1,
                      groupValue: customerChecking.value,
                      onChanged: (value) {
                        customerChecking.value = value as int;
                      },
                    ),
                    Text(context.tr('checking_done')),
                    Radio(
                      activeColor: Colors.red,
                      value: 2,
                      groupValue: customerChecking.value,
                      onChanged: (value) {
                        customerChecking.value = value as int;
                      },
                    ),
                    Text(context.tr('checking_not_done')),
                  ],
                )),
            10.kH,
            Text(context.tr('customer_score'),
                style: TextStyleList.detail2
                    .copyWith(decoration: TextDecoration.underline)),
            Column(
              children: List.generate(5, (index) {
                return Obx(() => Row(
                      children: [
                        Radio(
                          activeColor: Colors.red,
                          value: index + 1,
                          groupValue: customerScore.value,
                          onChanged: (value) {
                            customerScore.value = value as int;
                          },
                        ),
                        Text([
                          context.tr('very_satisfied'),
                          context.tr('satisfied'),
                          context.tr('neutral'),
                          context.tr('dissatisfied'),
                          context.tr('need_improvement'),
                        ][index]),
                      ],
                    ));
              }),
            ),
            10.kH,
            Text(context.tr('customer_description'),
                style: TextStyleList.detail2
                    .copyWith(decoration: TextDecoration.underline)),
            10.kH,
            TextFieldType(
                hintText: context.tr('description'),
                textSet: customerDescription),
            16.kH,
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: clearSignature,
                  child: Text(
                    context.tr('clear'),
                    style: TextStyleList.text20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
                text: context.tr('sign'), textSet: signatureController),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            String customerDescriptionText =
                customerDescription.value.text.isNotEmpty
                    ? customerDescription.value.text
                    : '';

            if (signaturePad.value == '') {
              showMessage(context.tr('signature_require_1'));
            } else if (signatureController.value.text == '') {
              showMessage(context.tr('signature_require_2'));
            } else {
              var token = await getToken();
              showDialog(
                  context: context,
                  barrierColor: Color.fromARGB(59, 0, 0, 0),
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const LoadingDialog();
                  });
              saveCurrentDateTime(saveCompletedtime);
              if (ticketId != null) {
                if (option == 'battery') {
                  await updateJobSignatureBattery(
                      jobId,
                      saveCompletedtime.value,
                      signatureController.value.text,
                      signaturePad.value,
                      customerChecking.value,
                      customerScore.value,
                      customerDescriptionText);
                  await fetchJobBatteryReportData(
                      jobId, token ?? '', jobController.reportBatteryList);
                } else {
                  await updateSignatureJob(
                      jobId,
                      ticketId ?? '',
                      saveCompletedtime.value,
                      signatureController.value.text,
                      signaturePad.value,
                      customerChecking.value,
                      customerScore.value,
                      customerDescriptionText);
                  await fetchReportData(
                      jobId,
                      token ?? '',
                      jobController.reportList,
                      jobController.additionalReportList);
                }
                // await jobController.fetchData(
                //     ticketId.toString(), jobId.toString());
                showSignatureSaveMessage();
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                showDialog(
                    context: context,
                    barrierColor: Color.fromARGB(59, 0, 0, 0),
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const LoadingDialog();
                    });

                if (option == 'battery') {
                  await changeIssueSignaturePM(
                      jobId,
                      saveCompletedtime.value,
                      signatureController.value.text,
                      signaturePad.value,
                      'battery',
                      customerChecking.value,
                      customerScore.value,
                      customerDescriptionText);
                  // await jobControllerPM.fetchData(jobId.toString());
                  await fetchBatteryReportData(
                      jobId, token ?? '', jobControllerPM.reportList);
                  showSignatureSaveMessage();
                } else if (option == 'preventive') {
                  await changeIssueSignaturePM(
                      jobId,
                      saveCompletedtime.value,
                      signatureController.value.text,
                      signaturePad.value,
                      'preventive',
                      customerChecking.value,
                      customerScore.value,
                      customerDescriptionText);
                  await fetchPreventiveReportData(
                      jobId, token ?? '', jobControllerPM.reportPreventiveList);
                  showSignatureSaveMessage();
                } else {
                  await changeIssueSignaturePM(
                      jobId,
                      saveCompletedtime.value,
                      signatureController.value.text,
                      signaturePad.value,
                      'preventive_ic',
                      customerChecking.value,
                      customerScore.value,
                      customerDescriptionText);
                  await fetchPreventiveICReportData(jobId, token ?? '',
                      jobControllerPM.reportPreventiveListIc);
                  showSignatureSaveMessage();
                }
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }
          },
          child: Text(
            context.tr('save'),
            style: TextStyleList.text5,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            context.tr('cancel'),
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
