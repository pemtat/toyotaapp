import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class PmItemWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final job;
  final RxInt expandedIndex;
  final HomeController jobController;
  final Color sidebar;

  const PmItemWidget({
    super.key,
    required this.job,
    required this.expandedIndex,
    required this.jobController,
    required this.sidebar,
  });

  @override
  Widget build(BuildContext context) {
    var warrantyInfoList = <WarrantyInfo>[].obs;
    return FutureBuilder<RxList<WarrantyInfo>>(
        future: checkWarrantyReturn(job.serialNo, warrantyInfoList),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container();
          }
          var warrantyInfo = <WarrantyInfo>[].obs;
          warrantyInfo = snapshot.data!;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: Decoration1(sideBorderColor: sidebar),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'JobID : ${job.id.toString().padLeft(4, '0')}',
                      style: TextStyleList.text16,
                    ),
                    const SizedBox(width: 10),
                    StatusButton(status: stringToStatus(job.status)),
                    const Spacer(),
                    Obx(
                      () => IconButton(
                        icon: expandedIndex.value ==
                                jobController.pmItems.indexOf(job)
                            ? const ArrowUp()
                            : const ArrowDown(),
                        onPressed: () {
                          if (expandedIndex.value ==
                              jobController.pmItems.indexOf(job)) {
                            expandedIndex.value = (-2);
                          } else {
                            expandedIndex.value =
                                jobController.pmItems.indexOf(job);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Text(
                  job.customerName,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    const SizedBox(width: 5),
                    Text(
                      job.dueDate,
                      style: TextStyleList.subtext1,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 5),
                    FutureBuilder<Map<String, String>>(
                      future: fetchLocationById(
                        job.reporterId,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator()),
                          ));
                        } else if (snapshot.hasError) {
                          return const Text('-');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('-');
                        }

                        Map<String, String> userData = snapshot.data!;
                        return Text(
                          userData['location'] ?? '-',
                          style: TextStyleList.subtext1,
                          overflow: TextOverflow.visible,
                        );
                      },
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person_search_sharp),
                    5.wH,
                    Text(
                      job.description
                          .substring(0, job.description.indexOf('บริษัท')),
                      style: TextStyleList.subtext1,
                    ),
                  ],
                ),
                Obx(() =>
                    expandedIndex.value == jobController.pmItems.indexOf(job)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 0.5,
                                  color: const Color(0xFFEAEAEA),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: Decoration2(),
                                    child: Column(
                                      children: [
                                        BoxInfo(
                                            title: "Name/Model",
                                            value: warrantyInfo.first.model),
                                        const SizedBox(height: 3),
                                        BoxInfo(
                                          title: "Serial Number",
                                          value: job.serialNo,
                                        ),
                                        const SizedBox(height: 3),
                                      ],
                                    )),
                              ],
                            ),
                          )
                        : const SizedBox())
              ],
            ),
          );
        });
  }
}
