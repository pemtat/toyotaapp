// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/repairreport_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class ShowRepairReport extends StatelessWidget {
  final RxList<RepairReportModel> reportData;
  final RxList<RepairReportModel> additionalReportData;
  const ShowRepairReport(
      {super.key,
      required this.reportData,
      required this.additionalReportData});

  @override
  Widget build(BuildContext context) {
    var data = reportData.first;

    var space = 8;
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
                BoxInfo2(title: 'Fault', value: data.faultReport ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Error Code', value: data.errorCodeReport ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Work Order Number', value: data.orderNo ?? '-'),
                space.kH,
                BoxInfo2(title: 'R Code', value: data.rCode ?? '-'),
                space.kH,
                BoxInfo2(title: 'W Code', value: data.wCode ?? '-'),
                space.kH,
                BoxInfo2(title: 'Repair Procedure', value: data.produre ?? '-'),
                space.kH,
                BoxInfo2(title: 'Problem', value: data.problem ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Spare part List',
                    value: reportData.isEmpty ? '-' : ''),
                4.kH,
                if (reportData.first.cCode != '-' &&
                    reportData.first.partNumber != '-' &&
                    reportData.first.description != '-' &&
                    reportData.first.quantity != 0 &&
                    reportData.first.changeNow != '-' &&
                    reportData.first.changeOnPm != '-')
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: reportData.length,
                    itemBuilder: (context, index) {
                      final data = reportData[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: black3),
                            color: white1,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        child: Column(children: [
                          BoxInfo(title: 'C-Code', value: data.cCode ?? '-'),
                          BoxInfo(
                              title: 'Part Number',
                              value: data.partNumber ?? '-'),
                          BoxInfo(
                              title: 'Description',
                              value: data.description ?? '-'),
                          BoxInfo(
                              title: 'Quantity', value: data.quantity ?? ''),
                        ]),
                      );
                    },
                  ),
                BoxInfo2(
                    title: 'Additional spare part list',
                    value: additionalReportData.isEmpty ? '-' : ''),
                4.kH,
                if (additionalReportData.isNotEmpty)
                  if (additionalReportData.first.cCode != '-' &&
                      additionalReportData.first.partNumber != '-' &&
                      additionalReportData.first.description != '-' &&
                      additionalReportData.first.quantity != 0 &&
                      additionalReportData.first.changeNow != '-' &&
                      additionalReportData.first.changeOnPm != '-')
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: additionalReportData.length,
                      itemBuilder: (context, index) {
                        final data = additionalReportData[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 6, top: 2),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: black3),
                              color: white1,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                          child: Column(children: [
                            BoxInfo(title: 'C-Code', value: data.cCode ?? ''),
                            BoxInfo(
                                title: 'Part Number',
                                value: data.partNumber ?? ''),
                            BoxInfo(
                                title: 'Description',
                                value: data.description ?? ''),
                            BoxInfo(
                                title: 'Quantity', value: data.quantity ?? ''),
                          ]),
                        );
                      },
                    ),
                space.kH,
                BoxInfo2(
                    title: 'Repair Result', value: data.repairResult ?? ''),
                space.kH,
                BoxInfo2(
                    title: 'Process staff', value: data.processStaff ?? ''),
                space.kH,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
