import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';

class CalendarItem extends StatelessWidget {
  final Map<String, dynamic> event;
  final Rx<bool> expandedIndex;
  final Rx<String> expandedTicketId;

  const CalendarItem({
    Key? key,
    required this.event,
    required this.expandedIndex,
    required this.expandedTicketId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        'Ticket ID : ${event['ticketid'].toString().padLeft(7, '0')}',
                        style: TextStyleList.text16,
                      ),
                      const SizedBox(width: 10),
                      const Spacer(),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: InkWell(
                            onTap: () {
                              if (expandedTicketId.value == event['ticketid']) {
                                expandedIndex.value = !expandedIndex.value;
                              } else {
                                expandedIndex.value = true;
                                expandedTicketId.value = event['ticketid'];
                              }
                            },
                            child: expandedIndex.value &&
                                    expandedTicketId.value == event['ticketid']
                                ? const ArrowUp()
                                : const ArrowDown(),
                          ),
                        ),
                      ),
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
                      Text(
                        event['location'],
                        style: TextStyleList.subtext1,
                      ),
                      const SizedBox(width: 5),
                      GoogleMapButton(
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => expandedIndex.value &&
                            expandedTicketId.value == event['ticketid']
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 0.5,
                                  color: const Color(0xFFEAEAEA),
                                ),
                                const SizedBox(height: 8),
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
                                        value: event['nameModel'],
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
                                          status: event['warrantyStatus'],
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
  }
}
