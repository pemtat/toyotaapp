import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/ReturnSparePart/return_sparepart_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobSparepartReturn_widget%20copy/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/drawer_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class ReturnSparePartView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final ReturnSparePartController returnSparePartController =
      Get.put(ReturnSparePartController());

  ReturnSparePartView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text(context.tr('return_spare_part'),
                    style: TextStyleList.title1),
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
                  searchController: returnSparePartController.searchController,
                  searchQuery: returnSparePartController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: returnSparePartController.selectedDate,
                  clearFilters: returnSparePartController.clearFilters),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          returnSparePartController.isSelected.value = 1;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: returnSparePartController
                                            .isSelected.value ==
                                        1
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
                                  '${context.tr('on_process')} (${jobController.sparePartReturnPending.value})',
                                  style: returnSparePartController
                                              .isSelected.value ==
                                          1
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
                          returnSparePartController.isSelected.value = 2;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: returnSparePartController
                                            .isSelected.value ==
                                        2
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
                                  '${context.tr('approved')} (${jobController.sparePartReturnApproved.value})',
                                  style: returnSparePartController
                                              .isSelected.value ==
                                          2
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
                          returnSparePartController.isSelected.value = 3;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: returnSparePartController
                                            .isSelected.value ==
                                        3
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
                                  '${context.tr('rejected')} (${jobController.sparePartReturnReject.value})',
                                  style: returnSparePartController
                                              .isSelected.value ==
                                          3
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
                if (returnSparePartController.isSelected.value == 1) {
                  return buildJobList(context, '1');
                }
                if (returnSparePartController.isSelected.value == 2) {
                  return buildJobList(context, '2');
                }
                if (returnSparePartController.isSelected.value == 3) {
                  return buildJobList(context, '3');
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
                final filteredJobs =
                    jobController.subJobSparePartReturn.where((job) {
                  final searchQueryMatch = job.id!.contains(
                          returnSparePartController.searchQuery.value) ||
                      job.bugId!.contains(
                          returnSparePartController.searchQuery.value) ||
                      job.description!.contains(
                          returnSparePartController.searchQuery.value);
                  final statusMatch = returnSparePartController
                          .selectedStatus.isEmpty ||
                      returnSparePartController.selectedStatus.contains(
                          stringToStatusQuotation(job.estimateStatus ?? ''));
                  final jobDate = formatDateTimeString(job.dueDate ?? '');
                  final dateMatch =
                      returnSparePartController.selectedDate.value == null ||
                          (jobDate.year ==
                                  returnSparePartController
                                      .selectedDate.value!.year &&
                              jobDate.month ==
                                  returnSparePartController
                                      .selectedDate.value!.month &&
                              jobDate.day ==
                                  returnSparePartController
                                      .selectedDate.value!.day);
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
                        onTap: () {},
                        child: SubJobSparePartReturnWidget(
                          subJobSparePart: filteredJobs[index],
                          expandedTicketId:
                              returnSparePartController.expandedTicketId,
                          expandedIndex:
                              returnSparePartController.expandedIndex,
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
          selectedStatus: returnSparePartController.selectedStatus),
      buildCheckbox(
          status: 'approved',
          selectedStatus: returnSparePartController.selectedStatus),
      buildCheckbox(
          status: 'rejected',
          selectedStatus: returnSparePartController.selectedStatus),
    ];
  }
}
