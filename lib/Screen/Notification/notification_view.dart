import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Notification/notification_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/notification_item_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              backgroundColor: white3,
              title: Text('Notification', style: TextStyleList.title1),
            ),
            const AppDivider(),
            Container(
              height: 0.5,
              color: white1,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Text(
                'Today',
                style: TextStyleList.text16,
              ),
            ),
            Obx(() {
              final todayNotifications =
                  notificationController.todayNotifications;
              if (todayNotifications.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingApp),
                  child: Text('No notifications for today',
                      style: TextStyleList.subtitle2),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todayNotifications.length,
                itemBuilder: (context, index) {
                  final notification = todayNotifications[index];
                  return NotificationItem(notification: notification);
                },
              );
            }),
            16.kH,
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: paddingApp),
              child: Text(
                'Yesterday',
                style: TextStyleList.text16,
              ),
            ),
            Obx(() {
              final yesterdayNotifications =
                  notificationController.yesterdayNotifications;
              if (yesterdayNotifications.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingApp),
                  child: Text('No notifications for yesterday',
                      style: TextStyleList.subtitle2),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: yesterdayNotifications.length,
                itemBuilder: (context, index) {
                  final notification = yesterdayNotifications[index];
                  return NotificationItem(notification: notification);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
