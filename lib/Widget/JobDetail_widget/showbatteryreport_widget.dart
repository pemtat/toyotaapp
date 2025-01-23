// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/batteryreport_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/pdf_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/urlimg.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class ShowBatteryReportWidget extends StatelessWidget {
  final RxList<BatteryReportModel> reportData;
  final String bugId;
  final String pdfOption;
  final RxString timeStart;
  final RxString timeEnd;
  const ShowBatteryReportWidget({
    super.key,
    required this.reportData,
    required this.bugId,
    required this.pdfOption,
    required this.timeStart,
    required this.timeEnd,
  });

  @override
  Widget build(BuildContext context) {
    var data = reportData.first;
    var info1 = data.btrMaintenance;
    var specicGravity = data.specicVoltageCheck;
    var condition = data.btrConditions;
    condition!.sort((a, b) =>
        int.parse(a.itemId ?? '').compareTo(int.parse(b.itemId ?? '')));
    var sparepart = data.btrSpareparts;
    var recommendedSpareparts = sparepart!
        .where((sp) => sp.additional == 'recommended' && sp.quantity != '0')
        .toList();
    var changeSpareparts =
        sparepart.where((sp) => sp.additional == 'change').toList();
    var filteredBatteryCondition = condition
        .where((item) =>
            (item.status != null && item.status!.isNotEmpty) ||
            (item.description != null && item.description!.isNotEmpty))
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
                // TitleApp2(
                //   text: context.tr('battery_maintenance_report'),
                // ),
                // 10.kH,
                BoxInfo2(
                    title: context.tr('customer_name'),
                    value: info1!.customerName ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('contact_person'),
                    value: info1.contactPerson ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('division'),
                    value: info1.division ?? '-'),
                10.kH,
                BoxInfo2(
                    title: context.tr('battery_band'),
                    value: info1.batteryBand ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('battery_model'),
                    value: info1.batteryModel ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('manufacturer_no'),
                    value: info1.manufacturerNo ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('battery_serial'),
                    value: info1.serialNo ?? '-'),
                space.kH,
                (info1.batteryLifespan == '0' &&
                        info1.informationVoltage == '0' &&
                        info1.capacity == '0')
                    ? Column(
                        children: [
                          BoxInfo2(
                              title: context.tr('battery_lifespan'),
                              value: '-'),
                          space.kH,
                          BoxInfo2(title: context.tr('voltage'), value: '-'),
                          space.kH,
                          BoxInfo2(title: context.tr('capacity'), value: '-'),
                        ],
                      )
                    : Column(
                        children: [
                          BoxInfo2(
                              title: context.tr('battery_lifespan'),
                              value: info1.batteryLifespan ?? '-'),
                          space.kH,
                          BoxInfo2(
                              title: context.tr('voltage'),
                              value: info1.informationVoltage ?? '-'),
                          space.kH,
                          BoxInfo2(
                              title: context.tr('capacity'),
                              value: info1.capacity ?? '-'),
                        ],
                      ),
                space.kH,
                10.kH,
                TitleApp2(text: context.tr('forklift_operation')),
                space.kH,
                BoxInfo2(
                    title: context.tr('forklift_brand'),
                    value: info1.forkliftBrand ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('forklift_model'),
                    value: info1.forkliftModel ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('forklift_serial_no'),
                    value: info1.forkliftSerial ?? '-'),
                space.kH,
                BoxInfo2(
                    title: context.tr('forklift_operation'),
                    value: info1.forkliftOperation == '0'
                        ? '-'
                        : info1.forkliftOperation ?? '-'),
                space.kH,
                10.kH,
                TitleApp2(text: context.tr('battery_usage')),
                space.kH,
                (info1.shiftTime == '0' &&
                        info1.hrs == '0' &&
                        info1.ratio == '0')
                    ? Column(
                        children: [
                          BoxInfo2(title: context.tr('shift_time'), value: '-'),
                          space.kH,
                          BoxInfo2(
                              title: context.tr('hrs_per_shift'), value: '-'),
                          space.kH,
                          BoxInfo2(title: context.tr('ratio'), value: '-'),
                        ],
                      )
                    : Column(
                        children: [
                          BoxInfo2(
                              title: context.tr('shift_time'),
                              value: info1.shiftTime ?? '-'),
                          space.kH,
                          BoxInfo2(
                              title: context.tr('hrs_per_shift'),
                              value: info1.hrs ?? '-'),
                          space.kH,
                          BoxInfo2(
                              title: context.tr('ratio'),
                              value: info1.ratio ?? '-'),
                        ],
                      ),
                space.kH,
                BoxInfo2(
                    title: context.tr('charging_type'),
                    value: info1.chargingType ?? '-'),
                4.kH,
                10.kH,
                info1.totalVoltage != '0'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleApp2(text: context.tr('specic_gravity')),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Column(children: [
                                  BoxInfo(
                                      title: context.tr('temperature'),
                                      value: data.temperature ?? '-'),
                                  BoxInfo(
                                      title: context.tr('sp_gr'),
                                      value: data.thp ?? '-'),
                                  BoxInfo(
                                      title: context.tr('voltage'),
                                      value: data.voltageCheck ?? '-'),
                                ]),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              4.wH,
                              Text(
                                '${context.tr('total_voltage')} ${info1.totalVoltage}V.',
                                style: TextStyleList.text2,
                              ),
                            ],
                          )
                        ],
                      )
                    : TitleApp2(
                        text: context.tr('specic_gravity'),
                        moreText: '-',
                      ),
                10.kH,
                filteredBatteryCondition.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleApp(text: context.tr('battery_condition')),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Column(children: [
                                  BoxInfo(
                                    title: context.tr('item'),
                                    value: data.nameEn ?? '-',
                                    more: data.checking,
                                  ),
                                  BoxInfo(
                                      title: context.tr('option'),
                                      value: data.status == ''
                                          ? '-'
                                          : data.status ?? '-'),
                                  BoxInfo(
                                      title: context.tr('description'),
                                      value: data.description == ''
                                          ? '-'
                                          : data.description ?? '-'),
                                ]),
                              );
                            },
                          ),
                        ],
                      )
                    : TitleApp2(
                        text: context.tr('battery_condition'),
                        moreText: '-',
                      ),
                space.kH,
                TitleWithButton(
                    titleText: context.tr('corrective_action'),
                    button: Text(
                      info1.correctiveAction == ''
                          ? '-'
                          : info1.correctiveAction ?? '-',
                      style: TextStyleList.text3,
                    )),
                space.kH,
                recommendedSpareparts.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleApp(text: context.tr('bm_sparepart')),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Column(children: [
                                  BoxInfo(
                                      title: 'C-Code/Page',
                                      value: data.cCode ?? '-'),
                                  BoxInfo(
                                      title: 'Part Number',
                                      value: data.partNumber ?? '-'),
                                  BoxInfo(
                                      title:
                                          context.tr('description_spare_part'),
                                      value: data.description ?? '-'),
                                  BoxInfo(
                                      title: context.tr('quantity'),
                                      value: data.quantity ?? '-'),
                                ]),
                              );
                            },
                          ),
                          space.kH,
                        ],
                      )
                    : Column(
                        children: [
                          TitleWithButton(
                              titleText: context.tr('bm_sparepart'),
                              button: Text(
                                '-',
                                style: TextStyleList.text3,
                              )),
                          space.kH,
                        ],
                      ),
                TitleApp2(
                  text: context.tr('repair_pm_battery'),
                  moreText: info1.repairPm == '' ? '-' : info1.repairPm ?? '-',
                ),
                space.kH,
                // if (changeSpareparts.isNotEmpty)
                //   changeSpareparts.first.quantity != '0'
                //       ? Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             const TitleApp(text: "Change Spare Part"),
                //             4.kH,
                //             ListView.builder(
                //               physics: const NeverScrollableScrollPhysics(),
                //               shrinkWrap: true,
                //               itemCount: changeSpareparts.length,
                //               itemBuilder: (context, index) {
                //                 final data = changeSpareparts[index];
                //                 return Container(
                //                   margin: const EdgeInsets.only(bottom: 8),
                //                   padding: const EdgeInsets.all(10),
                //                   decoration: BoxDecoration(
                //                       border:
                //                           Border.all(width: 1, color: black3),
                //                       color: white1,
                //                       borderRadius: const BorderRadius.all(
                //                           Radius.circular(6))),
                //                   child: Column(children: [
                //                     BoxInfo(
                //                         title: 'C-Code/Page',
                //                         value: data.cCode ?? '-'),
                //                     BoxInfo(
                //                         title: 'Part Number',
                //                         value: data.partNumber ?? '-'),
                //                     BoxInfo(
                //                         title: 'Description',
                //                         value: data.description ?? '-'),
                //                     BoxInfo(
                //                         title: 'Quantity',
                //                         value: data.quantity ?? '-'),
                //                   ]),
                //                 );
                //               },
                //             ),
                //           ],
                //         )
                //       : TitleWithButton(
                //           titleText: 'Change Spare Part',
                //           button: Text(
                //             '-',
                //             style: TextStyleList.text3,
                //           )),
                // space.kH,
                TitleApp2(
                    text: context.tr('inspector_1'),
                    moreText: info1.tech1 ?? ''),
                space.kH,
                TitleApp2(
                    text: context.tr('inspector_2'),
                    moreText: info1.tech2 ?? ''),
                Obx(() => (timeStart.value != '' && timeEnd.value != '')
                    ? Column(
                        children: [
                          space.kH,
                          TitleApp2(
                              text: context.tr('working_period'),
                              moreText:
                                  calculateTimeDifference(timeStart, timeEnd)),
                        ],
                      )
                    : Container()),
                4.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PdfFile(
                      name: context.tr('battery_maintenance_report'),
                      path: bugId,
                      option: pdfOption == 'btr' ? 'btr' : 'fieldreport_btr',
                    )
                  ],
                ),
                if (info1.signaturePadUrl != null)
                  Center(
                      child: Column(
                    children: [
                      space.kH,
                      6.kH,
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: UrlImageWidget(info1.signaturePadUrl ?? '')),
                      6.kH,
                    ],
                  )),
                if (info1.signature != null)
                  Column(
                    children: [
                      space.kH,
                      ShowTextFieldWidget(
                          text: context.tr('sign'),
                          hintText: info1.signature ?? ''),
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
