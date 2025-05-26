import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/checksparepart.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/openmap.dart';
import 'package:toyotamobile/Function/showdialogsave.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Models/userallsales_model.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/Notification/notification_controller.dart';
import 'package:toyotamobile/Screen/ReturnSparePartShow/return_sparepart_show.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/sparepart_widget.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';

import 'package:toyotamobile/Widget/pdfviewer_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class SubJobSparePartWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final SubJobSparePart subJobSparePart;
  final Rx<String>? expandedTicketId;
  final Rx<bool>? expandedIndex;
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());

  final TicketDetailController ticketDetailController =
      Get.put(TicketDetailController());
  final TicketPmDetailController ticketPmDetailController =
      Get.put(TicketPmDetailController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  SubJobSparePartWidget(
      {super.key,
      required this.subJobSparePart,
      this.expandedTicketId,
      this.expandedIndex});

  @override
  Widget build(BuildContext context) {
    RxList<TextEditingController> remarkControllers =
        <TextEditingController>[].obs;

    void addRemark() {
      remarkControllers.add(TextEditingController());
    }

    void removeRemark(int index) {
      if (remarkControllers.isNotEmpty) {
        remarkControllers.removeAt(index);
      }
    }

    List<String> getAllRemarks() {
      return remarkControllers.map((controller) => controller.text).toList();
    }

    String summarySparePart(String option) {
      int summary = 0;
      if (option == 'discount') {
        final formatter = NumberFormat("#,###");
        if (subJobSparePart.sparepart != null &&
            subJobSparePart.sparepart!.isNotEmpty &&
            subJobSparePart.sparepart!.first.quantity != '0') {
          summary += subJobSparePart.sparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            int discount = int.parse(item.discount ?? '0');
            double priceAfterDiscount = salesPrice * (1 - (discount / 100));
            return total + (priceAfterDiscount * quantity).toInt();
          });
        }

        if (subJobSparePart.additionalSparepart != null &&
            subJobSparePart.additionalSparepart!.isNotEmpty &&
            subJobSparePart.additionalSparepart!.first.quantity != '0') {
          summary +=
              subJobSparePart.additionalSparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            int discount = int.parse(item.discount ?? '0');
            double priceAfterDiscount = salesPrice * (1 - (discount / 100));
            return total + (priceAfterDiscount * quantity).toInt();
          });
        }

        if (subJobSparePart.btrSparepart != null &&
            subJobSparePart.btrSparepart!.isNotEmpty &&
            subJobSparePart.btrSparepart!.first.quantity != '0') {
          summary += subJobSparePart.btrSparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            int discount = int.parse(item.discount ?? '0');
            double priceAfterDiscount = salesPrice * (1 - (discount / 100));
            return total + (priceAfterDiscount * quantity).toInt();
          });
        }

        if (subJobSparePart.pvtSparepart != null &&
            subJobSparePart.pvtSparepart!.isNotEmpty &&
            subJobSparePart.pvtSparepart!.first.quantity != '0') {
          summary += subJobSparePart.pvtSparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            int discount = int.parse(item.discount ?? '0');
            double priceAfterDiscount = salesPrice * (1 - (discount / 100));
            return total + (priceAfterDiscount * quantity).toInt();
          });
        }

        return formatter.format(summary);
      } else {
        if (subJobSparePart.sparepart != null &&
            subJobSparePart.sparepart!.isNotEmpty &&
            subJobSparePart.sparepart!.first.quantity != '0') {
          summary += subJobSparePart.sparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            return total + (salesPrice * quantity).toInt();
          });
        }

        if (subJobSparePart.additionalSparepart != null &&
            subJobSparePart.additionalSparepart!.isNotEmpty &&
            subJobSparePart.additionalSparepart!.first.quantity != '0') {
          summary +=
              subJobSparePart.additionalSparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            return total + (salesPrice * quantity).toInt();
          });
        }
        if (subJobSparePart.btrSparepart != null &&
            subJobSparePart.btrSparepart!.isNotEmpty &&
            subJobSparePart.btrSparepart!.first.quantity != '0') {
          summary += subJobSparePart.btrSparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            return total + (salesPrice * quantity).toInt();
          });
        }
        if (subJobSparePart.pvtSparepart != null &&
            subJobSparePart.pvtSparepart!.isNotEmpty &&
            subJobSparePart.pvtSparepart!.first.quantity != '0') {
          summary += subJobSparePart.pvtSparepart!.fold(0, (total, item) {
            int salesPrice = int.parse(item.salesPrice ?? '0');
            int quantity = int.parse(item.quantity ?? '0');
            return total + (salesPrice * quantity).toInt();
          });
        }
        String summaryCheck = summary > 100000 ? '1' : '0';

        return summaryCheck;
      }
    }

    String summarySparePartTotal(String option) {
      int summary = 0;

      void addToSummary(List<dynamic>? items) {
        if (items != null && items.isNotEmpty) {
          for (var item in items) {
            int quantity = int.parse(item.quantity ?? '0');
            if (quantity != 0) {
              int itemSummary = double.parse(item.summary ?? '0').toInt();
              summary += itemSummary;
            }
          }
        }
      }

      addToSummary(subJobSparePart.sparepart);
      addToSummary(subJobSparePart.additionalSparepart);
      addToSummary(subJobSparePart.btrSparepart);
      addToSummary(subJobSparePart.pvtSparepart);
      addToSummary(subJobSparePart.pvtSparepartIc);

      if (option == 'discount') {
        final formatter = NumberFormat("#,###");
        return formatter.format(summary);
      } else {
        String summaryCheck = summary > 100000 ? '1' : '0';
        return summaryCheck;
      }
    }

    var usersList = <UsersSales>[].obs;
    bool emptySparePart = checkEmptySparePart(
        subJobSparePart.sparepart ?? [],
        subJobSparePart.additionalSparepart ?? [],
        subJobSparePart.btrSparepart ?? [],
        subJobSparePart.pvtSparepart ?? [],
        subJobSparePart.pvtSparepartIc ?? []);
    final rejectNote = TextEditingController().obs;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              color: white1,
            ),
            child: Row(
              children: [
                Text(
                  context.tr('spare_part_request_status'),
                  style: TextStyleList.detail2,
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: Decoration3(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subJobSparePart.projectId == '1'
                          ? Text(
                              'Job ID : ${subJobSparePart.id}',
                              style: TextStyleList.subtitle9,
                            )
                          : Text(
                              'PM ID : ${subJobSparePart.bugId}',
                              style: TextStyleList.subtitle9,
                            ),
                      Row(
                        children: [
                          Text(
                            '${context.tr('status')} :',
                            style: TextStyleList.detail2,
                          ),
                          4.wH,
                          StatusButton3(
                              status:
                                  subJobSparePart.estimateStatus.toString()),
                        ],
                      ),
                    ],
                  ),
                  6.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subJobSparePart.projectId == '1'
                          ? Text(
                              'Ticket : ${subJobSparePart.bugId}',
                              style: TextStyleList.subtitle9,
                            )
                          : Container(),
                      subJobSparePart.quotation == '1' ||
                              summarySparePartTotal('') == '1'
                          ? Row(
                              children: [
                                Text(
                                  'Tech Manager :',
                                  style: TextStyleList.detail2,
                                ),
                                4.wH,
                                StatusButton2(
                                    status: subJobSparePart.techManagerStatus
                                        .toString()),
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  'Sales',
                                  style: TextStyleList.detail2,
                                ),
                                Text(
                                  ' :',
                                  style: TextStyleList.title1,
                                ),
                                4.wH,
                                StatusButton2(
                                    status:
                                        subJobSparePart.salesStatus.toString())
                              ],
                            ),
                    ],
                  ),
                  8.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subJobSparePart.projectId == '1'
                          ? Text(
                              'BB no. : ${subJobSparePart.referenceCode ?? ''}',
                              style: TextStyleList.subtitle9,
                            )
                          : Container(),
                      if (subJobSparePart.quotation != '1' &&
                          summarySparePartTotal('') == '1')
                        Row(
                          children: [
                            Text(
                              'Sales',
                              style: TextStyleList.detail2,
                            ),
                            Text(
                              ' :',
                              style: TextStyleList.title1,
                            ),
                            4.wH,
                            StatusButton2(
                                status: subJobSparePart.salesStatus.toString())
                          ],
                        )
                    ],
                  ),
                  6.kH,
                  if (subJobSparePart.documentNo != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'OJ no. : ${subJobSparePart.documentNo ?? ''}',
                          style: TextStyleList.subtitle9,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Purchase Order',
                        //       style: TextStyleList.detail2,
                        //     ),
                        //     Text(
                        //       ' :',
                        //       style: TextStyleList.title1,
                        //     ),
                        //     4.wH,
                        //     StatusButton4(
                        //         status:
                        //             subJobSparePart.purchaseStatus.toString())
                        //   ],
                        // )
                      ],
                    ),
                  8.kH,
                  if (subJobSparePart.trNo != '' &&
                      subJobSparePart.trNo != null &&
                      jobController.techLevel.value == '1')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 130,
                            child: ButtonCustom(
                              title: context.tr('return_spare_part_action'),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        Obx(() => Material(
                                              color: Colors.transparent,
                                              child: ReturnSparepartShow(
                                                subJobSparePart:
                                                    subJobSparePart,
                                              ),
                                            )));
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 6.0),
                              style: TextStyleList.text7
                                  .copyWith(color: Colors.white, fontSize: 13),
                            )),
                      ],
                    ),
                  8.kH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Warranty : ',
                            style: TextStyleList.text1,
                          ),
                          CheckStatus(
                              status: subJobSparePart.warrantyStatus ?? '')
                        ],
                      ),
                      if (jobController.techLevel.value == '1')
                        if (subJobSparePart.trNoUrl != null &&
                            subJobSparePart.trNoUrl != '')
                          InkWell(
                            onTap: () {
                              showImageDialogUrlCode(
                                  context, subJobSparePart.trNoUrl ?? '');
                            },
                            child: Text(
                              subJobSparePart.trNo ?? '',
                              style:
                                  TextStyleList.subtext9.copyWith(fontSize: 15),
                            ),
                          ),
                      if (jobController.techLevel.value == '2')
                        InkWell(
                          onTap: () async {
                            RxString pdfReport = ''.obs;
                            String? token = await getToken();
                            showDialog(
                                context: context,
                                barrierColor: const Color.fromARGB(59, 0, 0, 0),
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                      child: DataCircleLoading());
                                });
                            if (subJobSparePart.projectId == '1') {
                              await fetchPdfReport(subJobSparePart.id ?? '',
                                  token ?? '', pdfReport, 'estimate');
                            } else {
                              await fetchPdfReport(subJobSparePart.bugId ?? '',
                                  token ?? '', pdfReport, 'estimate_pm');
                            }
                            Navigator.pop(context);
                            if (pdfReport.value != '') {
                              Get.to(() => PdfBase64View(
                                  name: context.tr('estimate_report'),
                                  path: pdfReport.value));
                            }
                          },
                          child: Text(
                            context.tr('view_pdf'),
                            style: TextStyleList.subtext9,
                          ),
                        ),
                    ],
                  ),
                  4.kH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${context.tr('summary_issue')} : ${subJobSparePart.description ?? ''}',
                          style: TextStyleList.text1,
                        ),
                      ),
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
                            await openGoogleMaps(
                                subJobSparePart.destinationAddress ?? '');
                          } catch (e) {
                            print(e);
                          } finally {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                  4.kH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${context.tr('remark')} : ${subJobSparePart.techManagerRemark == '' || subJobSparePart.techManagerRemark == null ? '-' : subJobSparePart.techManagerRemark}',
                        style: TextStyleList.text1,
                      ),
                      if (expandedIndex != null && expandedTicketId != null)
                        Obx(() => InkWell(
                              onTap: () {
                                if (expandedTicketId!.value ==
                                    subJobSparePart.id) {
                                  expandedIndex!.value = !expandedIndex!.value;
                                } else {
                                  expandedTicketId!.value =
                                      subJobSparePart.id ?? '';
                                  expandedIndex!.value = true;
                                }
                              },
                              child: expandedIndex!.value &&
                                      expandedTicketId!.value ==
                                          subJobSparePart.id
                                  ? const ArrowUp(
                                      width: 30,
                                      height: 30,
                                    )
                                  : const ArrowDown(
                                      width: 30,
                                      height: 30,
                                    ),
                            )),
                    ],
                  ),
                  if (jobController.techLevel.value == '2')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${context.tr('quotation')} : ${subJobSparePart.quotation == '1' ? context.tr('no') : context.tr('yes')}',
                          style: TextStyleList.text1,
                        ),
                        Text(
                          '${context.tr('total_sparepart')} : ${summarySparePartTotal('discount')}',
                          style: TextStyleList.text1,
                        ),
                      ],
                    ),
                  expandedIndex != null && expandedTicketId != null
                      ? Obx(() => (expandedIndex!.value &&
                              expandedTicketId!.value == subJobSparePart.id)
                          ? SparePartDetail(
                              additionalSparepart:
                                  subJobSparePart.additionalSparepart ?? [],
                              sparepart: subJobSparePart.sparepart ?? [],
                              btrSparepart: subJobSparePart.btrSparepart ?? [],
                              pvtSparepart: subJobSparePart.pvtSparepart ?? [],
                              pvtSparepartIc:
                                  subJobSparePart.pvtSparepartIc ?? [],
                              jobId: subJobSparePart.id ?? '',
                              bugId: subJobSparePart.bugId ?? '',
                              projectId: subJobSparePart.projectId ?? '',
                              techLevel: jobController.techLevel.value,
                              techManagerStatus:
                                  subJobSparePart.techManagerStatus ?? '',
                              estimateStatus:
                                  subJobSparePart.estimateStatus ?? '',
                            )
                          : Container())
                      : SparePartDetail(
                          additionalSparepart:
                              subJobSparePart.additionalSparepart ?? [],
                          sparepart: subJobSparePart.sparepart ?? [],
                          btrSparepart: subJobSparePart.btrSparepart ?? [],
                          pvtSparepart: subJobSparePart.pvtSparepart ?? [],
                          pvtSparepartIc: subJobSparePart.pvtSparepartIc ?? [],
                          jobId: subJobSparePart.id ?? '',
                          bugId: subJobSparePart.bugId ?? '',
                          projectId: subJobSparePart.projectId ?? '',
                          techLevel: jobController.techLevel.value,
                          techManagerStatus:
                              subJobSparePart.techManagerStatus ?? '',
                          estimateStatus: subJobSparePart.estimateStatus ?? '',
                        ),
                  6.kH,
                  jobController.techLevel.value == '1'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (expandedIndex == null)
                              SizedBox(
                                  width: 70,
                                  child: ButtonRed(
                                      title: context.tr('close'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      })),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            subJobSparePart.techManagerStatus == '1' ||
                                    subJobSparePart.techManagerStatus == '2'
                                ? expandedIndex == null
                                    ? SizedBox(
                                        width: 70,
                                        child: ButtonRed(
                                            title: context.tr('close'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            }))
                                    : Container()
                                : (subJobSparePart.techManagerStatus == '0') &&
                                        subJobSparePart.estimateStatus == '1'
                                    ? Row(
                                        children: [
                                          SizedBox(
                                              width: 120,
                                              child: ButtonRed(
                                                  color: blue1,
                                                  title: context.tr('approve'),
                                                  onTap: () async {
                                                    // var selectedUserId = ''.obs;
                                                    // var selectedUser = ''.obs;
                                                    // await fetchAllSalesAdmin(
                                                    //     usersList,
                                                    //     subJobSparePart
                                                    //             .projectId ??
                                                    //         '',
                                                    //     subJobSparePart.id ??
                                                    //         '',
                                                    //     subJobSparePart.bugId ??
                                                    //         '');
                                                    // if (usersList.isNotEmpty) {
                                                    //   selectedUserId.value =
                                                    //       usersList.first.id ??
                                                    //           '';
                                                    //   selectedUser.value =
                                                    //       usersList.first
                                                    //               .realname ??
                                                    //           '';
                                                    // }
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              white4,
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              // if (subJobSparePart
                                                              //       .quotation ==
                                                              //   '2')
                                                              // Row(
                                                              //   children: [
                                                              //     Expanded(
                                                              //       child: Obx(
                                                              //           () {
                                                              //         return GestureDetector(
                                                              //           onTap:
                                                              //               () {
                                                              //             showDialog(
                                                              //               context: context,
                                                              //               builder: (BuildContext context) {
                                                              //                 return AlertDialog(
                                                              //                   backgroundColor: white3,
                                                              //                   title: Center(child: Text('เลือก Sales Admin')),
                                                              //                   titleTextStyle: TextStyleList.text1,
                                                              //                   content: SingleChildScrollView(
                                                              //                     child: Column(
                                                              //                       mainAxisSize: MainAxisSize.min,
                                                              //                       children: usersList.map<Widget>((UsersSales user) {
                                                              //                         return ListTile(
                                                              //                           title: Text(user.realname ?? 'ไม่พบ Sales'),
                                                              //                           onTap: () {
                                                              //                             selectedUser.value = user.realname ?? '';
                                                              //                             selectedUserId.value = user.id ?? '';
                                                              //                             Navigator.of(context).pop();
                                                              //                           },
                                                              //                         );
                                                              //                       }).toList(),
                                                              //                     ),
                                                              //                   ),
                                                              //                 );
                                                              //               },
                                                              //             );
                                                              //           },
                                                              //           child:
                                                              //               AbsorbPointer(
                                                              //             child:
                                                              //                 TextField(
                                                              //               controller: TextEditingController(text: selectedUser.value),
                                                              //               decoration: InputDecoration(labelText: 'Sales Admin', labelStyle: TextStyleList.text9),
                                                              //             ),
                                                              //           ),
                                                              //         );
                                                              //       }),
                                                              //     ),
                                                              //     Obx(() {
                                                              //       if (selectedUser
                                                              //               .value !=
                                                              //           '') {
                                                              //         return InkWell(
                                                              //           onTap:
                                                              //               () {
                                                              //             selectedUser.value =
                                                              //                 '';
                                                              //             selectedUserId.value =
                                                              //                 '';
                                                              //           },
                                                              //           child:
                                                              //               const Icon(Icons.close),
                                                              //         );
                                                              //       } else {
                                                              //         return Container();
                                                              //       }
                                                              //     })
                                                              //   ],
                                                              // ),
                                                              // 10.kH,
                                                              Obx(() => Column(
                                                                    children: [
                                                                      ...List.generate(
                                                                          remarkControllers
                                                                              .length,
                                                                          (index) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 8.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: TextFieldType(
                                                                                  hintText: context.tr('remark'),
                                                                                  textSet: remarkControllers[index],
                                                                                ),
                                                                              ),
                                                                              IconButton(
                                                                                icon: Icon(Icons.remove_circle_outline),
                                                                                onPressed: () {
                                                                                  removeRemark(index);
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          const Icon(
                                                                            size:
                                                                                20,
                                                                            Icons.add,
                                                                            color:
                                                                                black6,
                                                                          ),
                                                                          InkWell(
                                                                              onTap: () {
                                                                                addRemark();
                                                                              },
                                                                              child: Text(
                                                                                context.tr('add_remark'),
                                                                                style: TextStyleList.text3,
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ],
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  context
                                                                      .tr('no'),
                                                                  style:
                                                                      TextStyleList
                                                                          .text1),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                List<String>
                                                                    remarks =
                                                                    getAllRemarks();
                                                                // if (subJobSparePart
                                                                //             .quotation ==
                                                                //         '2' &&
                                                                //     selectedUserId
                                                                //             .value ==
                                                                //         '') {
                                                                //   showMessage(
                                                                //       'ไม่พบ Sales Admin');
                                                                // } else {
                                                                await createSparepartNote(
                                                                    subJobSparePart
                                                                            .id ??
                                                                        '',
                                                                    jobController
                                                                        .techManageId
                                                                        .value,
                                                                    jobController
                                                                        .techLevel
                                                                        .value,
                                                                    jobController
                                                                        .handlerIdTech
                                                                        .value,
                                                                    remarks);
                                                                if (subJobSparePart
                                                                        .quotation ==
                                                                    '1') {
                                                                  await updateJobSparePart(
                                                                      subJobSparePart
                                                                              .id ??
                                                                          '',
                                                                      jobController
                                                                          .techLevel
                                                                          .value,
                                                                      jobController
                                                                          .handlerIdTech
                                                                          .value,
                                                                      '',
                                                                      'approve',
                                                                      subJobSparePart
                                                                              .bugId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .handlerId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .reportjobId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .projectId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .adminId ??
                                                                          '0');
                                                                } else {
                                                                  await updateJobSparePart(
                                                                      subJobSparePart
                                                                              .id ??
                                                                          '',
                                                                      jobController
                                                                          .techLevel
                                                                          .value,
                                                                      jobController
                                                                          .handlerIdTech
                                                                          .value,
                                                                      '',
                                                                      'approve_add_sales:${1}',
                                                                      subJobSparePart
                                                                              .bugId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .handlerId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .reportjobId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .projectId ??
                                                                          '',
                                                                      subJobSparePart
                                                                              .adminId ??
                                                                          '0');
                                                                }
                                                                await notificationController.fetchNotifySubJobSparePartId(
                                                                    subJobSparePart
                                                                            .id ??
                                                                        '0',
                                                                    subJobSparePart
                                                                            .bugId ??
                                                                        '0',
                                                                    subJobSparePart
                                                                            .projectId ??
                                                                        '0');
                                                                Navigator.pop(
                                                                    context);
                                                                showMessage(
                                                                    'ดำเนินการสำเร็จ');
                                                              },
                                                              // },
                                                              child: Text(
                                                                  context.tr(
                                                                      'yes'),
                                                                  style:
                                                                      TextStyleList
                                                                          .text1),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  })),
                                          6.wH,
                                          SizedBox(
                                            width: 120,
                                            child: ButtonRed(
                                              title: context.tr('not_approve'),
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor: white4,
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          10.kH,
                                                          TextFieldType(
                                                            hintText: context
                                                                .tr('remark'),
                                                            textSet: rejectNote
                                                                .value,
                                                            maxLine: 5,
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            context.tr('no'),
                                                            style: TextStyleList
                                                                .text1,
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await updateJobSparePart(
                                                                subJobSparePart
                                                                        .id ??
                                                                    '',
                                                                jobController
                                                                    .techLevel
                                                                    .value,
                                                                jobController
                                                                    .handlerIdTech
                                                                    .value,
                                                                rejectNote
                                                                    .value.text,
                                                                'reject',
                                                                subJobSparePart
                                                                        .bugId ??
                                                                    '',
                                                                subJobSparePart
                                                                        .handlerId ??
                                                                    '',
                                                                subJobSparePart
                                                                        .reportjobId ??
                                                                    '',
                                                                subJobSparePart
                                                                        .projectId ??
                                                                    '',
                                                                subJobSparePart
                                                                        .adminId ??
                                                                    '0');
                                                            await notificationController
                                                                .fetchNotifySubJobSparePartId(
                                                                    subJobSparePart
                                                                            .id ??
                                                                        '0',
                                                                    subJobSparePart
                                                                            .bugId ??
                                                                        '0',
                                                                    subJobSparePart
                                                                            .projectId ??
                                                                        '0');

                                                            Navigator.pop(
                                                                context);
                                                            showMessage(
                                                                'ดำเนินการสำเร็จ');
                                                          },
                                                          child: Text(
                                                            context.tr('yes'),
                                                            style: TextStyleList
                                                                .text1,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          6.wH,
                                          if (expandedIndex == null)
                                            SizedBox(
                                                width: 70,
                                                child: ButtonGray(
                                                    title: context.tr('close'),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    })),
                                          6.wH,
                                        ],
                                      )
                                    : Container()
                          ],
                        )
                ],
              )),
        ],
      ),
    );
  }
}
