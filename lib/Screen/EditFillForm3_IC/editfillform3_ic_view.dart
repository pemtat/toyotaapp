import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/chargerchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/enginechecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/fuelcell.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/hydraulic.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/maintenance.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/motorcheck.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/powertrans.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/safety.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/safetychecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editdetail/steering.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editfillform3_ic_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_view.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_widget.dart';
import 'package:toyotamobile/Widget/listcheck_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/listcheck_widget_ic.dart';
import 'package:toyotamobile/Widget/maintenance_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/sparepartmanage_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class EditFillFormView3IC extends StatelessWidget {
  final String jobId;
  final String? readOnly;
  EditFillFormView3IC({super.key, required this.jobId, this.readOnly}) {
    fillformController3.fetchData(jobId, readOnly);
  }
  final EngineChecks engineChecks = Get.put(EngineChecks());
  final SteeringChecks steeringChecks = Get.put(SteeringChecks());
  final MotorChecks motorChecks = Get.put(MotorChecks());
  final PowerTransChecks powerTransChecks = Get.put(PowerTransChecks());
  final BrakeSystemChecks breakSystemChecks = Get.put(BrakeSystemChecks());
  final Safety safety = Get.put(Safety());
  final SparepartList sparepartList = Get.put(SparepartList());
  final ProcessStaff processStaff = Get.put(ProcessStaff());
  final HydraulicChecks hydraulicChecks = Get.put(HydraulicChecks());
  final Maintenance maintenance = Get.put(Maintenance());
  final SafetyChecks safetyChecks = Get.put(SafetyChecks());
  final FuelCell fuelCell = Get.put(FuelCell());

  final FillformController3IC fillformController3 =
      Get.put(FillformController3IC());
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
                title: Text(context.tr('pm_report_ic'),
                    style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxContainer(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('customer_name'),
                        textSet: fillformController3.customerName.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('contacted_name'),
                        textSet: fillformController3.contactedName.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                  ],
                ),
                20.kH,
                TextFieldWidget(
                  text: context.tr('service_type'),
                  textSet: fillformController3.serviceType.value,
                  readOnly: readOnly == null ? null : 'yes',
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        text: 'Model',
                        textSet: fillformController3.model.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                        text: 'Serial',
                        textSet: fillformController3.model.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('mast_type'),
                        textSet: fillformController3.mastType.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('lift_height'),
                        textSet: fillformController3.lifeHeight.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('chassis_no'),
                        textSet: fillformController3.chassisNo.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('operation_hour'),
                        textSet: fillformController3.operationHour.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            14.kH,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('✓ = ปกติ(Normal)', style: TextStyleList.text11),
                      Text('X = รอซ่อม (Waiting)', style: TextStyleList.text11)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('— = ไม่ตรวจสอบ (Unchecked)',
                          style: TextStyleList.text11),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('O = ให้วงกลมในข้อความในวงเล็บที่เกิดปัญหา',
                          style: TextStyleList.text11)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ø = ให้ทำในข้อความในวงเล็บที่ได้รับการแก้ไขแล้ว',
                          style: TextStyleList.text11),
                    ],
                  ),
                ],
              ),
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('motor_checks'),
                    button: readOnly == null
                        ? Obx(() => !motorChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  motorChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => motorChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: motorChecks.selections,
                        remarkSelection: motorChecks.remarks,
                        remarkSelectionChoose: motorChecks.remarksChoose,
                        listSelection: motorChecks.ListData,
                        showModal: motorChecks.checkModal,
                        show: motorChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('engine_checks'),
                    button: readOnly == null
                        ? Obx(() => !engineChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  engineChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => engineChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: engineChecks.selections,
                        remarkSelection: engineChecks.remarks,
                        remarkSelectionChoose: engineChecks.remarksChoose,
                        listSelection: engineChecks.ListData,
                        showModal: engineChecks.checkModal,
                        show: engineChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('power_trans_system'),
                    button: readOnly == null
                        ? Obx(() => !powerTransChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  powerTransChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => powerTransChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: powerTransChecks.selections,
                        remarkSelection: powerTransChecks.remarks,
                        remarkSelectionChoose: powerTransChecks.remarksChoose,
                        listSelection: powerTransChecks.ListData,
                        showModal: powerTransChecks.checkModal,
                        show: powerTransChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('steering_system'),
                    button: readOnly == null
                        ? Obx(() => !steeringChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  steeringChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => steeringChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: steeringChecks.selections,
                        remarkSelection: steeringChecks.remarks,
                        remarkSelectionChoose: steeringChecks.remarksChoose,
                        listSelection: steeringChecks.ListData,
                        showModal: steeringChecks.checkModal,
                        show: steeringChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('brake_system'),
                    button: readOnly == null
                        ? Obx(() => !breakSystemChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  breakSystemChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => breakSystemChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: breakSystemChecks.selections,
                        remarkSelection: breakSystemChecks.remarks,
                        remarkSelectionChoose: breakSystemChecks.remarksChoose,
                        listSelection: breakSystemChecks.ListData,
                        showModal: breakSystemChecks.checkModal,
                        show: breakSystemChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('hydraulic_system'),
                    button: readOnly == null
                        ? Obx(() => !hydraulicChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  hydraulicChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => hydraulicChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: hydraulicChecks.selections,
                        remarkSelection: hydraulicChecks.remarks,
                        remarkSelectionChoose: hydraulicChecks.remarksChoose,
                        listSelection: hydraulicChecks.ListData,
                        showModal: hydraulicChecks.checkModal,
                        show: hydraulicChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('safety_system'),
                    button: readOnly == null
                        ? Obx(() => !safetyChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  safetyChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => safetyChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: safetyChecks.selections,
                        remarkSelection: safetyChecks.remarks,
                        remarkSelectionChoose: safetyChecks.remarksChoose,
                        listSelection: safetyChecks.ListData,
                        showModal: safetyChecks.checkModal,
                        show: safetyChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('fuel_cell'),
                    button: readOnly == null
                        ? Obx(() => !fuelCell.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  fuelCell.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => fuelCell.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: fuelCell.selections,
                        remarkSelection: fuelCell.remarks,
                        remarkSelectionChoose: fuelCell.remarksChoose,
                        listSelection: fuelCell.ListData,
                        showModal: fuelCell.checkModal,
                        show: fuelCell.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('safety_maintenance'),
                    button: readOnly == null
                        ? Obx(() => !safety.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  safety.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => safety.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: safety.selections,
                        remarkSelection: safety.remarks,
                        remarkSelectionChoose: safety.remarksChoose,
                        listSelection: safety.ListData,
                        showModal: safety.checkModal,
                        show: safety.isAllFieldsFilled,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            Obx(() => BoxContainer(
                  children: [
                    TitleWithButton(
                        titleText: context.tr('pm_sparepart'),
                        button: AddButton(
                          onTap: () {
                            sparepartList.sparePartListModal(context);
                          },
                        )),
                    sparepartList.sparePartList.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sparepartList.sparePartList.length,
                            itemBuilder: (context, index) {
                              final part = sparepartList.sparePartList[index];
                              return SparePartManageWidget(
                                  part: part,
                                  index: index,
                                  editFunction: () {
                                    sparepartList.sparePartListEditModal(
                                        context, part);
                                  },
                                  sparePartList: sparepartList.sparePartList);
                            },
                          )
                        : const SizedBox(),
                    Obx(
                      () =>
                          fillformController3.sparePartRemark.value.text.isEmpty
                              ? RemarkButton(
                                  title: '+ ${context.tr('add_remark')}',
                                  onTap: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillformController3.sparePartRemark,
                                        context.tr('spare_part_remark'));
                                  },
                                  backgroundColor: black3,
                                )
                              : SparePartRemarkShow(
                                  remark: fillformController3.sparePartRemark,
                                  editFunction: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillformController3.sparePartRemark,
                                        context.tr('spare_part_remark'));
                                  },
                                ),
                    ),
                  ],
                )),
            space.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
                      required: 'yes',
                      titleText: context.tr('maintenance_service'),
                      button: readOnly == null
                          ? maintenance.maintenanceList.isEmpty
                              ? AddButton(
                                  onTap: () {
                                    maintenance.batteryUsageModal(context);
                                  },
                                )
                              : Container()
                          : Container()),
                  maintenance.maintenanceList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: maintenance.maintenanceList.length,
                          itemBuilder: (context, index) {
                            final info = maintenance.maintenanceList[index];
                            return MaintenanceShowWidget(
                              readOnly: readOnly,
                              info: info,
                              index: index,
                              editFunction: () {
                                maintenance.batteryUsageModalEditModal(
                                    context, info);
                              },
                              maintenanceList: maintenance.maintenanceList,
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
                Obx(
                  () => AddEditBox(
                      readOnly: readOnly == null ? null : 'yes',
                      titleText: context.tr('process_staff'),
                      list: processStaff.repairStaff,
                      onTap: () => processStaff.repairStaffModal(context),
                      moreText: getDisplayString(processStaff.repairStaff)),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return GestureDetector(
                        onTap: () {
                          if (readOnly == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: white3,
                                  title: Center(
                                      child: Text(context.tr('inspector_2'))),
                                  titleTextStyle: TextStyleList.text1,
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: fillformController3.userByZone
                                          .map<Widget>((UsersZone user) {
                                        return ListTile(
                                          title:
                                              Text(user.realname ?? 'No data'),
                                          onTap: () {
                                            fillformController3.selectedUser
                                                .value = user.realname ?? '';
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                                text: fillformController3.selectedUser.value),
                            decoration: InputDecoration(
                                labelText: context.tr('inspector_2'),
                                labelStyle: TextStyleList.text9),
                          ),
                        ),
                      );
                    }),
                  ),
                  if (readOnly == null)
                    Obx(() {
                      if (fillformController3.selectedUser.value != '') {
                        return InkWell(
                          onTap: () {
                            fillformController3.selectedUser.value = '';
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
                fillformController3.showSaveDialog(
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
