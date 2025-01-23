import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Calendar_widget/calendar_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class FullCalendarWidget extends StatelessWidget {
  final String displayDate;
  final List<Map<String, dynamic>> eventsOnTheDate;
  final RxBool expandedIndex;
  final Rx<String> expandedTicketId;
  const FullCalendarWidget(
      {super.key,
      required this.eventsOnTheDate,
      required this.expandedIndex,
      required this.displayDate,
      required this.expandedTicketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: white3,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(displayDate, style: TextStyleList.title1),
                ],
              ),
              leading: const BackIcon(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eventsOnTheDate.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        context.tr('no_jobs'),
                        style: TextStyleList.subtitle2,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: eventsOnTheDate.length,
                      itemBuilder: (context, index) {
                        final event = eventsOnTheDate[index];
                        return InkWell(
                          onTap: () {
                            if (event['type'] == EventType.Job) {
                              if (event['status'] == 'pending') {
                                Get.to(() => PendingTaskView(
                                    ticketId: event['bugid'] ?? '',
                                    jobId: event['jobid']));
                              } else if (event['status'] == 'confirmed') {
                                Get.to(() => JobDetailView(
                                    ticketId: event['bugid'] ?? '',
                                    jobId: event['jobid']));
                              } else {
                                Get.to(() => TicketDetailView(
                                    ticketId: event['bugid'] ?? '',
                                    jobId: event['jobid']));
                              }
                            } else {
                              if (event['status'] == 'pending') {
                                Get.to(() => PendingTaskViewPM(
                                    ticketId: event['jobid']));
                              } else if (event['status'] == 'confirmed') {
                                Get.to(() =>
                                    JobDetailViewPM(ticketId: event['jobid']));
                              } else {
                                Get.to(() => TicketPMDetailView(
                                    ticketId: event['jobid']));
                              }
                            }
                          },
                          child: CalendarItem(
                            event: event,
                            expandedIndex: expandedIndex,
                            expandedTicketId: expandedTicketId,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
