import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_result.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/battery_information.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/batteryusage_widget.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/corrective_action.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/specic_gravity.dart';
import 'package:toyotamobile/Screen/FillForm2/fillform2_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/FIllForm2_widget/batteryInformation_widget.dart';
import 'package:toyotamobile/Widget/FIllForm2_widget/batteryusage_widget.dart';
import 'package:toyotamobile/Widget/FIllForm2_widget/specicgravity_widget.dart';
import 'package:toyotamobile/Widget/FillForm_widget/Sparepart_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class FillFormView2 extends StatelessWidget {
  const FillFormView2({super.key});

  @override
  Widget build(BuildContext context) {
    final BatteryInformation batteryInfoController =
        Get.put(BatteryInformation());
    final BatteryUsage batteryUsageController = Get.put(BatteryUsage());
    final SpecicGravity specicGravityController = Get.put(SpecicGravity());
    final CorrectiveAction correctiveActionController =
        Get.put(CorrectiveAction());
    final SparepartList sparePartListController = Get.put(SparepartList());
    final AdditSparepartList additSparePartListController =
        Get.put(AdditSparepartList());
    final RepairResult repairResultController = Get.put(RepairResult());
    final ProcessStaff processStaffController = Get.put(ProcessStaff());
    final FillformController2 fillformController2 =
        Get.put(FillformController2());

    int space = 8;

    return Scaffold(
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
                backgroundColor: white3,
                title: Text('Battery Maintenance Report',
                    style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            14.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
                    titleText: 'Bettery Information',
                    button: AddButton(
                      onTap: () {
                        batteryInfoController.batteryInformationModal(context);
                      },
                    ),
                  ),
                  batteryInfoController.batteryInformationList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: batteryInfoController
                              .batteryInformationList.length,
                          itemBuilder: (context, index) {
                            final info = batteryInfoController
                                .batteryInformationList[index];
                            return BatteryInfoDetailWidget(
                              info: info,
                              index: index,
                              batteryInfoController: batteryInfoController,
                            );
                          },
                        )
                      : const SizedBox()
                ],
              ),
            ),
            space.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
                    titleText: 'Bettery Usage',
                    button: AddButton(
                      onTap: () {
                        batteryUsageController.batteryUsageModal(context);
                      },
                    ),
                  ),
                  batteryUsageController.batteryUsageList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              batteryUsageController.batteryUsageList.length,
                          itemBuilder: (context, index) {
                            final info =
                                batteryUsageController.batteryUsageList[index];
                            return BatteryUsageWidget(
                              info: info,
                              index: index,
                              batteryUsageController: batteryUsageController,
                            );
                          },
                        )
                      : const SizedBox()
                ],
              ),
            ),
            space.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
                    titleText: 'Specic Gravity and Voltage Check',
                    button: AddButton(
                      onTap: () {
                        specicGravityController.specicGravityModal(context);
                      },
                    ),
                  ),
                  specicGravityController.specicGravityList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              specicGravityController.specicGravityList.length,
                          itemBuilder: (context, index) {
                            final info = specicGravityController
                                .specicGravityList[index];
                            return SpecicGravityWidget(
                              info: info,
                              index: index,
                              specicGravityController: specicGravityController,
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
                      titleText: 'Battery Condition',
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
            BoxContainer(
              children: [
                Obx(() => correctiveActionController.correctiveAction.isEmpty
                    ? AddEditBox(
                        titleText: 'Corrective Action',
                        list: correctiveActionController.correctiveAction,
                        onTap: () => correctiveActionController
                            .correctiveActionModal(context, 'add'),
                        moreText: getDisplayString3(
                            correctiveActionController.correctiveAction),
                        other: correctiveActionController.other,
                      )
                    : AddEditBox(
                        titleText: 'Corrective Action',
                        list: correctiveActionController.correctiveAction,
                        onTap: () => correctiveActionController
                            .correctiveActionModal(context, 'edit'),
                        moreText: getDisplayString3(
                            correctiveActionController.correctiveAction),
                        other: correctiveActionController.other,
                      )),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'Repair P.M Battery',
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
                      titleText: 'Action & Result / Change spare parts',
                      list: processStaffController.repairStaff,
                      onTap: () =>
                          processStaffController.repairStaffModal(context),
                      moreText:
                          getDisplayString(processStaffController.repairStaff)),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration3(),
          child: EndButton2(
              onPressed: () {
                fillformController2.showSaveDialog(
                    context,
                    'Successfully finished job on investigating!',
                    'Not yet',
                    'Yes, Completed');
              },
              text: 'Save'),
        ),
      ),
    );
  }
}
