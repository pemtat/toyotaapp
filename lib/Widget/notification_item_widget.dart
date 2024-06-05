import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/notification_model.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        Text(
          notification.summary,
          style: TextStyleList.text10,
        ),
        Text(
          notification.description,
          style: TextStyleList.text16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TicketID : ${notification.ticketId}',
              style: TextStyleList.detailtext1,
            ),
            Text(
              notification.getFormattedDate(),
              style: TextStyleList.detailtext1,
            ),
          ],
        ),
      ],
    );
  }
}
