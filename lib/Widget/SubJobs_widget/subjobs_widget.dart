import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final String? status;

  const SubJobsTicket({
    super.key,
    required this.job,
    required this.expandedIndex,
    required this.jobController,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(width: 10),
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
                job.summary,
                style: TextStyleList.text15,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 5),
                  Text(
                    '13 June 2024',
                    style: TextStyleList.subtext1,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 5),
                  Text(
                    'Bangkok',
                    style: TextStyleList.subtext1,
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
  }
}