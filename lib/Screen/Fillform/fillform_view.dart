import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/rcode.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_result.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/wcode.dart';
import 'package:toyotamobile/Screen/FillForm/fillform_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/FillForm_widget/Sparepart_widget.dart';
import 'package:toyotamobile/Widget/FillForm_widget/repairprodecure_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FillFormView extends StatelessWidget {
  final String ticketId;
  final String jobId;
  FillFormView({super.key, required this.ticketId, required this.jobId}) {
    fillFormController.fetchData(ticketId, jobId);
  }

  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  final ProcessStaff processStaffController = Get.put(ProcessStaff());
  final FillformController fillFormController = Get.put(FillformController());
  int space = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
                backgroundColor: white3,
                title:
                    Text('Field Service Report', style: TextStyleList.title1),
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: fillFormController.fieldServiceReportList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CheckBoxWidget(
                        text: fillFormController.fieldServiceReportList[index],
                        listItem: fillFormController.fieldServiceReport,
                        itemSet: fillFormController.fieldServiceReport,
                        option: 'true',
                      ),
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
                      button: rPController.repairProcedureList.isEmpty
                          ? AddButton(
                              onTap: () {
                                rPController.rPModal(context);
                              },
                            )
                          : Container()),
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
                      other: repairResultController.other,
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
                      list: processStaffController.repairStaff,
                      onTap: () =>
                          processStaffController.repairStaffModal(context),
                      moreText:
                          getDisplayString(processStaffController.repairStaff)),
                ),
              ],
            ),
            80.kH,
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration2(),
          child: EndButton(
              onPressed: () {
                fillFormController.showSavedDialog(
                    context, 'Are you confirm to save report?', 'No', 'Yes');
              },
              text: 'Save'),
        ),
      ),
    );
  }
}
