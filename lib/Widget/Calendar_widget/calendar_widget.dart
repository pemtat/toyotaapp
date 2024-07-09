import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';

class CalendarItem extends StatelessWidget {
  final Map<String, dynamic> event;
  final Rx<bool> expandedIndex;
  final Rx<String> expandedTicketId;

  const CalendarItem({
    super.key,
    required this.event,
    required this.expandedIndex,
    required this.expandedTicketId,
  });

  @override
  Widget build(BuildContext context) {
    var warrantyInfoList = <WarrantyInfo>[].obs;
    return FutureBuilder<RxList<WarrantyInfo>>(
        future: checkWarrantyReturn(event['serialNo'], warrantyInfoList),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return const Text('-');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container();
          }
          var warrantyInfo = <WarrantyInfo>[].obs;
          warrantyInfo = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: Decoration1(
              sideBorderColor: SidebarColor.getColor(event['status']),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        event['time'],
                        style: TextStyleList.text2,
                      ),
                      const SizedBox(height: 4),
                      StatusButton(status: event['status']),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 1, color: white1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            event['type'] == EventType.Job
                                ? Text(
                                    'Job ID : ${event['jobid'].toString().padLeft(4, '0')}',
                                    style: TextStyleList.text16,
                                  )
                                : Text(
                                    'PM ID : ${event['jobid'].toString().padLeft(4, '0')}',
                                    style: TextStyleList.text16,
                                  ),
                            const SizedBox(width: 10),
                            const Spacer(),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: InkWell(
                                  onTap: () {
                                    if (expandedTicketId.value ==
                                        event['jobid']) {
                                      expandedIndex.value =
                                          !expandedIndex.value;
                                    } else {
                                      expandedIndex.value = true;
                                      expandedTicketId.value = event['jobid'];
                                    }
                                  },
                                  child: expandedIndex.value &&
                                          expandedTicketId.value ==
                                              event['jobid']
                                      ? const ArrowUp()
                                      : const ArrowDown(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (event['customerName'] != '')
                          Column(
                            children: [
                              Text(
                                event['customerName'],
                                style: TextStyleList.text15,
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        Text(
                          event['task'],
                          style: TextStyleList.text15,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(width: 5),
                            Expanded(
                              child: FutureBuilder<Map<String, String>>(
                                future: fetchLocationById(event['reporterId']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                                CircularProgressIndicator()));
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => expandedIndex.value &&
                                  expandedTicketId.value == event['jobid']
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 0.5,
                                        color: const Color(0xFFEAEAEA),
                                      ),
                                      const SizedBox(height: 8),
                                      if (event['description'] != '')
                                        Text(
                                          event['description'],
                                          style: TextStyleList.text15,
                                        ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: Decoration2(),
                                        child: Column(
                                          children: [
                                            BoxInfo(
                                              title: "Name/Model",
                                              value: warrantyInfo.first.model,
                                            ),
                                            const SizedBox(height: 3),
                                            BoxInfo(
                                              title: "Serial Number",
                                              value: event['serialNo'],
                                            ),
                                            const SizedBox(height: 3),
                                            BoxInfo(
                                              title: "Warranty Status",
                                              value: '',
                                              trailing: CheckStatus(
                                                status: warrantyInfo
                                                    .first.warrantyStatus,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
