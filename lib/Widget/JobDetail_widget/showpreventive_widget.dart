// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/preventivereport_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class ShowPreventiveReportWidget extends StatelessWidget {
  final RxList<PreventivereportModel> reportData;
  const ShowPreventiveReportWidget({
    super.key,
    required this.reportData,
  });

  @override
  Widget build(BuildContext context) {
    var data = reportData.first;
    var fullMaintenanceRecords = data.pvtCheckingTypeMaster;
    var maintenance = data.pvtMaintenance;
    bool checksignaturePad =
        maintenance?.signaturePad != null && maintenance?.signaturePad != '';
    bool checksignature =
        maintenance?.signature != null && maintenance?.signature != '';
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: fullMaintenanceRecords!.length,
                  itemBuilder: (context, index) {
                    final data = fullMaintenanceRecords[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
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
                                      border:
                                          Border.all(width: 1, color: black3),
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
                                            value: subData.ok ?? '-'),
                                        if (subData.data1 != '')
                                          Text(subData.data1 ?? ''),
                                        if (subData.data2 != '')
                                          Text(subData.data2 ?? ''),
                                        BoxInfo(
                                            title: 'Remark',
                                            value: subData.remark == ''
                                                ? '-'
                                                : subData.remark ?? ''),
                                      ]),
                                );
                              },
                            ),
                          ]),
                    );
                  },
                ),
                if (checksignaturePad)
                  Center(
                      child: Column(
                    children: [
                      space.kH,
                      5.kH,
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Base64ImageWidget(
                              maintenance!.signaturePad ?? '')),
                      5.kH,
                    ],
                  )),
                if (checksignature)
                  Column(
                    children: [
                      space.kH,
                      ShowTextFieldWidget(
                          text: 'ลงชื่อ',
                          hintText: maintenance!.signature ?? ''),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
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
