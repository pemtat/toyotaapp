import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Models/getsubjobassigned_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Screen/Overdue/overduejob_controller.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverduejobView extends StatelessWidget {
  final OverduejobController overduejobController =
      Get.put(OverduejobController());
  final SubTicketController subticketController =
      Get.put(SubTicketController());

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(preferredSize),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text('Overdue Jobs', style: TextStyleList.title1),
              ),
              Container(
                height: 0.5,
                color: white1,
              ),
              const AppDivider()
            ],
          ),
        ),
        body: RefreshIndicator(
          color: Colors.red,
          backgroundColor: Colors.white,
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(paddingApp),
                  child: Obx(() {
                    final List<dynamic> combinedData = [];

                    final pmJobData = jobController.pmItems
                        .where((job) =>
                            (stringToStatus(job.status ?? '') != 'closed' &&
                                stringToStatus(job.status ?? '') !=
                                    'completed') &&
                            DateTime.parse(job.dueDate ?? '')
                                .isBefore(DateTime.now()) &&
                            job.techStatus != '2')
                        .toList();

                    combinedData.addAll(pmJobData);

                    final jobData = jobController.subJobAssigned
                        .where((job) =>
                            job.status != '103' &&
                            DateTime.parse(job.dueDate ?? '')
                                .isBefore(DateTime.now()) &&
                            job.techStatus != '2')
                        .toList();

                    combinedData.addAll(jobData);
                    combinedData.sort((a, b) {
                      final DateTime aDate = (a is PmModel)
                          ? DateTime.parse(
                              a.dueDate ?? getFormattedDate(DateTime.now()))
                          : DateTime.parse((a as SubJobAssgined).dueDate ??
                              getFormattedDate(DateTime.now()));
                      final DateTime bDate = (b is PmModel)
                          ? DateTime.parse(
                              b.dueDate ?? getFormattedDate(DateTime.now()))
                          : DateTime.parse((b as SubJobAssgined).dueDate ??
                              getFormattedDate(DateTime.now()));
                      return bDate.compareTo(aDate); // Sort descending
                    });

                    if (combinedData.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Center(
                              child: Text(
                            'No overdue jobs.',
                            style: TextStyleList.subtitle2,
                          )),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: combinedData.length,
                      itemBuilder: (context, index) {
                        final item = combinedData[index];
                        if (item is PmModel) {
                          return PmItemWidget(
                            job: item,
                            index: index,
                            expandedIndex: jobController.expandedIndex2,
                            jobController: jobController,
                            sidebar: SidebarColor.getColor(
                                stringToStatus(item.status ?? '')),
                          );
                        } else {
                          // Display Job Item
                          final job = item as SubJobAssgined;
                          return SubJobsTicket(
                              index: index,
                              jobsHome: jobController,
                              bugId: job.bugId ?? '',
                              reporter: job.reporterId ?? '',
                              job: job,
                              expandedIndex: jobController.expandedIndex,
                              jobController: subticketController,
                              status: stringToStatus(job.status ?? ''));
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'pending',
          selectedStatus: overduejobController.selectedStatus),
      buildCheckbox(
          status: 'confirmed',
          selectedStatus: overduejobController.selectedStatus),
      buildCheckbox(
          status: 'completed',
          selectedStatus: overduejobController.selectedStatus),
    ];
  }
}
