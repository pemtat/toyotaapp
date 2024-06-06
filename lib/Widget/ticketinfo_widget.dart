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

class TicketInfoStatus extends StatelessWidget {
  final int ticketId;
  final String dateTime;
  final String reporter;
  final String status;

  const TicketInfoStatus({
    super.key,
    required this.ticketId,
    required this.dateTime,
    required this.reporter,
    required this.status,
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
      ],
    );
  }
}

class JobInfo extends StatelessWidget {
  final int jobId;
  final String dateTime;
  final String reporter;
  final bool? more;

  const JobInfo(
      {super.key,
      required this.jobId,
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
                TitleApp(text: 'Job ID: $jobId'),
                5.wH,
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: jobId.toString()));
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
      ],
    );
  }
}
