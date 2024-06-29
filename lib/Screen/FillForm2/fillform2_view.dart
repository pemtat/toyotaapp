import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_result.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/batterycondition.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/forklife_information.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/repairpm.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/sparepartlist.dart';
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
import 'package:toyotamobile/Widget/FIllForm2_widget/forkliftinformation_widget.dart';
import 'package:toyotamobile/Widget/FIllForm2_widget/listcheck_widget.dart';
import 'package:toyotamobile/Widget/FIllForm2_widget/sparepart_widget.dart';
import 'package:toyotamobile/Widget/FIllForm2_widget/specicgravity_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
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
    Get.put(RepairResult());
    final BatteryCondition batteryConditionController =
        Get.put(BatteryCondition());
    final FillformController2 fillformController2 =
        Get.put(FillformController2());
    final ForklifeInformation forkLifeInformation =
        Get.put(ForklifeInformation());
    final RepairPM repairPmController = Get.put(RepairPM());
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
                    button: batteryInfoController.batteryInformationList.isEmpty
                        ? AddButton(
                            onTap: () {
                              batteryInfoController
                                  .batteryInformationModal(context);
                            },
                          )
                        : Container(),
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
                      titleText: 'Forklife Information',
                      button: forkLifeInformation.forklifeList.isEmpty
                          ? AddButton(
                              onTap: () {
                                forkLifeInformation
                                    .forklifeInformationModal(context);
                              },
                            )
                          : Container()),
                  forkLifeInformation.forklifeList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: forkLifeInformation.forklifeList.length,
                          itemBuilder: (context, index) {
                            final part =
                                forkLifeInformation.forklifeList[index];
                            return ForkliftinformationWidget(
                              info: part,
                              index: index,
                              controller: forkLifeInformation,
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
                      button: batteryUsageController.batteryUsageList.isEmpty
                          ? AddButton(
                              onTap: () {
                                batteryUsageController
                                    .batteryUsageModal(context);
                              },
                            )
                          : Container()),
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
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: 'Battery Condition',
                    button: Obx(() => !batteryConditionController
                            .isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              batteryConditionController.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => batteryConditionController.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: batteryConditionController.selections,
                        remarkSelection: batteryConditionController.remarks,
                        listSelection: batteryConditionController.ListData,
                        showModal: batteryConditionController.checkModal,
                        show: batteryConditionController.isAllFieldsFilled,
                        additional: batteryConditionController.additional,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            Obx(() => BoxContainer(
                  children: [
                    AddEditBox(
                      titleText: 'Corrective Action',
                      list: correctiveActionController.correctiveAction,
                      onTap: () => correctiveActionController
                          .correctiveActionModal(context),
                      moreText: getDisplayString3(
                          correctiveActionController.correctiveAction),
                      other: correctiveActionController.other,
                    )
                  ],
                )),
            space.kH,
            Obx(() => BoxContainer(
                  children: [
                    TitleWithButton(
                        titleText: 'Recommanded spare Part',
                        button: sparePartListController.sparePartList.length < 3
                            ? AddButton(
                                onTap: () {
                                  sparePartListController
                                      .sparePartListModal(context);
                                },
                              )
                            : Container()),
                    sparePartListController.sparePartList.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                sparePartListController.sparePartList.length,
                            itemBuilder: (context, index) {
                              final part =
                                  sparePartListController.sparePartList[index];
                              return PartDetailWidget2(
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
                Obx(
                  () => AddEditBox(
                    titleText: 'Repair P.M Battery',
                    list: repairPmController.repairPm,
                    onTap: () => repairPmController.repairPMModal(context),
                    moreText: getDisplayString(repairPmController.repairPm),
                    other: repairPmController.other,
                  ),
                ),
              ],
            ),
            space.kH,
            Obx(() => BoxContainer(
                  children: [
                    TitleWithButton(
                      titleText: 'Action & Result / Change spare parts',
                      button: additSparePartListController
                                  .additSparePartList.length <
                              7
                          ? AddButton(
                              onTap: () {
                                additSparePartListController
                                    .additSparePartListModal(context);
                              },
                            )
                          : Container(),
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
                              return PartDetailWidget2(
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
            8.kH,
            BoxContainer(
              children: [
                Container(
                    height: 200,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: SfSignaturePad(
                        key: fillformController2.signature,
                        onDrawEnd: fillformController2.saveSignature,
                        backgroundColor: Colors.white,
                        strokeColor: Colors.black,
                        minimumStrokeWidth: 1.0,
                        maximumStrokeWidth: 4.0)),
                10.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: fillformController2.clearSignature,
                      child: Text(
                        'Clear',
                        style: TextStyleList.text20,
                      ),
                    ),
                  ],
                ),
                8.kH,
                TextFieldWidget(
                    text: 'ลงชื่อ',
                    textSet: fillformController2.signatureController),
              ],
            ),
            130.kH,
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration3(),
          child: EndButton(
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
