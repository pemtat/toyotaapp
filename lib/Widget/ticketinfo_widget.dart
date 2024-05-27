import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class TicketInfo extends StatelessWidget {
  final String ticketId;
  final String dateTime;
  final String reporter;

  const TicketInfo({
    super.key,
    required this.ticketId,
    required this.dateTime,
    required this.reporter,
  });

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
            const SizedBox(height: 4),
            Text(
              '$dateTime\nReported by $reporter',
              style: TextStyleList.subtext1,
            ),
          ],
        ),
        Image.asset("assets/arrowright.png"),
      ],
    );
  }
}
