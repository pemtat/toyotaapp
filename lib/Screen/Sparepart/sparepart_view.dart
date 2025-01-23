import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/Sparepart/sparepart_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/drawer_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class SparePartView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final SparePartController sparePartController =
      Get.put(SparePartController());

  SparePartView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        drawer: Drawer(
          width: 200,
          child: sideDrawer(),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text('Spare Part', style: TextStyleList.title1),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.kH,
              SearchFilter(
                  searchController: sparePartController.searchController,
                  searchQuery: sparePartController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: sparePartController.selectedDate,
                  clearFilters: sparePartController.clearFilters),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          sparePartController.isSelected.value = 1;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: sparePartController.isSelected.value == 1
                                    ? red4
                                    : white5,
                                border: const Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 162, 160, 160),
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Text(
                                  '${context.tr('on_process')} (${jobController.sparePartPending.value})',
                                  style:
                                      sparePartController.isSelected.value == 1
                                          ? TextStyleList.text7
                                          : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          sparePartController.isSelected.value = 2;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: sparePartController.isSelected.value == 2
                                    ? red4
                                    : white5,
                                border: const Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 162, 160, 160),
                                    ),
                                    left: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 218, 214, 214),
                                    ),
                                    right: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 218, 214, 214),
                                    )),
                              ),
                              child: Center(
                                child: Text(
                                  '${context.tr('approved')} (${jobController.sparePartApproved.value})',
                                  style:
                                      sparePartController.isSelected.value == 2
                                          ? TextStyleList.text7
                                          : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          sparePartController.isSelected.value = 3;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: sparePartController.isSelected.value == 3
                                    ? red4
                                    : white5,
                                border: const Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 162, 160, 160),
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Text(
                                  '${context.tr('rejected')} (${jobController.sparePartReject.value})',
                                  style:
                                      sparePartController.isSelected.value == 3
                                          ? TextStyleList.text7
                                          : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (sparePartController.isSelected.value == 1) {
                  return jobController.techLevel.value == '1'
                      ? buildJobList(context, '1')
                      : buildJobListTechManager(context, '0');
                }
                if (sparePartController.isSelected.value == 2) {
                  return jobController.techLevel.value == '1'
                      ? buildJobList(context, '2')
                      : buildJobListTechManager(context, '1');
                }
                if (sparePartController.isSelected.value == 3) {
                  return jobController.techLevel.value == '1'
                      ? buildJobList(context, '3')
                      : buildJobListTechManager(context, '2');
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildJobList(BuildContext context, String status) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(paddingApp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.kH,
            Expanded(
              child: Obx(() {
                final filteredJobs = jobController.subJobSparePart.where((job) {
                  final searchQueryMatch = job.id!
                          .contains(sparePartController.searchQuery.value) ||
                      job.bugId!
                          .contains(sparePartController.searchQuery.value) ||
                      job.description!
                          .contains(sparePartController.searchQuery.value);
                  final statusMatch =
                      sparePartController.selectedStatus.isEmpty ||
                          sparePartController.selectedStatus
                              .contains(stringToStatus(job.status ?? ''));
                  final jobDate = formatDateTimeString(job.dueDate ?? '');
                  final dateMatch = sparePartController.selectedDate.value ==
                          null ||
                      (jobDate.year ==
                              sparePartController.selectedDate.value!.year &&
                          jobDate.month ==
                              sparePartController.selectedDate.value!.month &&
                          jobDate.day ==
                              sparePartController.selectedDate.value!.day);
                  return searchQueryMatch &&
                      dateMatch &&
                      statusMatch &&
                      status.contains(job.estimateStatus ?? '0');
                }).toList();

                if (filteredJobs.isEmpty) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Center(
                          child: Text(
                        context.tr('no_jobs_avb'),
                        style: TextStyleList.subtitle2,
                      )),
                    ),
                  );
                }
                filteredJobs.sort(
                    (a, b) => b.createdDate!.compareTo(a.createdDate ?? ''));
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredJobs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          filteredJobs[index].projectId == '1'
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Obx(() => Material(
                                            color: Colors.transparent,
                                            child: PendingTaskView(
                                              ticketId:
                                                  filteredJobs[index].bugId ??
                                                      '',
                                              jobId:
                                                  filteredJobs[index].id ?? '',
                                              showOnly: 'yes',
                                            ),
                                          )))
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Obx(() => Material(
                                            color: Colors.transparent,
                                            child: PendingTaskViewPM(
                                              ticketId:
                                                  filteredJobs[index].bugId ??
                                                      '',
                                              showOnly: 'yes',
                                            ),
                                          )));
                        },
                        child: SubJobSparePartWidget(
                          subJobSparePart: filteredJobs[index],
                          expandedTicketId:
                              sparePartController.expandedTicketId,
                          expandedIndex: sparePartController.expandedIndex,
                        ));
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildJobListTechManager(BuildContext context, String status) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(paddingApp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.kH,
            Expanded(
              child: Obx(() {
                final filteredJobs = jobController.subJobSparePart.where((job) {
                  final searchQueryMatch = job.id!
                          .contains(sparePartController.searchQuery.value) ||
                      job.bugId!
                          .contains(sparePartController.searchQuery.value) ||
                      job.description!
                          .contains(sparePartController.searchQuery.value);
                  final statusMatch =
                      sparePartController.selectedStatus.isEmpty ||
                          sparePartController.selectedStatus
                              .contains(stringToStatus(job.status ?? ''));
                  final jobDate = formatDateTimeString(job.dueDate ?? '');
                  final dateMatch = sparePartController.selectedDate.value ==
                          null ||
                      (jobDate.year ==
                              sparePartController.selectedDate.value!.year &&
                          jobDate.month ==
                              sparePartController.selectedDate.value!.month &&
                          jobDate.day ==
                              sparePartController.selectedDate.value!.day);
                  return searchQueryMatch &&
                      dateMatch &&
                      statusMatch &&
                      status.contains(job.techManagerStatus ?? '0');
                }).toList();

                if (filteredJobs.isEmpty) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Center(
                          child: Text(
                        context.tr('no_jobs_avb'),
                        style: TextStyleList.subtitle2,
                      )),
                    ),
                  );
                }
                filteredJobs.sort(
                    (a, b) => b.createdDate!.compareTo(a.createdDate ?? ''));
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredJobs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          filteredJobs[index].projectId == '1'
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Obx(() => Material(
                                            color: Colors.transparent,
                                            child: PendingTaskView(
                                              ticketId:
                                                  filteredJobs[index].bugId ??
                                                      '',
                                              jobId:
                                                  filteredJobs[index].id ?? '',
                                              showOnly: 'yes',
                                            ),
                                          )))
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Obx(() => Material(
                                            color: Colors.transparent,
                                            child: PendingTaskViewPM(
                                              ticketId:
                                                  filteredJobs[index].bugId ??
                                                      '',
                                              showOnly: 'yes',
                                            ),
                                          )));
                        },
                        child: SubJobSparePartWidget(
                          subJobSparePart: filteredJobs[index],
                          expandedTicketId:
                              sparePartController.expandedTicketId,
                          expandedIndex: sparePartController.expandedIndex,
                        ));
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'pending',
          selectedStatus: sparePartController.selectedStatus),
      buildCheckbox(
          status: 'approved',
          selectedStatus: sparePartController.selectedStatus),
      buildCheckbox(
          status: 'rejected',
          selectedStatus: sparePartController.selectedStatus),
    ];
  }
}
