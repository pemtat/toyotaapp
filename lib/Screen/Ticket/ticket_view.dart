import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Screen/Ticket/jobs/jobs_view.dart';
import 'package:toyotamobile/Screen/Ticket/pms/pms_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/drawer_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class TicketView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final TicketController ticketController = Get.put(TicketController());
  final SubTicketController subticketController =
      Get.put(SubTicketController());
  TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: Drawer(
          width: 200,
          child: sideDrawer(),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(preferredSize),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text('All Ticket', style: TextStyleList.title1),
              ),
              Container(
                height: 0.5,
                color: white1,
              ),
              const AppDivider()
            ],
          ),
        ),
        body: RefreshIndicator(
          color: Colors.red,
          backgroundColor: Colors.white,
          onRefresh: refresh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.kH,
              SearchFilter(
                  searchController: ticketController.searchController,
                  searchQuery: ticketController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: ticketController.selectedDate,
                  clearFilters: ticketController.clearFilters),
              16.kH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ticketController.isSelected.value = 1;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ticketController.isSelected.value == 1
                                    ? red4
                                    : white5,
                                border: const Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 162, 160, 160),
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Text(
                                  'PM (${jobController.totalJobsPM.value})',
                                  style: ticketController.isSelected.value == 1
                                      ? TextStyleList.text7
                                      : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ticketController.isSelected.value = 3;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ticketController.isSelected.value == 3
                                    ? red4
                                    : white5,
                                border: const Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 162, 160, 160),
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Text(
                                  'Job (${jobController.totalJobsTicket.value})',
                                  style: ticketController.isSelected.value == 3
                                      ? TextStyleList.text7
                                      : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (ticketController.isSelected.value == 1) {
                  return Pms();
                } else if (ticketController.isSelected.value == 3) {
                  return Jobs();
                } else {
                  return const SizedBox();
                }
              }),
              10.kH,
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'pending', selectedStatus: ticketController.selectedStatus),
      buildCheckbox(
          status: 'confirmed', selectedStatus: ticketController.selectedStatus),
      buildCheckbox(
          status: 'completed', selectedStatus: ticketController.selectedStatus),
      buildCheckbox(
          status: 'closed', selectedStatus: ticketController.selectedStatus),
    ];
  }
}
