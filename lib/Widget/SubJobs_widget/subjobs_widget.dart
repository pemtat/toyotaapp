import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';

class SubJobsTicket extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final job;
  final RxInt expandedIndex;
  final SubTicketController jobController;
  final HomeController jobsHome;
  final String bugId;
  final String reporter;
  final int? index;

  final String? status;

  const SubJobsTicket(
      {super.key,
      required this.job,
      required this.expandedIndex,
      required this.jobController,
      required this.status,
      required this.bugId,
      required this.reporter,
      required this.jobsHome,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: jobsHome.fetchTicketById(bugId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return index == 0
              ? const Center(child: CircularProgressIndicator())
              : Container();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container();
        }

        Map<String, String> userData = snapshot.data!;
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(0),
                ),
                color: white5,
              ),
              child: Row(
                children: [
                  Text(
                    'JobID: #${job.id.toString().padLeft(4, '0')}',
                    style: TextStyleList.subtitle1,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ('(Ticket #$bugId)'),
                    style: TextStyleList.text11,
                  ),
                  const Spacer(),
                  StatusButton(status: status ?? '')
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: Decoration3(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.description ?? '',
                    style: TextStyleList.text15,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Reported by ${userData['name']}',
                    style: TextStyleList.subtext4,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      const SizedBox(width: 5),
                      Text(
                        '${job.dueDate ?? 'ยังไม่มีกำหนดการ'}',
                        style: TextStyleList.subtext1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          userData['location'] ?? '',
                          style: TextStyleList.subtext1,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: [
                          GoogleMapButton(
                            onTap: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
