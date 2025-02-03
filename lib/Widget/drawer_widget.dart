import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Account/account_controller.dart';
import 'package:toyotamobile/Screen/Account/account_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';
import 'package:toyotamobile/Screen/Report/report_view.dart';
import 'package:toyotamobile/Screen/ReturnSparePart/return_sparepart_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class sideDrawer extends StatelessWidget {
  sideDrawer({super.key});
  final AccountController accountController = Get.put(AccountController());
  final BottomBarController bottomController = Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: white9),
            child: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.tr('menu'), style: TextStyleList.headingbar),
                2.wH,
                const Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Icon(
                    Icons.home,
                    size: 35,
                    color: black4,
                  ),
                )
                // Image.asset(
                //   'assets/tool.png',
                //   width: 40,
                // ),
              ],
            )),
          ),
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: Text(context.tr('return_spare_part'),
                style: TextStyleList.subtitle3),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ReturnSparePartView());
            },
          ),
          ListTile(
            leading: Stack(
              children: [
                const Icon(Icons.notifications_none),
                if (bottomController.hasNotification.value)
                  Positioned(
                    top: 0,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: red1,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 8,
                        minHeight: 8,
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(context.tr('notification'),
                style: TextStyleList.subtitle3),
            onTap: () {
              Navigator.pop(context);
              bottomController.hasNotification.value = false;
              Get.to(() => NotificationView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.assessment_outlined),
            title: Text(context.tr('report'), style: TextStyleList.subtitle3),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ReportView());
            },
          ),
          ListTile(
            leading: (Image.asset(
              'assets/account.png',
              color: black2,
            )),
            title: Text(context.tr('account'), style: TextStyleList.subtitle3),
            onTap: () {
              Navigator.pop(context);

              Get.to(() => const AccountView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(context.tr('logout'), style: TextStyleList.subtitle3),
            onTap: () {
              accountController.showLogoutDialog(
                context,
                context.tr('logout_message'),
                context.tr('cancel'),
                context.tr('logout_confirm'),
              );
            },
          ),
        ],
      ),
    );
  }
}
