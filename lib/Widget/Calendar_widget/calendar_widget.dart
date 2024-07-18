import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

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
                  5.kH,
                  if (event['type'] == EventType.Job) 5.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Obx(() => Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () {
                                if (expandedTicketId.value == event['jobid']) {
                                  expandedIndex.value = !expandedIndex.value;
                                } else {
                                  expandedIndex.value = true;
                                  expandedTicketId.value = event['jobid'];
                                }
                              },
                              child: expandedIndex.value &&
                                      expandedTicketId.value == event['jobid']
                                  ? const ArrowUp()
                                  : const ArrowDown(),
                            ),
                          )),
                    ],
                  ),
                  if (event['type'] == EventType.PM)
                    Column(
                      children: [
                        Text(
                          event['customerName'],
                          style: TextStyleList.text15,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  if (event['type'] == EventType.Job)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        3.kH,
                        Text(
                          event['description'] ?? '',
                          style: TextStyleList.detail2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['task'] ?? '',
                          style: TextStyleList.text2,
                        ),
                        const SizedBox(height: 3),
                      ],
                    ),
                  if (event['type'] == EventType.Job)
                    Column(
                      children: [
                        3.kH,
                        Text(
                          'Reported by ${event['customerName']}',
                          style: TextStyleList.subtext1,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  if (event['bugid'] != '') 3.kH,
                  if (event['date'] != '')
                    Row(
                      children: [
                        const SizedBox(height: 2),
                        const Icon(Icons.calendar_month_outlined),
                        const SizedBox(width: 5),
                        Text(
                          '${formatDateTime(event['date'])}',
                          style: TextStyleList.subtext1,
                        ),
                        const SizedBox(height: 2),
                      ],
                    ),
                  const SizedBox(height: 4),
                  event['type'] == EventType.Job
                      ? Row(
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
                        )
                      : Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(width: 5),
                            Expanded(
                              child: FutureBuilder<CustomerById>(
                                future: fetchCustomerInfo(event['reporterId']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text('-');
                                  } else if (!snapshot.hasData) {
                                    return const Text('-');
                                  }

                                  CustomerById customer = snapshot.data!;
                                  return Text(
                                    customer.customerAddress ?? '-',
                                    style: TextStyleList.subtext1,
                                    overflow: TextOverflow.visible,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 3),
                  if (event['type'] == EventType.PM)
                    Row(
                      children: [
                        const Icon(Icons.person_search_sharp),
                        5.wH,
                        Text(
                          event['description'].substring(
                              0, event['description'].indexOf('.CD')),
                          style: TextStyleList.subtext1,
                        ),
                      ],
                    ),
                  10.kH,
                  event['type'] == EventType.PM
                      ? FutureBuilder<RxList<WarrantyInfo>>(
                          future: checkWarrantyReturn(
                              event['serialNo'], warrantyInfoList),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else if (snapshot.hasError) {
                              return const Text('-');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Container();
                            }
                            var warrantyInfo = <WarrantyInfo>[].obs;
                            warrantyInfo = snapshot.data!;
                            return Obx(
                              () => expandedIndex.value &&
                                      expandedTicketId.value == event['jobid']
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, right: 8, bottom: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 0.5,
                                            color: const Color(0xFFEAEAEA),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: Decoration2(),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Model',
                                                      style:
                                                          TextStyleList.text3,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        warrantyInfo
                                                            .first.model,
                                                        style:
                                                            TextStyleList.text2,
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 3),
                                                BoxInfo(
                                                  title: "Serial Number",
                                                  value: event['serialNo'],
                                                ),
                                                const SizedBox(height: 3),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            );
                          },
                        )
                      : Obx(
                          () => expandedIndex.value &&
                                  expandedTicketId.value == event['jobid']
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, right: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 0.5,
                                        color: const Color(0xFFEAEAEA),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: Decoration2(),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Model',
                                                  style: TextStyleList.text3,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    event['model'],
                                                    style: TextStyleList.text2,
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            BoxInfo(
                                              title: "Serial Number",
                                              value: event['serialNo'],
                                            ),
                                            const SizedBox(height: 3),
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
  }
}
