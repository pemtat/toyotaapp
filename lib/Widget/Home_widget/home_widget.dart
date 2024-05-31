import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';

class JobItemWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final job;
  final RxInt expandedIndex;
  final HomeController jobController;
  final Color sidebar;

  const JobItemWidget({
    super.key,
    required this.job,
    required this.expandedIndex,
    required this.jobController,
    required this.sidebar,
  });

  @override
  Widget build(BuildContext context) {
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
                'JobID : ${job.jobid}',
                style: TextStyleList.text16,
              ),
              const SizedBox(width: 10),
              StatusButton(status: job.status),
              const Spacer(),
              Obx(
                () => IconButton(
                  icon:
                      expandedIndex.value == jobController.jobList.indexOf(job)
                          ? const ArrowUp()
                          : const ArrowDown(),
                  onPressed: () {
                    print(expandedIndex.value);
                    if (expandedIndex.value ==
                        jobController.jobList.indexOf(job)) {
                      expandedIndex.value = (-2);
                    } else {
                      expandedIndex.value = jobController.jobList.indexOf(job);
                    }
                  },
                ),
              ),
            ],
          ),
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
                job.getFormattedDate(),
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
                job.location,
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
          Obx(() => expandedIndex.value == jobController.jobList.indexOf(job)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 0.5,
                        color: const Color(0xFFEAEAEA),
                      ),
                      const SizedBox(height: 8),
                      Text('Ticket ID #${job.ticketid}',
                          style: TextStyleList.text16),
                      const SizedBox(height: 4),
                      Text(
                        job.description,
                        style: TextStyleList.text15,
                      ),
                      const SizedBox(height: 4),
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: Decoration2(),
                          child: const Column(
                            children: [
                              BoxInfo(
                                title: "Name/Model",
                                value: "UBRE200H2-TH-7500",
                              ),
                              SizedBox(height: 3),
                              BoxInfo(
                                title: "Serial Number",
                                value: "6963131",
                              ),
                              SizedBox(height: 3),
                              BoxInfo(
                                title: "Warranty Status",
                                value: '',
                                trailing: CheckStatus(
                                  status: 1,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                )
              : const SizedBox())
        ],
      ),
    );
  }
}
