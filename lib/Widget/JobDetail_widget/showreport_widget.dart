// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/pdf_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/urlimg.dart';

class ShowRepairReport extends StatelessWidget {
  final RxList<RepairReportModel> reportData;
  final RxList<RepairReportModel> additionalReportData;
  final String jobId;
  final RxString timeStart;
  final RxString timeEnd;

  const ShowRepairReport({
    super.key,
    required this.reportData,
    required this.additionalReportData,
    required this.jobId,
    required this.timeStart,
    required this.timeEnd,
  });

  @override
  Widget build(BuildContext context) {
    var space = 8;
    final filteredSparePart =
        reportData.where((data) => data.quantity != '0').toList();
    final filteredAdditionalSparePart =
        additionalReportData.where((data) => data.quantity != '0').toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: white5,
            ),
            child: Obx(() {
              if (reportData.isEmpty) {
                return const Center(child: Text('No report data available.'));
              }
              var data = reportData.first;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxInfo2(
                      title: 'Field Service Report',
                      value: data.fieldReport ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Customer Name', value: data.customerName ?? '-'),
                  space.kH,
                  BoxInfo2(title: 'Department', value: data.department ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Contacted Name',
                      value: data.contactedName ?? '-'),
                  space.kH,
                  BoxInfo2(title: 'Product', value: data.product ?? '-'),
                  space.kH,
                  BoxInfo2(title: 'Model', value: data.model ?? '-'),
                  space.kH,
                  BoxInfo2(title: 'Serial No', value: data.serialNo ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Operation Hour',
                      value: data.operationHour ?? '-'),
                  space.kH,
                  BoxInfo2(title: 'Mast Type', value: data.mastType ?? '-'),
                  space.kH,
                  BoxInfo2(title: 'Lift Hieght', value: data.liftHeight ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Customer Fleet',
                      value: data.customerFleet ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Error Code', value: data.errorCodeReport ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Work Order Number', value: data.orderNo ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'R Code', value: data.rCode ?? '-', space: true),
                  space.kH,
                  BoxInfo2(
                      title: 'W Code', value: data.wCode ?? '-', space: true),
                  space.kH,
                  BoxInfo2(
                      title: 'Repair Procedure',
                      value: data.produre ?? '-',
                      space: true),
                  space.kH,
                  BoxInfo2(
                      title: 'Problem',
                      value: data.problem ?? '-',
                      space: true),
                  space.kH,
                  4.kH,
                  filteredSparePart.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BoxInfo2(title: 'Spare part List', value: ''),
                            4.kH,
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filteredSparePart.length,
                              itemBuilder: (context, index) {
                                final data = filteredSparePart[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(width: 1, color: black3),
                                      color: white1,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: Column(
                                    children: [
                                      BoxInfo(
                                          title: 'C-Code',
                                          value: data.cCode ?? '-'),
                                      BoxInfo(
                                          title: 'Part Number',
                                          value: data.partNumber ?? '-'),
                                      BoxInfo(
                                          title: 'Description',
                                          value: data.description ?? '-'),
                                      BoxInfo(
                                          title: 'Quantity',
                                          value: data.quantity ?? '-'),
                                      BoxInfo(
                                          title: 'Change Now',
                                          value: data.changeNow ?? '-'),
                                      BoxInfo(
                                          title: 'Change on PM',
                                          value: data.changeOnPm ?? '-'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : const BoxInfo2(title: 'Spare part List', value: '-'),
                  8.kH,
                  filteredAdditionalSparePart.isNotEmpty
                      ? Column(
                          children: [
                            const BoxInfo2(
                                title: 'Additional spare part list', value: ''),
                            4.kH,
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filteredAdditionalSparePart.length,
                              itemBuilder: (context, index) {
                                final data = filteredAdditionalSparePart[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 6, top: 2),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(width: 1, color: black3),
                                      color: white1,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: Column(
                                    children: [
                                      BoxInfo(
                                          title: 'C-Code',
                                          value: data.cCode ?? ''),
                                      BoxInfo(
                                          title: 'Part Number',
                                          value: data.partNumber ?? ''),
                                      BoxInfo(
                                          title: 'Description',
                                          value: data.description ?? ''),
                                      BoxInfo(
                                          title: 'Quantity',
                                          value: data.quantity ?? ''),
                                      BoxInfo(
                                          title: 'Change Now',
                                          value: data.changeNow ?? '-'),
                                      BoxInfo(
                                          title: 'Change on PM',
                                          value: data.changeOnPm ?? '-'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : const BoxInfo2(
                          title: 'Additional spare part list', value: '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Repair Result', value: data.repairResult ?? ''),
                  space.kH,
                  BoxInfo2(
                      title: 'ประมาณการซ่อม ชั่วโมง(HR)', value: data.hr ?? ''),
                  space.kH,
                  BoxInfo2(
                      title: 'จำนวนคน(M)',
                      value: data.m == '0' ? '-' : data.m ?? '-'),
                  space.kH,
                  BoxInfo2(
                      title: 'Process staff', value: data.processStaff ?? ''),
                  space.kH,
                  BoxInfo2(title: 'ผู้ตรวจซ่อม 1', value: data.tech1 ?? ''),
                  space.kH,
                  BoxInfo2(title: 'ผู้ตรวจซ่อม 2', value: data.tech2 ?? ''),
                  4.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PdfFile(
                        name: 'Field Service Report',
                        path: jobId,
                        option: 'fieldreport',
                      ),
                    ],
                  ),
                  if (data.signaturePadUrl != null &&
                      data.signaturePadUrl != '')
                    Center(
                      child: Column(
                        children: [
                          12.kH,
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: UrlImageWidget(data.signaturePadUrl ?? ''),
                          ),
                          4.kH,
                          space.kH,
                        ],
                      ),
                    ),
                  if (data.signature != '')
                    ShowTextFieldWidget(
                        text: 'ลงชื่อ', hintText: data.signature ?? ''),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  String formatWCode(String? wCode) {
    if (wCode == null || wCode.isEmpty) return '-';
    var items = wCode.split('%');
    return items.asMap().entries.map((entry) {
      int idx = entry.key + 1;
      String value = entry.value.trim();
      return '$idx. $value';
    }).join('\n');
  }
}
