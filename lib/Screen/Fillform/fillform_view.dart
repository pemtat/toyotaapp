import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/rcode.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/repairprocedure.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/repairresult.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/wcode.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class FillFormView extends StatelessWidget {
  const FillFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final Rcode rcodeController = Get.put(Rcode());
    final Wcode wcodeController = Get.put(Wcode());
    final RepairProcedure rPController = Get.put(RepairProcedure());
    final SparepartList sparePartListController = Get.put(SparepartList());
    final AdditSparepartList additSparePartListController =
        Get.put(AdditSparepartList());
    final RepairResult repairResultController = Get.put(RepairResult());
    final RepairStaff repairStaffController = Get.put(RepairStaff());

    final FillformController fillFormController = Get.put(FillformController());
    int space = 8;

    return Scaffold(
      backgroundColor: backgroundapp,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Column(
          children: [
            AppBar(
                backgroundColor: buttontextcolor,
                title: Text('Repair Report', style: TextStyleList.topbar),
                leading: CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            6.kH,
            BoxContainer(
              children: [
                TitleApp(text: 'Field Service Report'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: fillFormController.fieldServiceReportList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CheckBoxWidget(
                          text:
                              fillFormController.fieldServiceReportList[index],
                          listItem: fillFormController.fieldServiceReport,
                          itemSet: (label) =>
                              fillFormController.fieldService(label)),
                    );
                  },
                ),
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                TextFieldWidget(
                    text: 'Fault', textSet: fillFormController.fault.value),
                20.kH,
                TextFieldWidget(
                    text: 'Error Code',
                    textSet: fillFormController.errorCode.value),
                20.kH,
                TextFieldWidget(
                    text: 'Work Order Number(Order No.)',
                    textSet: fillFormController.workorderNumber.value)
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'R Code',
                      list: rcodeController.rCode,
                      onTap: () => rcodeController.rCodeModal(context),
                      moreText: rcodeController.getDisplayString()),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'W Code',
                      list: wcodeController.wCode,
                      onTap: () => wcodeController.wCodeModal(context),
                      moreText: wcodeController.getDisplayString()),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'Repair prodecure',
                  button: AddButton(
                    onTap: () {
                      rPController.rPModal(context);
                    },
                  ),
                ),
              ],
            ),
            space.kH,
            Obx(() => BoxContainer(
                  children: [
                    TitleWithButton(
                      titleText: 'Spare part list',
                      button: AddButton(
                        onTap: () {
                          sparePartListController.sparePartListModal(context);
                        },
                      ),
                    ),
                    sparePartListController.sparePartList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                sparePartListController.sparePartList.length,
                            itemBuilder: (context, index) {
                              final part =
                                  sparePartListController.sparePartList[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxText(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'C-Code/Page',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.cCodePage,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Part Name',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.partNumber,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Part Details(Description)',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.partDetails,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Quantity',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            "${part.quantity}",
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Change Now',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.changeNow,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Change on Pm',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.changeOnPM,
                                            style: TextStyleList.detail2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 16,
                                      right: 16,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          popupMenuTheme: PopupMenuThemeData(
                                            color: buttontextcolor,
                                          ),
                                        ),
                                        child: PopupMenuButton(
                                          offset: Offset(0, 30),
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry>[
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: Text(
                                                'Edit',
                                                style: TextStyleList.subdetail,
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Text('Delete',
                                                  style:
                                                      TextStyleList.subdetail),
                                            ),
                                          ],
                                          child: Image.asset(
                                            'assets/boxedit.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              sparePartListController
                                                  .sparePartListEditModal(
                                                      context, part);
                                            } else if (value == 'delete') {
                                              sparePartListController
                                                  .sparePartList
                                                  .removeAt(index);
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : SizedBox()
                  ],
                )),
            space.kH,
            Obx(() => BoxContainer(
                  children: [
                    TitleWithButton(
                      titleText: 'Additional spare part list',
                      button: AddButton(
                        onTap: () {
                          additSparePartListController
                              .additSparePartListModal(context);
                        },
                      ),
                    ),
                    additSparePartListController.additSparePartList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: additSparePartListController
                                .additSparePartList.length,
                            itemBuilder: (context, index) {
                              final part = additSparePartListController
                                  .additSparePartList[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxText(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'C-Code/Page',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.cCodePage,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Part Name',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.partNumber,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Part Details(Description)',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.partDetails,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Quantity',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            "${part.quantity}",
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Change Now',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.changeNow,
                                            style: TextStyleList.detail2,
                                          ),
                                          Text(
                                            'Change on Pm',
                                            style: TextStyleList.detail3,
                                          ),
                                          Text(
                                            part.changeOnPM,
                                            style: TextStyleList.detail2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 16,
                                      right: 16,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          popupMenuTheme: PopupMenuThemeData(
                                            color: buttontextcolor,
                                          ),
                                        ),
                                        child: PopupMenuButton(
                                          offset: Offset(0, 30),
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry>[
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: Text(
                                                'Edit',
                                                style: TextStyleList.subdetail,
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Text('Delete',
                                                  style:
                                                      TextStyleList.subdetail),
                                            ),
                                          ],
                                          child: Image.asset(
                                            'assets/boxedit.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              additSparePartListController
                                                  .additSparePartListEditModal(
                                                      context, part);
                                            } else if (value == 'delete') {
                                              additSparePartListController
                                                  .additSparePartList
                                                  .removeAt(index);
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : SizedBox()
                  ],
                )),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'Repair Result',
                      list: repairResultController.repairResult,
                      onTap: () =>
                          repairResultController.repairResultModal(context),
                      moreText: repairResultController.getDisplayString()),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'Repair Staff',
                      list: repairStaffController.repairStaff,
                      onTap: () =>
                          repairStaffController.repairStaffModal(context),
                      moreText: repairStaffController.getDisplayString()),
                ),
              ],
            ),
            130.kH,
            BoxContainer(paddingCustom: 10, children: [
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: buttonsave,
                    foregroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyleList.buttontext3,
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
