// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/pdf_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/urlimg.dart';

class ShowPreventiveReportWidget extends StatelessWidget {
  final RxList<PreventivereportModel> reportData;
  final String bugId;
  final RxString timeStart;
  final RxString timeEnd;
  const ShowPreventiveReportWidget({
    super.key,
    required this.reportData,
    required this.bugId,
    required this.timeStart,
    required this.timeEnd,
  });
  @override
  Widget build(BuildContext context) {
    var data = reportData.first;
    var fullMaintenanceRecords = data.pvtCheckingTypeMaster;
    var maintenance = data.pvtMaintenance;
    var sparePart = data.darDetails;

    var space = 8;
    var space2 = 10;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space.kH,
                BoxInfo2(
                    title: 'Customer Name',
                    value: maintenance!.customerName ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Department', value: maintenance.department ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Contacted Name',
                    value: maintenance.contactedName ?? '-'),
                space.kH,
                BoxInfo2(title: 'Product', value: maintenance.product ?? '-'),
                space.kH,
                BoxInfo2(title: 'Model', value: maintenance.model ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Serial No', value: maintenance.serialNo ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Operation Hour',
                    value: maintenance.operationHour ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Mast Type', value: maintenance.mastType ?? '-'),
                space.kH,

                BoxInfo2(
                    title: 'Lift Hieght', value: maintenance.liftHeight ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Customer Fleet',
                    value: maintenance.customerFleet ?? '-'),
                space.kH,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: fullMaintenanceRecords!.length,
                  itemBuilder: (context, index) {
                    final data = fullMaintenanceRecords[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleApp2(text: data.nameEn ?? ''),
                          10.kH,
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.maintenanceRecords!.length,
                            itemBuilder: (context, index) {
                              final subData = data.maintenanceRecords![index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: black3),
                                    color: white1,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BoxInfo(
                                        title:
                                            '[${subData.pvtCategoryCode}] ${subData.fullName}',
                                        value: checkStatus(subData.ok ?? '',
                                            subData.poor ?? ''),
                                      ),
                                      BoxInfo(
                                          title: 'Remark',
                                          value: subData.remark == ''
                                              ? '-'
                                              : subData.remark ?? ''),
                                    ]),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                space.kH,
                const TitleApp2(
                    text: 'ความสมบูรณ์ของอุปกรณ์ Safety ตามกฎกระทราวง'),
                4.kH,
                BoxInfo(
                    title: 'Travel Alarm',
                    value: maintenance.safetyTravelAlarm!.isEmpty
                        ? '-'
                        : maintenance.safetyTravelAlarm ?? ''),
                BoxInfo(
                    title: 'กระจกมองหลัง/ข้าง',
                    value: maintenance.safetyRearviewMirror == ''
                        ? '-'
                        : maintenance.safetyRearviewMirror ?? ''),
                BoxInfo(
                    title: 'เข็มขัดนิรภัย',
                    value: maintenance.safetySeatBelt == ''
                        ? '-'
                        : maintenance.safetySeatBelt ?? ''),

                // ignore: unrelated_type_equality_checks
                sparePart!.first.qty != '0'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          space.kH,
                          const TitleApp2(
                            text:
                                'Description Problem / Action and Result / Recommend spare part changed',
                            moreText: '',
                          ),
                          6.kH,
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sparePart.length,
                            itemBuilder: (context, index) {
                              final data = sparePart[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: black3),
                                    color: white1,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Column(children: [
                                  BoxInfo(
                                      title: 'C-Code',
                                      value: data.pageCode ?? '-'),
                                  BoxInfo(
                                      title: 'Part Number',
                                      value: data.partNumber ?? '-'),
                                  BoxInfo(
                                      title: 'Description',
                                      value: data.description ?? '-'),
                                  BoxInfo(
                                      title: 'Quantity',
                                      value: data.qty ?? '-'),
                                ]),
                              );
                            },
                          ),
                          space.kH,
                        ],
                      )
                    : Column(
                        children: [
                          space.kH,
                          const TitleApp2(
                            text:
                                'Description Problem / Action and Result / Recommend spare part changed',
                            moreText: '-',
                          ),
                        ],
                      ),
                space2.kH,
                TitleWithButton(
                    space: true,
                    titleText:
                        'ผลการตรวจเช็คเเละการบำรุงรักษา (Maintenance and service result)',
                    button: Text(
                      maintenance.mtServiceResult == ''
                          ? '-'
                          : maintenance.mtServiceResult ?? '',
                      style: TextStyleList.text3,
                    )),
                space2.kH,
                TitleApp2(
                  text: 'ประมาณการซ่อม ชั่วโมง(HR)',
                  moreText: maintenance.hr == '-' ? '-' : maintenance.hr,
                ),
                space2.kH,
                TitleApp2(
                  text: 'จำนวนคน(M)',
                  moreText: maintenance.m == '0' ? '-' : maintenance.m,
                ),
                space2.kH,
                TitleApp2(
                  text: 'สำหรับเจ้าหน้าที่',
                  moreText: maintenance.officerChecking == ''
                      ? '-'
                      : maintenance.officerChecking,
                ),

                space.kH,
                TitleApp2(
                    text: 'ผู้ตรวจซ่อม 1', moreText: maintenance.tech1 ?? ''),
                space.kH,
                TitleApp2(
                    text: 'ผู้ตรวจซ่อม 2', moreText: maintenance.tech2 ?? ''),

                4.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PdfFile(
                      name: 'Periodic Maintenance Report',
                      path: bugId,
                      option: 'pvt',
                    )
                  ],
                ),

                if (maintenance.signaturePadUrl != null)
                  Center(
                      child: Column(
                    children: [
                      space.kH,
                      6.kH,
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: UrlImageWidget(
                              maintenance.signaturePadUrl ?? '')),
                      6.kH,
                    ],
                  )),
                if (maintenance.signature != null)
                  Column(
                    children: [
                      space.kH,
                      ShowTextFieldWidget(
                          text: 'ลงชื่อ',
                          hintText: maintenance.signature ?? ''),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String checkStatus(String ok, String poor) {
    if (ok == '1' && poor == '0') {
      return 'Good';
    } else if (ok == '0' && poor == '1') {
      return 'Poor';
    } else if (ok == '0' && poor == '0') {
      return '-';
    } else
      return '-';
  }

  String formatWCode(String? wCode) {
    if (wCode == null || wCode.isEmpty) return '-';
    var items = wCode.split(',');
    return items.asMap().entries.map((entry) {
      int idx = entry.key + 1;
      String value = entry.value.trim();
      return '$idx. $value';
    }).join('\n');
  }
}
