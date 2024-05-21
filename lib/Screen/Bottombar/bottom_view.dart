import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Screen/Account/account_view.dart';
import 'package:toyotamobile/Screen/Allticket/NewJobs/newjobs_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_view.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';

class BottomBarView extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    HomeView(),
    NewJobsView(),
    NotificationView(),
    AccountView()
  ];

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
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              controller.currentIndex.value = index;
            },
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: GoogleFonts.kanit(fontWeight: FontWeight.w400),
            unselectedLabelStyle:
                GoogleFonts.kanit(fontWeight: FontWeight.w400),
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'My Job',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.airplane_ticket),
                label: 'Ticket',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Icon(Icons.notifications_none),
                    if (controller.hasNotification.value)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 10,
                            minHeight: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Account',
              ),
            ],
          )),
    );
  }
}
