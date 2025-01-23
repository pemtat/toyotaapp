import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/Report/report_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/chart_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/report_title_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class ReportView extends StatelessWidget {
  ReportView({super.key});
  final HomeController jobController = Get.put(HomeController());
  final ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    int space = 12;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              centerTitle: false,
              backgroundColor: white3,
              actions: [
                if (jobController.techLevel.value == '2')
                  Obx(() {
                    return DropdownButton<int>(
                      style: TextStyleList.subtitle2,
                      value: reportController.selectedTech.value,
                      alignment: Alignment.centerRight,
                      hint: Text(context.tr('select_tech'),
                          style: TextStyle(color: Colors.black)),
                      items: reportController.usersAllTech.map((user) {
                        return DropdownMenuItem<int>(
                          value: int.parse(user.id ?? '0'),
                          child: Row(
                            children: [
                              Text(user.username ?? '',
                                  style: TextStyleList.detail2
                                      .copyWith(fontWeight: FontWeight.bold)),
                              6.wH,
                              Text(user.realname ?? '',
                                  style: TextStyleList.detail2
                                      .copyWith(fontWeight: FontWeight.w200)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        await reportController.updateTech(value);
                      },
                      dropdownColor: Colors.white,
                      underline: const SizedBox(),
                    );
                  }),
                Obx(() {
                  return DropdownButton<int>(
                    alignment: Alignment.centerRight,
                    style: TextStyleList.subtitle2,
                    value: reportController.selectedYear.value,
                    hint: const Text('เลือกปี',
                        style: TextStyle(color: Colors.black)),
                    items: reportController.years.map((year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text('$year',
                            style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      await reportController.updateYear(value);
                    },
                    dropdownColor: Colors.white,
                    underline: const SizedBox(),
                  );
                }),
                InkWell(
                  onTap: () async {
                    await reportController.resetFilter();
                  },
                  child: Text(
                    context.tr('reset_1'),
                    style: TextStyleList.text1,
                  ),
                ),
                8.wH,
              ],
            ),
            const AppDivider(),
            Container(
              height: 0.5,
              color: white1,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Obx(() {
          if (reportController.techReport.isEmpty) {
            return Container();
          } else {
            var reportData = reportController.techReport.first;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 6,
                        child: ReportTitle(
                            title: 'TOTAL INSPECTION JOBS',
                            total: int.parse(reportData.inspectionTotal ?? '0'),
                            intime:
                                int.parse(reportData.inspectionIntime ?? '0'),
                            late: int.parse(reportData.inspectionLate ?? '0'),
                            inProgress: int.parse(
                                reportData.inspectionInprogress ?? '0'),
                            pending:
                                int.parse(reportData.inspectionPending ?? '0'),
                            closed: 0,
                            waitingPart: 0,
                            waitingFsr: 0,
                            type: 'inspection')),
                    Expanded(
                        flex: 6,
                        child: ReportTitle(
                            title: 'TOTAL PO REPAIR JOBS',
                            total: int.parse(reportData.poTotal ?? '0'),
                            intime: int.parse(reportData.poIntime ?? '0'),
                            late: int.parse(reportData.poLate ?? '0'),
                            inProgress:
                                int.parse(reportData.poInprogress ?? '0'),
                            pending: int.parse(reportData.poPending ?? '0'),
                            closed: 0,
                            waitingPart:
                                int.parse(reportData.poWaitingPart ?? '0'),
                            waitingFsr: 0,
                            type: 'repairjobs'))
                  ],
                ),
                space.kH,
                AppDivider2(),
                space.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 6,
                        child: ReportMiddle(
                            title: 'NO. OF JOB FOC REPAIR',
                            total: int.parse(reportData.focTotal ?? '0'),
                            intime: 0,
                            late: 0,
                            finished: int.parse(reportData.focFinished ?? '0'),
                            pending: int.parse(reportData.focPending ?? '0'),
                            type: 'foc')),
                    Expanded(
                        flex: 6,
                        child: ReportMiddle(
                            title: 'NO. OF PM JOB STATUS',
                            total: int.parse(reportData.pmTotal ?? '0'),
                            intime: int.parse(reportData.pmIntime ?? '0'),
                            late: int.parse(reportData.pmLate ?? '0'),
                            finished: 0,
                            pending: int.parse(reportData.pmPending ?? '0'),
                            type: 'pm'))
                  ],
                ),
                space.kH,
                AppDivider2(),
                space.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: DoughnutChartWithConnectorLines(
                      chartData: reportController.chartData,
                      title: 'WORKLOAD RATIO (%)',
                    )),
                  ],
                ),
                space.kH,
                AppDivider2(),
                space.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: HorizontalBarChart(
                        chartData: reportController.chartData2,
                      ),
                    ))
                  ],
                ),
                // space.kH,
                // AppDivider2(),
                // space.kH,
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [Expanded(child: TableShowData())],
                // ),
                space.kH,
                AppDivider2(),
                space.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CombinedChart(
                        chartData: reportController.chartData3,
                      ),
                    ))
                  ],
                ),
                space.kH,
                AppDivider2(),
                space.kH,
              ],
            );
          }
        }),
      ),
    );
  }
}
