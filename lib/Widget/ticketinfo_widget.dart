import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TicketInfo extends StatelessWidget {
  final int ticketId;
  final String dateTime;
  final String reporter;
  final bool? more;

  const TicketInfo(
      {super.key,
      required this.ticketId,
      required this.dateTime,
      required this.reporter,
      this.more});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TitleApp(
                    text: 'Ticket ID: #${ticketId.toString().padLeft(7, '0')}'),
                5.wH,
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: ticketId.toString()));
                    Fluttertoast.showToast(
                        msg: "คัดลอกข้อความ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 12.0);
                  },
                  child: Image.asset('assets/ticketblock.png'),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '$dateTime\nReported by $reporter',
              style: TextStyleList.subtext1,
            ),
          ],
        ),
        if (more == false) const ArrowRight() else const ArrowDown(),
      ],
    );
  }
}

class PMJobInfo extends StatelessWidget {
  final int ticketId;
  final String dateTime;
  final String reporter;
  final String description;
  final String contact;
  final String summary;
  final String detail;
  final String? status;
  final String? location;
  final bool? more;

  const PMJobInfo(
      {super.key,
      required this.ticketId,
      required this.dateTime,
      required this.reporter,
      required this.contact,
      required this.detail,
      required this.description,
      required this.summary,
      required this.status,
      required this.location,
      this.more});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TitleApp(
                    text: 'JobID: #${ticketId.toString().padLeft(4, '0')}',
                  ),
                  5.wH,
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: ticketId.toString()));
                      Fluttertoast.showToast(
                          msg: "คัดลอกข้อความ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 12.0);
                    },
                    child: Image.asset('assets/ticketblock.png'),
                  ),
                  const Spacer(),
                  StatusButton(status: status ?? ''),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                dateTime,
                style: TextStyleList.subtext1,
              ),
              const SizedBox(height: 4),
              Text(
                summary,
                style: TextStyleList.subtext3,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyleList.subtext3,
              ),
              const SizedBox(height: 4),
              // Text(
              //   detail.substring(0, detail.indexOf('บริษัท')),
              //   style: TextStyleList.text2,
              //   overflow: TextOverflow.visible,
              // ),
              // const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 5),
                  Expanded(
                    child: FutureBuilder<CustomerById>(
                      future: fetchCustomerInfo(location ?? ''),
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
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.quick_contacts_dialer),
                  5.wH,
                  Text(
                    contact,
                    style: TextStyleList.subtext3,
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        if (more != null)
          if (more == false) const ArrowRight() else const ArrowDown(),
      ],
    );
  }
}

class TicketInfoStatus extends StatelessWidget {
  final int ticketId;
  final String dateTime;
  final String reporter;
  final String status;
  final bool? more;
  const TicketInfoStatus({
    super.key,
    required this.ticketId,
    required this.dateTime,
    required this.reporter,
    required this.status,
    this.more,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TitleApp(
                    text: 'Ticket ID: #${ticketId.toString().padLeft(7, '0')}'),
                5.wH,
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: ticketId.toString()));
                    showMessage('คัดลอกข้อความ');
                  },
                  child: Image.asset('assets/ticketblock.png'),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '$dateTime\nReported by $reporter',
              style: TextStyleList.subtext1,
            ),
          ],
        ),
        Positioned(
          right: 0,
          child: StatusButton(
            status: status,
          ),
        ),
        if (more != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: more == false ? const ArrowRight() : const ArrowDown(),
          ),
      ],
    );
  }
}

class JobInfo extends StatelessWidget {
  final int jobId;
  final String? jobIdString;
  final String dateTime;
  final String reporter;
  final String summary;
  final String description;
  final bool? more;
  final String? status;

  const JobInfo(
      {super.key,
      required this.jobId,
      required this.dateTime,
      required this.reporter,
      required this.summary,
      required this.description,
      this.more,
      this.jobIdString,
      this.status});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    jobIdString != null
                        ? TitleApp(text: 'Job ID: $jobIdString')
                        : TitleApp(text: 'Job ID: $jobId'),
                    5.wH,
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: jobId.toString()));
                        Fluttertoast.showToast(
                            msg: "คัดลอกข้อความ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 12.0);
                      },
                      child: Image.asset('assets/ticketblock.png'),
                    )
                  ],
                ),
                Text(
                  description,
                  style: TextStyleList.text10,
                ),
                4.kH,
                Text(
                  '$dateTime\nReported by $reporter',
                  style: TextStyleList.subtext1,
                ),
              ],
            ),
          ],
        ),
        if (status != null)
          Positioned(
            right: 0,
            child: StatusButton(
              status: status ?? '',
            ),
          ),
      ],
    );
  }
}
