import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class TicketInfo extends StatelessWidget {
  final String ticketId;
  final String dateTime;
  final String reporter;

  const TicketInfo({
    Key? key,
    required this.ticketId,
    required this.dateTime,
    required this.reporter,
  }) : super(key: key);

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
                TitleApp(text: 'Ticket ID: #$ticketId'),
                5.wH,
                Image.asset('assets/ticketblock.png'),
              ],
            ),
            SizedBox(height: 4),
            Text(
              '$dateTime\nReported by $reporter',
              style: TextStyleList.detail3,
            ),
          ],
        ),
        Image.asset("assets/arrowright.png"),
      ],
    );
  }
}
