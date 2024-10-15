import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Models/notificationhistory_model.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';

class NotificationItem extends StatelessWidget {
  final NotificationHistory notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        Text(
          notification.title ?? '',
          style: TextStyleList.text10,
        ),
        Text(
          notification.details ?? '',
          style: TextStyleList.text16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TicketID : ${notification.bugId}',
              style: TextStyleList.detailtext1,
            ),
            Text(
              formatDateTimePlus(notification.datetimeNotify ?? ''),
              style: TextStyleList.detailtext1,
            ),
          ],
        ),
      ],
    );
  }
}
