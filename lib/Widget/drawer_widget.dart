import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Account/account_controller.dart';
import 'package:toyotamobile/Screen/Account/account_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';
import 'package:toyotamobile/Screen/Report/report_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

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
                Text('Menu', style: TextStyleList.headingbar),
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
            title: Text('Notification', style: TextStyleList.subtitle3),
            onTap: () {
              Navigator.pop(context);
              bottomController.hasNotification.value = false;
              Get.to(() => NotificationView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.assessment_outlined),
            title: Text('Report', style: TextStyleList.subtitle3),
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
            title: Text('Account', style: TextStyleList.subtitle3),
            onTap: () {
              Navigator.pop(context);

              Get.to(() => const AccountView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('Logout', style: TextStyleList.subtitle3),
            onTap: () {
              accountController.showLogoutDialog(
                context,
                'Are you sure to logout?',
                'Cancel',
                'Yes,Log out',
              );
            },
          ),
        ],
      ),
    );
  }
}
