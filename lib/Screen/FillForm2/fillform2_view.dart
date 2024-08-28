import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm2/adddetail/additional_spare.dart';
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
import 'package:toyotamobile/Widget/listcheck_widget.dart';
import 'package:toyotamobile/Widget/FIllForm2_widget/specicgravity_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/sparepartmanage_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class FillFormView2 extends StatelessWidget {
  final String jobId;
  FillFormView2({super.key, required this.jobId}) {
    fillformController2.fetchData(jobId);
  }
  final BatteryInformation batteryInfoController =
      Get.put(BatteryInformation());
  final BatteryUsage batteryUsageController = Get.put(BatteryUsage());
  final SpecicGravity specicGravityController = Get.put(SpecicGravity());
  final CorrectiveAction correctiveActionController =
      Get.put(CorrectiveAction());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final BatteryCondition batteryConditionController =
      Get.put(BatteryCondition());
  final FillformController2 fillformController2 =
      Get.put(FillformController2());
  final ForklifeInformation forkLifeInformation =
      Get.put(ForklifeInformation());
  final RepairPM repairPmController = Get.put(RepairPM());

  @override
  Widget build(BuildContext context) {
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
            BoxContainer(
              children: [
                TextFieldWidget(
                  text: 'Customer Name',
                  textSet: fillformController2.customerName.value,
                ),
                20.kH,
                TextFieldWidget(
                  text: 'Contact Person',
                  textSet: fillformController2.contactPerson.value,
                ),
                20.kH,
                TextFieldWidget(
                  text: 'Division',
                  textSet: fillformController2.division.value,
                )
              ],
            ),
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
                        remarkSelectionChoose:
                            batteryConditionController.remarksChoose,
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
                              return SparePartManageWidget(
                                part: part,
                                index: index,
                                editFunction: () {
                                  sparePartListController
                                      .sparePartListEditModal(context, part);
                                },
                                sparePartList:
                                    sparePartListController.sparePartList,
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
                    other2: repairPmController.otherCell,
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
                              return SparePartManageWidget(
                                part: part,
                                index: index,
                                editFunction: () {
                                  additSparePartListController
                                      .additSparePartListEditModal(
                                          context, part);
                                },
                                sparePartList: additSparePartListController
                                    .additSparePartList,
                              );
                            },
                          )
                        : const SizedBox()
                  ],
                )),
            10.kH,
            BoxContainer(
              child: Obx(() {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: white3,
                          title: Center(child: Text('ผู้ตรวจซ่อม 2')),
                          titleTextStyle: TextStyleList.text1,
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: fillformController2.userByZone
                                  .map<Widget>((UsersZone user) {
                                return ListTile(
                                  title: Text(user.realname ?? 'No data'),
                                  onTap: () {
                                    fillformController2.selectedUser.value =
                                        user.realname ?? '';
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
                  child: AbsorbPointer(
                    child: TextField(
                      controller: TextEditingController(
                          text: fillformController2.selectedUser.value),
                      decoration: InputDecoration(
                          labelText: 'ผู้ตรวจซ่อม 2',
                          labelStyle: TextStyleList.text9),
                    ),
                  ),
                );
              }),
            ),
            100.kH,
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
                    context, 'Are you confirm to save report?', 'No', 'Yes');
              },
              text: 'Save'),
        ),
      ),
    );
  }
}
