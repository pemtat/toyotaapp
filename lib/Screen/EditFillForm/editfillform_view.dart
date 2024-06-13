import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/rcode.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_result.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/wcode.dart';
import 'package:toyotamobile/Screen/EditFillForm/editfillform_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/EditFillForm_widget/Sparepart_widget.dart';
import 'package:toyotamobile/Widget/EditFillForm_widget/repairprodecure_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class EditFillFormView extends StatelessWidget {
  const EditFillFormView({super.key});

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
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
                backgroundColor: white3,
                title: Text('Repair Report', style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            6.kH,
            BoxContainer(
              children: [
                const TitleApp(text: 'Field Service Report'),
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
                          itemSet: fillFormController.fieldServiceReport),
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
                      moreText: getDisplayString(rcodeController.rCode)),
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
                      moreText: getDisplayString(wcodeController.wCode)),
                ),
              ],
            ),
            space.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
                    titleText: 'Repair prodecure',
                    button: AddButton(
                      onTap: () {
                        rPController.rPModal(context);
                      },
                    ),
                  ),
                  rPController.repairProcedureList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: rPController.repairProcedureList.length,
                          itemBuilder: (context, index) {
                            final part =
                                rPController.repairProcedureList[index];
                            return RepairProdecureWidget(
                              part: part,
                              index: index,
                              repairProcedureController: rPController,
                            );
                          },
                        )
                      : const SizedBox()
                ],
              ),
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                sparePartListController.sparePartList.length,
                            itemBuilder: (context, index) {
                              final part =
                                  sparePartListController.sparePartList[index];
                              return PartDetailWidget(
                                part: part,
                                index: index,
                                sparePartListController:
                                    sparePartListController,
                                additSparePartListController:
                                    additSparePartListController,
                                additional: false,
                              );
                            },
                          )
                        : const SizedBox()
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: additSparePartListController
                                .additSparePartList.length,
                            itemBuilder: (context, index) {
                              final part = additSparePartListController
                                  .additSparePartList[index];
                              return PartDetailWidget(
                                part: part,
                                index: index,
                                sparePartListController:
                                    sparePartListController,
                                additSparePartListController:
                                    additSparePartListController,
                                additional: true,
                              );
                            },
                          )
                        : const SizedBox()
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
                      moreText: getDisplayString(
                          repairResultController.repairResult)),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'Process Staff',
                      list: repairStaffController.repairStaff,
                      onTap: () =>
                          repairStaffController.repairStaffModal(context),
                      moreText:
                          getDisplayString(repairStaffController.repairStaff)),
                ),
              ],
            ),
            130.kH,
            BoxContainer(paddingCustom: 10, children: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: black3,
                    foregroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyleList.text5,
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