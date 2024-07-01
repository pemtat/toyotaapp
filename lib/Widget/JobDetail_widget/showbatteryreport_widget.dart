// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/batteryreport_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class ShowBatteryReportWidget extends StatelessWidget {
  final RxList<BatteryReportModel> reportData;
  const ShowBatteryReportWidget({
    super.key,
    required this.reportData,
  });

  @override
  Widget build(BuildContext context) {
    var data = reportData.first;
    var info1 = data.btrMaintenance;
    var specicGravity = data.specicVoltageCheck;
    var condition = data.btrConditions;
    var sparepart = data.btrSpareparts;
    var recommendedSpareparts =
        sparepart!.where((sp) => sp.additional == 'recommended').toList();
    var changeSpareparts =
        sparepart.where((sp) => sp.additional == 'change').toList();
    var filteredBatteryCondition = condition!
        .where((item) =>
            (item.status != null && item.status!.isNotEmpty) &&
            (item.description != null && item.description!.isNotEmpty) &&
            (item.nameEn != null))
        .toList();
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
                const TitleApp(text: "Battery Maintenance Report"),
                10.kH,
                BoxInfo2(
                    title: 'Battery Brand', value: info1!.batteryBand ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Battery Model', value: info1.batteryModel ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'ManuFacturer No.',
                    value: info1.manufacturerNo ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Serial No.', value: info1.batteryLifespan ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Voltage', value: info1.informationVoltage ?? '-'),
                space.kH,
                BoxInfo2(title: 'Capacity', value: info1.capacity ?? '-'),
                space.kH,
                10.kH,
                const TitleApp(text: "Forklife Information"),
                space.kH,
                BoxInfo2(
                    title: 'Forklife Brand', value: info1.forkliftBrand ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Forklife Model', value: info1.forkliftModel ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Serial No', value: info1.forkliftSerial ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Forklife Operation',
                    value: info1.forkliftOperation ?? '-'),
                space.kH,
                10.kH,
                const TitleApp(text: "Battery Usage"),
                space.kH,
                BoxInfo2(title: 'Shift time', value: info1.shiftTime ?? '-'),
                space.kH,
                BoxInfo2(title: 'Hrs. per shift', value: info1.hrs ?? '-'),
                space.kH,
                BoxInfo2(title: 'Ratio', value: info1.ratio ?? '-'),
                space.kH,
                BoxInfo2(
                    title: 'Charging Type',
                    value: info1.chargingType == '1'
                        ? 'Charge when needed'
                        : info1.chargingType == '0'
                            ? 'Only 1 time/day'
                            : '-'),
                4.kH,
                10.kH,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleApp(text: "Specic Gravity and Voltage Checks"),
                    4.kH,
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: specicGravity!.length,
                      itemBuilder: (context, index) {
                        final data = specicGravity[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: black3),
                              color: white1,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                          child: Column(children: [
                            BoxInfo(
                                title: 'Temperature',
                                value: data.temperature ?? '-'),
                            BoxInfo(title: 'TH.P', value: data.thp ?? '-'),
                            BoxInfo(
                                title: 'Voltage',
                                value: data.voltageCheck ?? '-'),
                          ]),
                        );
                      },
                    ),
                  ],
                ),
                10.kH,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleApp(text: "Battery Condition"),
                    4.kH,
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredBatteryCondition.length,
                      itemBuilder: (context, index) {
                        final data = filteredBatteryCondition[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: black3),
                              color: white1,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                          child: Column(children: [
                            BoxInfo(title: 'Name', value: data.nameEn ?? '-'),
                            BoxInfo(title: 'Option', value: data.status ?? '-'),
                            BoxInfo(
                                title: 'Description',
                                value: data.description ?? '-'),
                          ]),
                        );
                      },
                    ),
                  ],
                ),
                space.kH,
                TitleWithButton(
                    titleText: 'Repair P.M Battery',
                    button: Text(
                      info1.correctiveAction ?? '',
                      style: TextStyleList.text3,
                    )),
                space.kH,
                4.kH,
                if (recommendedSpareparts.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleApp(text: "Recommanded Spare Part"),
                      4.kH,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recommendedSpareparts.length,
                        itemBuilder: (context, index) {
                          final data = recommendedSpareparts[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: black3),
                                color: white1,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                            child: Column(children: [
                              BoxInfo(
                                  title: 'C-Code/Page',
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
                            ]),
                          );
                        },
                      ),
                    ],
                  ),
                space.kH,
                TitleWithButton(
                    titleText: 'Repair P.M Battery',
                    button: Text(
                      info1.repairPm ?? '',
                      style: TextStyleList.text3,
                    )),
                space.kH,
                if (changeSpareparts.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleApp(text: "Change Spare Part"),
                      4.kH,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: changeSpareparts.length,
                        itemBuilder: (context, index) {
                          final data = changeSpareparts[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: black3),
                                color: white1,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                            child: Column(children: [
                              BoxInfo(
                                  title: 'C-Code/Page',
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
                            ]),
                          );
                        },
                      ),
                    ],
                  ),
                if (info1.signaturePad != '')
                  Center(
                      child: Column(
                    children: [
                      space.kH,
                      5.kH,
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Base64ImageWidget(info1.signaturePad ?? '')),
                      5.kH,
                    ],
                  )),
                Column(
                  children: [
                    space.kH,
                    ShowTextFieldWidget(
                        text: 'ลงชื่อ', hintText: info1.signature ?? ''),
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
