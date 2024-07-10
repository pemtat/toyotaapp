import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Screen/Account/account_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_view.dart';
import 'package:toyotamobile/Screen/Home/home_view.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_view.dart';
import 'package:toyotamobile/Styles/color.dart';

class BottomBarView extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    HomeView(),
    TicketView(),
    CalendarView(),
    NotificationView(),
    const AccountView()
  ];

  BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarController controller = Get.put(BottomBarController());
    return Scaffold(
      body: PageView(
        controller: _pageController,
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
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut,
                );
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
                  label: 'My Job',
                ),
                const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/ticket.png'),
                  ),
                  label: 'Ticket',
                ),
                const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/calendar.png'),
                  ),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/bell.png'),
                      ),
                      if (!controller.hasNotification.value)
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
                  label: 'Notification',
                ),
                const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/account.png'),
                  ),
                  label: 'Account',
                ),
              ],
            ),
          )),
    );
  }
}
