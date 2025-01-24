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
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_view.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_widget.dart';
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
import 'package:toyotamobile/extensions/context_extension.dart';

class FillFormView2 extends StatelessWidget {
  final String jobId;
  final String? jobIssueId;
  FillFormView2({super.key, required this.jobId, this.jobIssueId}) {
    fillformController2.fetchData(jobId, jobIssueId);
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
                title: Text(context.tr('battery_maintenance_report'),
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
                  text: context.tr('customer_name'),
                  textSet: fillformController2.customerName.value,
                ),
                20.kH,
                TextFieldWidget(
                  text: context.tr('contact_person'),
                  textSet: fillformController2.contactPerson.value,
                ),
                20.kH,
                TextFieldWidget(
                  text: context.tr('division'),
                  textSet: fillformController2.division.value,
                )
              ],
            ),
            14.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
                    titleText: context.tr('battery_information'),
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
                      titleText: context.tr('forklift_information'),
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
                      titleText: context.tr('battery_usage'),
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
                    titleText: context.tr('specic_gravity'),
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
                    titleText: context.tr('battery_condition'),
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
                      titleText: context.tr('corrective_action'),
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
                        titleText: context.tr('bm_sparepart'),
                        button: AddButton(
                          onTap: () {
                            sparePartListController.sparePartListModal(context);
                          },
                        )),
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
                        : const SizedBox(),
                    Obx(
                      () =>
                          fillformController2.sparePartRemark.value.text.isEmpty
                              ? RemarkButton(
                                  title: '+ ${context.tr('add_remark')}',
                                  onTap: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillformController2.sparePartRemark,
                                        context.tr('spare_part_remark'));
                                  },
                                  backgroundColor: black3,
                                )
                              : SparePartRemarkShow(
                                  remark: fillformController2.sparePartRemark,
                                  editFunction: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillformController2.sparePartRemark,
                                        context.tr('spare_part_remark'));
                                  },
                                ),
                    ),
                  ],
                )),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                    titleText: context.tr('repair_pm_battery'),
                    list: repairPmController.repairPm,
                    onTap: () => repairPmController.repairPMModal(context),
                    moreText: getDisplayString(repairPmController.repairPm),
                    other: repairPmController.other,
                    other2: repairPmController.otherCell,
                  ),
                ),
              ],
            ),
            // space.kH,
            // Obx(() => BoxContainer(
            //       children: [
            //         TitleWithButton(
            //           titleText: 'Action & Result / Change spare parts',
            //           button: additSparePartListController
            //                       .additSparePartList.length <
            //                   7
            //               ? AddButton(
            //                   onTap: () {
            //                     additSparePartListController
            //                         .additSparePartListModal(context);
            //                   },
            //                 )
            //               : Container(),
            //         ),
            //         additSparePartListController.additSparePartList.isNotEmpty
            //             ? ListView.builder(
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 shrinkWrap: true,
            //                 itemCount: additSparePartListController
            //                     .additSparePartList.length,
            //                 itemBuilder: (context, index) {
            //                   final part = additSparePartListController
            //                       .additSparePartList[index];
            //                   return SparePartManageWidget(
            //                     part: part,
            //                     index: index,
            //                     editFunction: () {
            //                       additSparePartListController
            //                           .additSparePartListEditModal(
            //                               context, part);
            //                     },
            //                     sparePartList: additSparePartListController
            //                         .additSparePartList,
            //                   );
            //                 },
            //               )
            //             : const SizedBox()
            //       ],
            //     )),
            10.kH,
            BoxContainer(
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              TextEditingController searchController =
                                  TextEditingController();

                              RxList<UsersZone> filteredUsers =
                                  RxList<UsersZone>(
                                      fillformController2.userByZone);

                              return AlertDialog(
                                backgroundColor: white3,
                                title: Column(
                                  children: [
                                    Center(
                                        child: Text(context.tr('inspector_2'))),
                                    10.kH,
                                    TextField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: context.tr('search_name'),
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (query) {
                                        filteredUsers.value =
                                            fillformController2.userByZone
                                                .where((user) =>
                                                    user.realname != null &&
                                                    user.realname!
                                                        .toLowerCase()
                                                        .contains(query
                                                            .toLowerCase()))
                                                .toList();
                                      },
                                    ),
                                  ],
                                ),
                                titleTextStyle: TextStyleList.text1,
                                content: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: 300,
                                  child: Obx(() => ListView(
                                        children: filteredUsers
                                            .map<Widget>((UsersZone user) {
                                          return ListTile(
                                            title: Text(
                                                user.realname ?? 'No data'),
                                            onTap: () {
                                              fillformController2.selectedUser
                                                  .value = user.realname ?? '';
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        }).toList(),
                                      )),
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
                                labelText: context.tr('inspector_2'),
                                labelStyle: TextStyleList.text9),
                          ),
                        ),
                      );
                    }),
                  ),
                  Obx(() {
                    if (fillformController2.selectedUser.value != '') {
                      return InkWell(
                        onTap: () {
                          fillformController2.selectedUser.value = '';
                        },
                        child: Icon(Icons.close),
                      );
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
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
                    context,
                    context.tr('save_message'),
                    context.tr('no'),
                    context.tr('yes'));
              },
              text: context.tr('save')),
        ),
      ),
    );
  }
}
