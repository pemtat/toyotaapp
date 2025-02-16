import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/Account/account_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_view.dart';
import 'package:toyotamobile/Screen/Home/home_view.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';
import 'package:toyotamobile/Screen/Sparepart/sparepart_view.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class BottomBarView extends StatelessWidget {
  final List<Widget> _pages = [
    HomeView(),
    TicketView(),
    SparePartView(),
    CalendarView(),
    NotificationView(),
    const AccountView()
  ];

  BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarController controller = Get.put(BottomBarController());
    controller.checkAppVersion(context);
    return Scaffold(
      body: PageView(
        controller: bottomController.pageController,
        children: _pages,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
      ),
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (index) {
                bottomController.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut,
                );
                // if (index == 4) {
                //   controller.clearNotification();
                // }
                controller.currentIndex.value = index;
              },
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              backgroundColor: white3,
              selectedLabelStyle:
                  GoogleFonts.kanit(fontWeight: FontWeight.w400),
              unselectedLabelStyle:
                  GoogleFonts.kanit(fontWeight: FontWeight.w400),
              unselectedItemColor: black6,
              selectedItemColor: red1,
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 0 ? red1 : black6,
                      BlendMode.srcIn,
                    ),
                    child: const ImageIcon(
                      AssetImage('assets/home.png'),
                    ),
                  ),
                  label: context.tr('my_job'),
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage('assets/ticket.png'),
                  ),
                  label: context.tr('ticket'),
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage('assets/sparepart.png'),
                  ),
                  label: context.tr('spare_part'),
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage('assets/calendar.png'),
                  ),
                  label: context.tr('calendar'),
                ),
                // BottomNavigationBarItem(
                //   icon: Stack(
                //     children: [
                //       const ImageIcon(
                //         AssetImage('assets/bell.png'),
                //       ),
                //       if (controller.hasNotification.value)
                //         Positioned(
                //           top: 0,
                //           right: 2,
                //           child: Container(
                //             padding: const EdgeInsets.all(2),
                //             decoration: const BoxDecoration(
                //               color: red1,
                //               shape: BoxShape.circle,
                //             ),
                //             constraints: const BoxConstraints(
                //               minWidth: 8,
                //               minHeight: 8,
                //             ),
                //           ),
                //         ),
                //     ],
                //   ),
                //   label: 'Notification',
                // ),
              ],
            ),
          )),
    );
  }
}
