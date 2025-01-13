import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/fuelcell.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/hydraulic.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/safetychecks.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/steering.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/powertrans.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/enginechecks.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/adddetail/motorcheck.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/fillform3_ic_controller.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/maintenance.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/safety.dart';
import 'package:toyotamobile/Screen/FillForm3_ic/adddetail/sparepartlist.dart';
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

class FillFormView3IC extends StatelessWidget {
  final String jobId;
  FillFormView3IC({super.key, required this.jobId}) {
    fillformController3.fetchData(jobId);
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
                title: Text('Periodic Maintenance Report IC',
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
                          text: 'Customer Name',
                          textSet: fillformController3.customerName.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Contacted Name',
                          textSet: fillformController3.contactedName.value),
                    ),
                  ],
                ),
                20.kH,
                TextFieldWidget(
                    text: 'Service Type',
                    textSet: fillformController3.serviceType.value),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Model',
                          textSet: fillformController3.model.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Serial',
                          textSet: fillformController3.model.value),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Mast Type',
                          textSet: fillformController3.mastType.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Lift Height',
                          textSet: fillformController3.lifeHeight.value),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Chassis Number',
                          textSet: fillformController3.chassisNo.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Operation Hour',
                          textSet: fillformController3.operationHour.value),
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
                    titleText: 'Motor Checks',
                    button: Obx(() => !motorChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              motorChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => motorChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: 'Engine Checks',
                    button: Obx(() => !engineChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              engineChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => engineChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: 'Power Transmission System Checks',
                    button: Obx(() => !powerTransChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              powerTransChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => powerTransChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: 'Steering System Checks',
                    button: Obx(() => !steeringChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              steeringChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => steeringChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: 'Brake System Checks',
                    button: Obx(() => !breakSystemChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              breakSystemChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => breakSystemChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: 'Hydraulic System Checks',
                    button: Obx(() => !hydraulicChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              hydraulicChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => hydraulicChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: 'Safety System Checks',
                    button: Obx(() => !safetyChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              safetyChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => safetyChecks.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: 'Fuel Cell',
                    button: Obx(() => !fuelCell.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              fuelCell.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => fuelCell.isAllFieldsFilled.value
                    ? ListChecksWidgetIc(
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
                    titleText: "Safety",
                    button: Obx(() => !safety.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              safety.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => safety.isAllFieldsFilled.value
                    ? ListChecksWidget(
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
                        titleText:
                            'Description Problem / Action and Result \nRecommend spare part chaged',
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
                                  title: '+ เพิ่มหมายเหตุ',
                                  onTap: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillformController3.sparePartRemark,
                                        'Spare Part Remark');
                                  },
                                  backgroundColor: black3,
                                )
                              : SparePartRemarkShow(
                                  remark: fillformController3.sparePartRemark,
                                  editFunction: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillformController3.sparePartRemark,
                                        'Spare Part Remark');
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
                      titleText: 'Maintenance and Service Result',
                      button: maintenance.maintenanceList.isEmpty
                          ? AddButton(
                              onTap: () {
                                maintenance.batteryUsageModal(context);
                              },
                            )
                          : Container()),
                  maintenance.maintenanceList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: maintenance.maintenanceList.length,
                          itemBuilder: (context, index) {
                            final info = maintenance.maintenanceList[index];
                            return MaintenanceShowWidget(
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
                      titleText: 'Process Staff',
                      list: processStaff.repairStaff,
                      onTap: () => processStaff.repairStaffModal(context),
                      moreText: getDisplayString(processStaff.repairStaff)),
                ),
              ],
            ),
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
                              return AlertDialog(
                                backgroundColor: white3,
                                title: Center(child: Text('ผู้ตรวจซ่อม 2')),
                                titleTextStyle: TextStyleList.text1,
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: fillformController3.userByZone
                                        .map<Widget>((UsersZone user) {
                                      return ListTile(
                                        title: Text(user.realname ?? 'No data'),
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
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                                text: fillformController3.selectedUser.value),
                            decoration: InputDecoration(
                                labelText: 'ผู้ตรวจซ่อม 2',
                                labelStyle: TextStyleList.text9),
                          ),
                        ),
                      );
                    }),
                  ),
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
                    context, 'Are you confirm to save report?', 'No', 'Yes');
              },
              text: 'Save'),
        ),
      ),
    );
  }
}
