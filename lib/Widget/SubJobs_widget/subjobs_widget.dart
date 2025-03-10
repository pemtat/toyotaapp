import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/openmap.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class SubJobsTicket extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final job;
  final RxInt expandedIndex;
  final SubTicketController jobController;
  final HomeController jobsHome;
  final String bugId;
  final String reporter;
  final int? index;
  final String? confirm;

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
      this.confirm,
      required this.index});

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
            color: white1,
          ),
          child: Row(
            children: [
              Text(
                'JobID: #${job.id.toString().padLeft(6, '0')}',
                style: TextStyleList.subtitle1,
              ),
              const SizedBox(width: 5),
              Text(
                ('(Ticket #${bugId.toString().padLeft(7, '0')})'),
                style: TextStyleList.text11,
              ),
              const Spacer(),
              confirm == null
                  ? StatusButton(status: status ?? '')
                  : const StatusButton(status: 'notconfirm')
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
                job.summaryBug ?? '',
                style: TextStyleList.detail2,
              ),
              const SizedBox(height: 2),
              Text(
                job.description ?? '',
                style: TextStyleList.text2,
              ),
              const SizedBox(height: 2),
              Text(
                job.companyName ?? '',
                style: TextStyleList.text10,
              ),
              const SizedBox(height: 2),
              Text(
                '${context.tr('reported_by')} ${job.realName}',
                style: TextStyleList.subtext4,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 5),
                  Text(
                    formatDateTime(job.dueDate, 'time'),
                    style: TextStyleList.subtext1,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  5.wH,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: job.address ?? '',
                            style: TextStyleList.subtext1,
                          ),
                          WidgetSpan(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                2.wH,
                                GoogleMapButton(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return const Center(
                                          child: DataCircleLoading(),
                                        );
                                      },
                                    );

                                    try {
                                      await openGoogleMaps(job.address ?? '');
                                    } catch (e) {
                                      print(e);
                                    } finally {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              2.kH,
              Row(
                children: [
                  2.wH,
                  const Icon(Icons.forklift),
                  5.wH,
                  Text(
                    '${job.model ?? ''} / ${job.serialNo}',
                    style: TextStyleList.subtext1,
                  ),
                ],
              ),
              const SizedBox(height: 8)
            ],
          ),
        ),
      ],
    );
  }
}
