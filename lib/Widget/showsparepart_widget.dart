import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Widget/loadingdata.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

// ignore: must_be_immutable
class ShowSparePart extends StatelessWidget {
  final String jobId;
  final String? ticketId;
  final String? optionBottomBar;
  ShowSparePart(
      {super.key, required this.jobId, this.ticketId, this.optionBottomBar});

  final JobDetailController jobController = Get.put(JobDetailController());

  var signaturePad = ''.obs;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(16),
      actionsPadding: const EdgeInsets.all(6),
      backgroundColor: white4,
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: white1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Sparepart Request Status', style: TextStyleList.title1),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.6),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ticket : ${ticketId}',
                          style: TextStyleList.title1,
                        ),
                        Row(
                          children: [
                            Text(
                              'Lead Tech :',
                              style: TextStyleList.subtitle1,
                            ),
                            4.wH,
                            StatusButton2(
                                status: jobController
                                    .subJobs.first.leadTechStatus
                                    .toString()),
                          ],
                        )
                      ],
                    ),
                    6.kH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BB no. : ${jobController.subJobs.first.referenceCode ?? ''}',
                          style: TextStyleList.title1,
                        ),
                        Row(
                          children: [
                            Text(
                              'Sales',
                              style: TextStyleList.subtitle8,
                            ),
                            Text(
                              ' :',
                              style: TextStyleList.title1,
                            ),
                            4.wH,
                            StatusButton2(
                                status: jobController.subJobs.first.salesStatus
                                    .toString()),
                          ],
                        )
                      ],
                    ),
                    10.kH,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Warranty : ',
                          style: TextStyleList.text1,
                        ),
                        CheckStatus(
                            status: jobController
                                    .warrantyInfo.first.warrantystatus ??
                                '')
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Issue Remark : ${jobController.subJobs.first.description == '' ? '-' : '-'}',
                          style: TextStyleList.text1,
                        ),
                      ],
                    ),
                    jobController.reportList.first.quantity != '0'
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Spare Part List',
                                    style: TextStyleList.subtitle4,
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: DataTable(
                                    dataTextStyle: TextStyleList.text9,
                                    headingTextStyle: TextStyleList.detail2,
                                    horizontalMargin: 0,
                                    columns: const [
                                      DataColumn(label: Text('Item')),
                                      DataColumn(label: Text('Unit')),
                                      DataColumn(label: Text('Store')),
                                      DataColumn(label: Text('Status')),
                                    ],
                                    rows: jobController.reportList.map((data) {
                                      return DataRow(cells: [
                                        DataCell(Text(data.partNumber ?? '')),
                                        DataCell(Text(data.quantity ?? '0')),
                                        DataCell(Text(data.quantity ?? '0')),
                                        const DataCell(Text('Ready')),
                                      ]);
                                    }).toList()),
                              ),
                            ],
                          )
                        : Container(),
                    jobController.additionalReportList.first.quantity != '0'
                        ? Column(
                            children: [
                              10.kH,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Additional Spare Part List',
                                    style: TextStyleList.subtitle4,
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: DataTable(
                                    horizontalMargin: 0,
                                    dataTextStyle: TextStyleList.text9,
                                    headingTextStyle: TextStyleList.detail2,
                                    columns: const [
                                      DataColumn(label: Text('Item')),
                                      DataColumn(label: Text('Unit')),
                                      DataColumn(label: Text('Store')),
                                      DataColumn(label: Text('Status')),
                                    ],
                                    rows: jobController.additionalReportList
                                        .map((data) {
                                      return DataRow(cells: [
                                        DataCell(Text(data.partNumber ?? '')),
                                        DataCell(Text(data.quantity ?? '0')),
                                        DataCell(Text(data.quantity ?? '0')),
                                        const DataCell(Text('Ready')),
                                      ]);
                                    }).toList()),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ))
          ],
        ),
      ),
      actions: <Widget>[
        optionBottomBar != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ยกเลิก',
                      style: TextStyleList.text5,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String? token = await getToken();
                      showDialog(
                          context: context,
                          barrierColor: Color.fromARGB(59, 0, 0, 0),
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const LoadingDialog();
                          });
                      // await updateJobSparePart(jobId, 1);
                      await fetchSubJob(
                          jobId, token ?? '', jobController.subJobs);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showSaveMessage();
                    },
                    child: Text(
                      'ยืนยัน',
                      style: TextStyleList.text5,
                    ),
                  ),
                ],
              )
            : TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  'ปิด',
                  style: TextStyleList.text5,
                ),
              ),
      ],
    );
  }
}
