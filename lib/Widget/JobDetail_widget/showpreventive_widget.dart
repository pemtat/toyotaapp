// ignore_for_file: file_names
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class ShowPreventiveReportWidget extends StatelessWidget {
  final RxList<PreventivereportModel> reportData;

  ShowPreventiveReportWidget({
    super.key,
    required this.reportData,
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
                          TitleApp(text: data.nameEn ?? ''),
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
                const TitleApp(
                    text: 'ความสมบูรณ์ของอุปกรณ์ Safety ตามกฎกระทราวง'),
                BoxInfo(
                    title: 'Travel Alarm',
                    value: maintenance!.safetyTravelAlarm!.isEmpty
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
                          const BoxInfo2(
                              title:
                                  'Description Problem / Action and Result\nRecommend spare part changed',
                              value: ''),
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
                                'Description Problem / Action and Result\nRecommend spare part changed',
                            moreText: '-',
                          ),
                        ],
                      ),
                space2.kH,
                TitleApp2(
                  text:
                      'ผลการตรวจเช็คเเละการบำรุงรักษา\n(Maintenance and service resul)',
                  moreText: maintenance.mtServiceResult == ''
                      ? '-'
                      : maintenance.mtServiceResult,
                ),
                space2.kH,
                TitleApp2(
                  text: 'ประมาณการซ่อม ชั่วโมง(HR)',
                  moreText: maintenance.hr == '0' ? '-' : maintenance.hr,
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

                if (maintenance.signaturePad != '')
                  Center(
                      child: Column(
                    children: [
                      space.kH,
                      5.kH,
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Base64ImageWidget(
                              maintenance.signaturePad ?? '')),
                      5.kH,
                    ],
                  )),
                if (maintenance.signature != '')
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
      return 'Ok';
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
