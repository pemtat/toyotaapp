import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkcustomer.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: Decoration1(
        sideBorderColor: SidebarColor.getColor(event['status']),
      ),
      child: Row(
        children: [
          Expanded(
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
                  10.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      event['type'] == EventType.Job
                          ? Row(
                              children: [
                                Text(
                                  'Job ID : ${event['jobid'].toString().padLeft(7, '0')}',
                                  style: TextStyleList.text9,
                                ),
                                4.wH,
                                Text(
                                  '(Ticket #${event['bugid'].toString().padLeft(7, '0')})',
                                  style: TextStyleList.text1,
                                ),
                              ],
                            )
                          : Text(
                              'PM ID : ${event['jobid'].toString().padLeft(7, '0')}',
                              style: TextStyleList.text9,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: event['techStatus'] == '2'
                            ? const StatusButton(status: 'notconfirm')
                            : StatusButton(status: event['status']),
                      ),
                    ],
                  ),
                  if (event['type'] == EventType.PM)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 4.0,
                            children: [
                              Text(
                                event['customerName'],
                                style: TextStyleList.text15,
                              ),
                              Text(
                                '(${event['location']})',
                                style: TextStyleList.subtext4,
                              ),
                            ],
                          ),
                        ),
                        Obx(() => Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: InkWell(
                                onTap: () {
                                  if (expandedTicketId.value ==
                                      event['jobid']) {
                                    expandedIndex.value = !expandedIndex.value;
                                  } else {
                                    expandedIndex.value = true;
                                    expandedTicketId.value = event['jobid'];
                                  }
                                },
                                child: expandedIndex.value &&
                                        expandedTicketId.value == event['jobid']
                                    ? const ArrowUp(
                                        width: 30,
                                        height: 30,
                                      )
                                    : const ArrowDown(
                                        width: 30,
                                        height: 30,
                                      ),
                              ),
                            )),
                      ],
                    ),
                  if (event['type'] == EventType.Job)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        3.kH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(
                                    event['description'] ?? '',
                                    style: TextStyleList.detail2,
                                  ),
                                ],
                              ),
                            ),
                            Obx(() => Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
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
                                        ? const ArrowUp(
                                            width: 30,
                                            height: 30,
                                          )
                                        : const ArrowDown(
                                            width: 30,
                                            height: 30,
                                          ),
                                  ),
                                )),
                          ],
                        ),
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
                        const SizedBox(height: 2),
                        Text(
                          event['companyName'] ?? '',
                          style: TextStyleList.text10,
                        ),
                      ],
                    ),
                  if (event['type'] == EventType.Job)
                    Obx(() => (expandedIndex.value &&
                            expandedTicketId.value == event['jobid'])
                        ? Column(
                            children: [
                              3.kH,
                              Text(
                                '${context.tr('reported_by')} ${event['customerName']}',
                                style: TextStyleList.subtext1,
                              ),
                              const SizedBox(height: 5),
                            ],
                          )
                        : Container()),
                  if (event['bugid'] != '') 3.kH,
                  if (event['date'] != '')
                    Row(
                      children: [
                        const SizedBox(height: 2),
                        const Icon(Icons.calendar_month_outlined),
                        const SizedBox(width: 5),
                        event['type'] == EventType.Job
                            ? Text(
                                formatDateTime(event['date'], 'time'),
                                style: TextStyleList.subtext1,
                              )
                            : Text(
                                formatDateTimePlus(
                                  event['date'],
                                ),
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
                                child: Text(
                              event['location'],
                              style: TextStyleList.subtext1,
                              overflow: TextOverflow.visible,
                            )),
                          ],
                        )
                      : Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                event['address'] ?? '',
                                style: TextStyleList.subtext1,
                                overflow: TextOverflow.visible,
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
                        Text(extractDescription(event['description']),
                            style: TextStyleList.subtext1),
                      ],
                    ),
                  10.kH,
                  event['type'] == EventType.PM
                      ? Obx(
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
