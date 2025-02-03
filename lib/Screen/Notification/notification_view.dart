import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/Notification/notification_controller.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobSparepartReturn_widget%20copy/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/notification_item_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});
  final HomeController jobController = Get.put(HomeController());
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
              title:
                  Text(context.tr('notification'), style: TextStyleList.title1),
            ),
            const AppDivider(),
            Container(
              height: 0.5,
              color: white1,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: Colors.red,
        backgroundColor: Colors.white,
        onRefresh: refresh,
        displacement: 0,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              //   child: Text(
              //     'Today',
              //     style: TextStyleList.text16,
              //   ),
              // ),
              Obx(() {
                // final todayNotifications =
                //     notificationController.todayNotifications;
                if (jobController.notificationHistory.isEmpty) {
                  return Container(
                    height: 70,
                    margin: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No notifications history',
                          style: TextStyleList.subtitle2,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: jobController.notificationHistory.length > 10
                      ? 10
                      : jobController.notificationHistory.length,
                  itemBuilder: (context, index) {
                    final notification =
                        jobController.notificationHistory[index];
                    return InkWell(
                        onTap: () async {
                          if (notification.notifyType == 'QT') {
                            await notificationController
                                .fetchNotifySubJobSparePartId(
                                    notification.jobId ?? '0',
                                    notification.bugId ?? '0',
                                    notification.projectId ?? '0');

                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Obx(
                                () => Material(
                                  color: Colors.transparent,
                                  child: SubJobSparePartWidget(
                                    subJobSparePart: notificationController
                                        .subJobSparePart.first,
                                  ),
                                ),
                              ),
                            );
                          } else if (notification.notifyType == 'QTR') {
                            await notificationController
                                .fetchNotifySubJobSparePartReturnId(
                                    notification.jobId ?? '0',
                                    notification.bugId ?? '0',
                                    notification.projectId ?? '0');

                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Obx(
                                () => Material(
                                  color: Colors.transparent,
                                  child: SubJobSparePartReturnWidget(
                                    subJobSparePart: notificationController
                                        .subJobSparePartReturn.first,
                                  ),
                                ),
                              ),
                            );
                          } else if (notification.notifyType == 'NJ') {
                            if (notification.projectId == '2') {
                            } else {
                              if (notification.jobStatus == '101') {
                                Get.to(() => PendingTaskView(
                                      ticketId: notification.bugId ?? '',
                                      jobId: notification.jobId ?? '',
                                    ));
                              } else if (notification.jobStatus == '102') {
                                Get.to(() => JobDetailView(
                                      ticketId: notification.bugId ?? '',
                                      jobId: notification.jobId ?? '',
                                    ));
                              } else {
                                Get.to(() => TicketDetailView(
                                      ticketId: notification.bugId ?? '',
                                      jobId: notification.jobId ?? '',
                                    ));
                              }
                            }
                          } else if (notification.notifyType == 'NJPM') {
                            if (notification.projectId == '2') {
                            } else {
                              if (stringToStatus(
                                      notification.bugStatus ?? '') ==
                                  'pending') {
                                Get.to(() => PendingTaskViewPM(
                                    ticketId: notification.bugStatus ?? ''));
                              } else if (stringToStatus(
                                      notification.bugStatus ?? '') ==
                                  'confirmed') {
                                Get.to(() => JobDetailViewPM(
                                    ticketId: notification.bugStatus ?? ''));
                              } else if (stringToStatus(
                                      notification.bugStatus ?? '') ==
                                  'closed') {
                                Get.to(() => TicketPMDetailView(
                                    ticketId: notification.bugStatus ?? ''));
                              }
                            }
                          }
                        },
                        child: NotificationItem(notification: notification));
                  },
                );
              }),
              // 16.kH,
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       vertical: 8.0, horizontal: paddingApp),
              //   child: Text(
              //     'Yesterday',
              //     style: TextStyleList.text16,
              //   ),
              // ),
              // Obx(() {
              //   final yesterdayNotifications =
              //       notificationController.yesterdayNotifications;
              //   if (yesterdayNotifications.isEmpty) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: paddingApp),
              //       child: Text('No notifications for yesterday',
              //           style: TextStyleList.subtitle2),
              //     );
              //   }
              //   return ListView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: yesterdayNotifications.length,
              //     itemBuilder: (context, index) {
              //       final notification = yesterdayNotifications[index];
              //       return NotificationItem(notification: notification);
              //     },
              //   );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
