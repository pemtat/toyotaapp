import 'package:flutter/material.dart';
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
  final String summary;
  final bool? more;

  const PMJobInfo(
      {super.key,
      required this.ticketId,
      required this.dateTime,
      required this.reporter,
      required this.description,
      required this.summary,
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
                    text: 'JobID: #${ticketId.toString().padLeft(4, '0')}'),
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
            const SizedBox(height: 4),
            Text(
              '$summary',
              style: TextStyleList.subtext3,
            ),
            const SizedBox(height: 4),
            Text(
              '$description',
              style: TextStyleList.subtext3,
            ),
            const SizedBox(height: 4),
          ],
        ),
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
                  '$description',
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
