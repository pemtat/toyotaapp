import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Screen/Account/account_view.dart';
import 'package:toyotamobile/Screen/Allticket/NewJobs/newjobs_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_view.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';
import 'package:toyotamobile/Styles/color.dart';

class BottomBarView extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    HomeView(),
    NewJobsView(),
    const NotificationView(),
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
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                controller.currentIndex.value = index;
              },
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              backgroundColor: buttontextcolor,
              selectedLabelStyle:
                  GoogleFonts.kanit(fontWeight: FontWeight.w400),
              unselectedLabelStyle:
                  GoogleFonts.kanit(fontWeight: FontWeight.w400),
              selectedItemColor: bottombar,
              unselectedItemColor: bottombarlabel,
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 0
                          ? bottombar
                          : bottombarlabel,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset('assets/home.png'),
                  ),
                  label: 'My Job',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 1
                          ? bottombar
                          : bottombarlabel,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset('assets/ticket.png'),
                  ),
                  label: 'Ticket',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 2
                          ? bottombar
                          : bottombarlabel,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset('assets/calendar.png'),
                  ),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          controller.currentIndex.value == 3
                              ? bottombar
                              : bottombarlabel,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset('assets/bell.png'),
                      ),
                      if (controller.hasNotification.value)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: bottombar,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
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
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 4
                          ? bottombar
                          : bottombarlabel,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset('assets/account.png'),
                  ),
                  label: 'Account',
                ),
              ],
            ),
          )),
    );
  }
}
