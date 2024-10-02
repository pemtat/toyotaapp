import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/showdialogsave.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Models/userallsales_model.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/sparepart_widget.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';

import 'package:toyotamobile/Widget/pdfviewer_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class SubJobSparePartWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final SubJobSparePart subJobSparePart;
  final Rx<String>? expandedTicketId;
  final Rx<bool>? expandedIndex;
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());

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
        String summaryCheck = summary > 100000 ? '1' : '0';

        return summaryCheck;
      }
    }

    var usersList = <UsersSales>[].obs;
    final rejectNote = TextEditingController().obs;
    return Column(
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
                'Sparepart Request Status',
                style: TextStyleList.subtitle1,
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
                    Text(
                      'Job ID : ${subJobSparePart.id}',
                      style: TextStyleList.title1,
                    ),
                    Row(
                      children: [
                        Text(
                          'Status :',
                          style: TextStyleList.subtitle1,
                        ),
                        4.wH,
                        StatusButton3(
                            status: subJobSparePart.estimateStatus.toString()),
                      ],
                    ),
                  ],
                ),
                6.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ticket : ${subJobSparePart.bugId}',
                      style: TextStyleList.title1,
                    ),
                    subJobSparePart.quotation == '1' ||
                            summarySparePart('') == '1'
                        ? Row(
                            children: [
                              Text(
                                'Tech Manager :',
                                style: TextStyleList.subtitle1,
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
                                style: TextStyleList.subtitle1,
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
                    Text(
                      'BB no. : ${subJobSparePart.referenceCode ?? ''}',
                      style: TextStyleList.title1,
                    ),
                    if (subJobSparePart.quotation != '1' &&
                        summarySparePart('') == '1')
                      Row(
                        children: [
                          Text(
                            'Sales',
                            style: TextStyleList.subtitle1,
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
                                return const Center(child: DataCircleLoading());
                              });
                          await fetchPdfReport(subJobSparePart.id ?? '',
                              token ?? '', pdfReport, 'estimate');
                          Navigator.pop(context);
                          if (pdfReport.value != '') {
                            Get.to(() => PdfBase64View(
                                name: 'Estimate Report',
                                path: pdfReport.value));
                          }
                        },
                        child: Text(
                          'View PDF',
                          style: TextStyleList.subtext9,
                        ),
                      ),
                  ],
                ),
                4.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Issue Remark : ${subJobSparePart.description ?? ''}',
                      style: TextStyleList.text1,
                    ),
                  ],
                ),
                4.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remark : ${subJobSparePart.techManagerRemark == '' || subJobSparePart.techManagerRemark == null ? '-' : subJobSparePart.techManagerRemark}',
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
                        'Quotation : ${subJobSparePart.quotation == '1' ? 'No' : 'Yes'}',
                        style: TextStyleList.text1,
                      ),
                      Text(
                        'Total : ${summarySparePart('discount')}',
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
                            jobId: subJobSparePart.id ?? '',
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
                        jobId: subJobSparePart.id ?? '',
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
                                width: 120,
                                child: ButtonRed(
                                    title: 'ปิด',
                                    onTap: () {
                                      Navigator.pop(context);
                                    })),
                          6.wH,
                          subJobSparePart.bugStatus != '90' &&
                                  (subJobSparePart.estimateStatus == '0' ||
                                      subJobSparePart.estimateStatus == '3')
                              ? SizedBox(
                                  width: 120,
                                  child: ButtonRed(
                                      title: 'ขออนุมัติ',
                                      onTap: () {
                                        showApproveSparePart(
                                            context,
                                            'Are you sure to request?',
                                            'No',
                                            'Yes', () async {
                                          await updateJobSparePart(
                                              subJobSparePart.id ?? '',
                                              jobController.techManageId.value,
                                              jobController.techLevel.value,
                                              jobController.handlerIdTech.value,
                                              '',
                                              'send');
                                          await jobDetailController
                                              .fetchSubJobSparePartId();
                                        }, red1);
                                      }))
                              : Container(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          subJobSparePart.techManagerStatus == '1' ||
                                  subJobSparePart.techManagerStatus == '2'
                              ? Container()
                              : subJobSparePart.techManagerStatus == '0' &&
                                      subJobSparePart.estimateStatus == '1'
                                  ? Row(
                                      children: [
                                        SizedBox(
                                            width: 120,
                                            child: ButtonRed(
                                                color: blue1,
                                                title: 'Approve',
                                                onTap: () async {
                                                  var selectedUser = ''.obs;
                                                  var selectedUserId = ''.obs;
                                                  await fetchAllSales(
                                                      usersList);
                                                  addRemark();
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
                                                            if (subJobSparePart
                                                                    .quotation ==
                                                                '2')
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Obx(() {
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                backgroundColor: white3,
                                                                                title: Center(child: Text('เลือก Sales')),
                                                                                titleTextStyle: TextStyleList.text1,
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: usersList.map<Widget>((UsersSales user) {
                                                                                      return ListTile(
                                                                                        title: Text(user.realname ?? 'No data'),
                                                                                        onTap: () {
                                                                                          selectedUser.value = user.realname ?? '';
                                                                                          selectedUserId.value = user.id ?? '';
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      );
                                                                                    }).toList(),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child:
                                                                            AbsorbPointer(
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                TextEditingController(text: selectedUser.value),
                                                                            decoration:
                                                                                InputDecoration(labelText: 'Sales', labelStyle: TextStyleList.text9),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                                  ),
                                                                  Obx(() {
                                                                    if (selectedUser
                                                                            .value !=
                                                                        '') {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          selectedUser.value =
                                                                              '';
                                                                          selectedUserId.value =
                                                                              '';
                                                                        },
                                                                        child: const Icon(
                                                                            Icons.close),
                                                                      );
                                                                    } else {
                                                                      return Container();
                                                                    }
                                                                  })
                                                                ],
                                                              ),
                                                            10.kH,
                                                            Obx(() => Column(
                                                                  children: [
                                                                    ...List.generate(
                                                                        remarkControllers
                                                                            .length,
                                                                        (index) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: TextFieldType(
                                                                                hintText: 'หมายเหตุ',
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
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Icon(
                                                                          size:
                                                                              20,
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              black6,
                                                                        ),
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              addRemark();
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'เพิ่มหมายเหตุ',
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
                                                            child: Text('No',
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
                                                              if (subJobSparePart
                                                                          .quotation ==
                                                                      '2' &&
                                                                  selectedUserId
                                                                          .value ==
                                                                      '') {
                                                                showMessage(
                                                                    'โปรดเลือก Sales');
                                                              } else {
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
                                                                          .techManageId
                                                                          .value,
                                                                      jobController
                                                                          .techLevel
                                                                          .value,
                                                                      jobController
                                                                          .handlerIdTech
                                                                          .value,
                                                                      '',
                                                                      'approve');
                                                                } else {
                                                                  await updateJobSparePart(
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
                                                                      '',
                                                                      'approve_add_sales:${selectedUserId.value}');
                                                                }

                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: Text('Yes',
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
                                            title: 'Not Approve',
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
                                                          hintText: 'Remark',
                                                          textSet:
                                                              rejectNote.value,
                                                          maxLine: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: TextStyleList
                                                              .text1,
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await updateJobSparePart(
                                                              subJobSparePart.id ??
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
                                                              rejectNote
                                                                  .value.text,
                                                              'reject');

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Yes',
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
                                      ],
                                    )
                                  : Container()
                        ],
                      )
              ],
            )),
      ],
    );
  }
}
