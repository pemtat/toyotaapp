import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkcustomer.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/openmap.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/getcustomerbyid.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class PmItemWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final job;
  final RxInt expandedIndex;
  final int? index;
  final String? confirm;
  final HomeController jobController;
  final Color sidebar;

  const PmItemWidget(
      {super.key,
      required this.job,
      required this.expandedIndex,
      required this.jobController,
      this.confirm,
      required this.sidebar,
      this.index});

  @override
  Widget build(BuildContext context) {
    var warrantyInfoList = <WarrantyInfo>[].obs;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: Decoration1(sideBorderColor: sidebar),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'PM ID : ${job.id.toString().padLeft(4, '0')}',
                style: TextStyleList.text16,
              ),
              const SizedBox(width: 10),
              confirm != null
                  ? const StatusButton(status: 'notconfirm')
                  : StatusButton(status: stringToStatus(job.status)),
              const Spacer(),
              index != null
                  ? Obx(
                      () => IconButton(
                        icon: expandedIndex.value ==
                                jobController.pmItems.indexOf(job)
                            ? const ArrowUp()
                            : const ArrowDown(),
                        onPressed: () {
                          if (expandedIndex.value ==
                              jobController.pmItems.indexOf(job)) {
                            expandedIndex.value = (-2);
                          } else {
                            expandedIndex.value =
                                jobController.pmItems.indexOf(job);
                          }
                        },
                      ),
                    )
                  : Obx(
                      () => IconButton(
                        icon: expandedIndex.value ==
                                jobController.pmItemsPage.indexOf(job)
                            ? const ArrowUp()
                            : const ArrowDown(),
                        onPressed: () {
                          if (expandedIndex.value ==
                              jobController.pmItemsPage.indexOf(job)) {
                            expandedIndex.value = (-2);
                          } else {
                            expandedIndex.value =
                                jobController.pmItemsPage.indexOf(job);
                          }
                        },
                      ),
                    ),
            ],
          ),
          Wrap(
            children: [
              Text(
                job.customerName,
                style: TextStyleList.text15,
              ),
              4.wH,
              Text(
                '(Service Zone ${job.serviceZoneCode})',
                style: TextStyleList.subtext4,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined),
              const SizedBox(width: 5),
              Text(
                formatDateTimePlus(
                  formatDateTimeCut(
                    job.dueDate,
                  ),
                ),
                style: TextStyleList.subtext1,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Wrap(
            children: [
              FutureBuilder<CustomerById>(
                future: fetchCustomerInfo(job.customerNo ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: DataCircleLoading(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('-');
                  } else if (!snapshot.hasData) {
                    return const Text('-');
                  }

                  CustomerById customer = snapshot.data!;
                  String customerAddress = customer.customerAddress ?? '-';

                  return Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(width: 5),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: customerAddress,
                                style: TextStyleList.subtext3,
                              ),
                              WidgetSpan(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    2.wH,
                                    GoogleMapButton(
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const Center(
                                              child: DataCircleLoading(),
                                            );
                                          },
                                        );

                                        try {
                                          await openGoogleMaps(customerAddress);
                                        } catch (e) {
                                          print(e);
                                        } finally {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.person_search_sharp),
              5.wH,
              Text(
                extractDescription(job.description),
                style: TextStyleList.subtext1,
              ),
            ],
          ),
          index != null
              ? Obx(() => expandedIndex.value ==
                      jobController.pmItems.indexOf(job)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 0.5,
                            color: const Color(0xFFEAEAEA),
                          ),
                          const SizedBox(height: 10),
                          FutureBuilder<RxList<WarrantyInfo>>(
                            future: checkWarrantyReturn(
                                job.serialNo, warrantyInfoList),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: DataCircleLoading(),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Container();
                              }
                              var warrantyInfo = <WarrantyInfo>[].obs;
                              warrantyInfo = snapshot.data!;
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: Decoration2(),
                                child: Column(
                                  children: [
                                    BoxInfo(
                                        title: "Model",
                                        value: warrantyInfo.first.model),
                                    const SizedBox(height: 3),
                                    BoxInfo(
                                      title: "Serial Number",
                                      value: job.serialNo,
                                    ),
                                    const SizedBox(height: 3),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const SizedBox())
              : Obx(() => expandedIndex.value ==
                      jobController.pmItemsPage.indexOf(job)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 0.5,
                            color: const Color(0xFFEAEAEA),
                          ),
                          const SizedBox(height: 10),
                          FutureBuilder<RxList<WarrantyInfo>>(
                            future: checkWarrantyReturn(
                                job.serialNo, warrantyInfoList),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: DataCircleLoading(),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Container();
                              }
                              var warrantyInfo = <WarrantyInfo>[].obs;
                              warrantyInfo = snapshot.data!;
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: Decoration2(),
                                child: Column(
                                  children: [
                                    BoxInfo(
                                        title: "Model",
                                        value: warrantyInfo.first.model),
                                    const SizedBox(height: 3),
                                    BoxInfo(
                                      title: "Serial Number",
                                      value: job.serialNo,
                                    ),
                                    const SizedBox(height: 3),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const SizedBox())
        ],
      ),
    );
  }
}
