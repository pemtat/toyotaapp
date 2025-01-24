import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/auxiliarymotor.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/batterychecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/chargerchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/chassischeck.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/controllerlogic.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/drivemotorchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/forspecial.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/hydraulicmotor.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/initialchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/maintenance.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/mastchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/meterialhandling.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/powertrainchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/ptpsos.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/safety.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/steeringmotor.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/vnaom.dart';
import 'package:toyotamobile/Screen/FillForm3/fillform3_controller.dart';
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
import 'package:toyotamobile/Widget/maintenance_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/sparepartmanage_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class FillFormView3 extends StatelessWidget {
  final String jobId;
  FillFormView3({super.key, required this.jobId}) {
    fillformController3.fetchData(jobId);
  }
  final AuxiliaryMotor auxiliaryMotor = Get.put(AuxiliaryMotor());
  final DriveMotorChecks driveMotorChecks = Get.put(DriveMotorChecks());
  final InitialChecks initialChecks = Get.put(InitialChecks());
  final BatteryChecks batteryChecks = Get.put(BatteryChecks());
  final MeterialHandling meterialHandling = Get.put(MeterialHandling());
  final MastChecks mastChecks = Get.put(MastChecks());
  final PtPsOm ptPsOm = Get.put(PtPsOm());
  final VnaOm vnaOm = Get.put(VnaOm());
  final ForSpecial forSpecial = Get.put(ForSpecial());
  final Safety safety = Get.put(Safety());
  final SparepartList sparepartList = Get.put(SparepartList());
  final ProcessStaff processStaff = Get.put(ProcessStaff());
  final PowertrainChecks powertrainChecks = Get.put(PowertrainChecks());
  final BreakSystemChecks breakSystemChecks = Get.put(BreakSystemChecks());
  final ChassisChecks chassisChecks = Get.put(ChassisChecks());
  final HydraulicmMotor hydraulicmMotor = Get.put(HydraulicmMotor());
  final ControllerLogic controllerLogic = Get.put(ControllerLogic());
  final ChargerChecks chargerChecks = Get.put(ChargerChecks());
  final Maintenance maintenance = Get.put(Maintenance());

  final FillformController3 fillformController3 =
      Get.put(FillformController3());
  final SteeringMotor steeringMotor = Get.put(SteeringMotor());
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
                title:
                    Text(context.tr('pm_report'), style: TextStyleList.title1),
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
                          textSet: fillformController3.customerName.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: context.tr('department'),
                          textSet: fillformController3.department.value),
                    ),
                  ],
                ),
                20.kH,
                TextFieldWidget(
                    text: context.tr('contacted_name'),
                    textSet: fillformController3.contactedName.value),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Product',
                          textSet: fillformController3.product.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Model',
                          textSet: fillformController3.model.value),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: context.tr('operation_hour'),
                          textSet: fillformController3.operationHour.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Serial No',
                          textSet: fillformController3.serialNo.value),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: context.tr('mast_type'),
                          textSet: fillformController3.mastType.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: context.tr('lift_height'),
                          textSet: fillformController3.lifeHeight.value),
                    ),
                  ],
                ),
                20.kH,
                TextFieldWidget(
                    text: context.tr('customer_fleet_no'),
                    textSet: fillformController3.customerFleetNo.value)
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
                      Text('I = ตรวจสอบ (Inspection)',
                          style: TextStyleList.text11),
                      Text('H = ฟังเสียง(Hearing)', style: TextStyleList.text11)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('L = หล่อลื่น(Lubrication)',
                          style: TextStyleList.text11),
                      Text('M = วัดค่า(Measurement)',
                          style: TextStyleList.text11)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('T = ขันแน่น(Tighten)', style: TextStyleList.text11),
                      Text('W = ทำความสะอาด(Washing)',
                          style: TextStyleList.text11)
                    ],
                  ),
                ],
              ),
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('intial_checks'),
                    button: Obx(() => !initialChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              initialChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => initialChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: initialChecks.selections,
                        remarkSelection: initialChecks.remarks,
                        remarkSelectionChoose: initialChecks.remarksChoose,
                        listSelection: initialChecks.ListData,
                        showModal: initialChecks.checkModal,
                        show: initialChecks.isAllFieldsFilled,
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('chassis_checks'),
                    button: Obx(() => !chassisChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              chassisChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => chassisChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: chassisChecks.selections,
                        additionalControllers:
                            chassisChecks.additionalControllers,
                        remarkSelection: chassisChecks.remarks,
                        remarkSelectionChoose: chassisChecks.remarksChoose,
                        listSelection: chassisChecks.ListData,
                        showModal: chassisChecks.checkModal,
                        show: chassisChecks.isAllFieldsFilled,
                        additional: chassisChecks.additional,
                        additionalChoose: chassisChecks.additionalChoose,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('hydraulic_checks'),
                    button: Obx(() => !hydraulicmMotor.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              hydraulicmMotor.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => hydraulicmMotor.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: hydraulicmMotor.selections,
                        remarkSelection: hydraulicmMotor.remarks,
                        listSelection: hydraulicmMotor.ListData,
                        remarkSelectionChoose: hydraulicmMotor.remarksChoose,
                        showModal: hydraulicmMotor.checkModal,
                        show: hydraulicmMotor.isAllFieldsFilled,
                        additional: hydraulicmMotor.additional,
                        additionalChoose: hydraulicmMotor.additionalChoose,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('steering_checks'),
                    button: Obx(() => !steeringMotor.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              steeringMotor.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => steeringMotor.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: steeringMotor.selections,
                        remarkSelection: steeringMotor.remarks,
                        remarkSelectionChoose: steeringMotor.remarksChoose,
                        listSelection: steeringMotor.ListData,
                        showModal: steeringMotor.checkModal,
                        show: steeringMotor.isAllFieldsFilled,
                        additional: steeringMotor.additional,
                        additionalChoose: steeringMotor.additionalChoose,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('auxiliary_checks'),
                    button: Obx(() => !auxiliaryMotor.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              auxiliaryMotor.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => auxiliaryMotor.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: auxiliaryMotor.selections,
                        remarkSelection: auxiliaryMotor.remarks,
                        remarkSelectionChoose: auxiliaryMotor.remarksChoose,
                        listSelection: auxiliaryMotor.ListData,
                        showModal: auxiliaryMotor.checkModal,
                        show: auxiliaryMotor.isAllFieldsFilled,
                        additional: auxiliaryMotor.additional,
                        additionalChoose: auxiliaryMotor.additionalChoose,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('drive_checks'),
                    button: Obx(() => !driveMotorChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              driveMotorChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => driveMotorChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: driveMotorChecks.selections,
                        remarkSelection: driveMotorChecks.remarks,
                        remarkSelectionChoose: driveMotorChecks.remarksChoose,
                        listSelection: driveMotorChecks.ListData,
                        showModal: driveMotorChecks.checkModal,
                        show: driveMotorChecks.isAllFieldsFilled,
                        additional: driveMotorChecks.additional,
                        additionalChoose: driveMotorChecks.additionalChoose,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('brake_checks'),
                    button: Obx(() => !breakSystemChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              breakSystemChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => breakSystemChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: breakSystemChecks.selections,
                        remarkSelection: breakSystemChecks.remarks,
                        additionalControllers:
                            breakSystemChecks.additionalControllers,
                        remarkSelectionChoose: breakSystemChecks.remarksChoose,
                        listSelection: breakSystemChecks.ListData,
                        showModal: breakSystemChecks.checkModal,
                        show: breakSystemChecks.isAllFieldsFilled,
                        additional: breakSystemChecks.additional,
                        additionalChoose: breakSystemChecks.additionalChoose,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('controller_checks'),
                    button: Obx(() => !controllerLogic.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              controllerLogic.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => controllerLogic.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: controllerLogic.selections,
                        remarkSelection: controllerLogic.remarks,
                        remarkSelectionChoose: controllerLogic.remarksChoose,
                        listSelection: controllerLogic.ListData,
                        showModal: controllerLogic.checkModal,
                        show: controllerLogic.isAllFieldsFilled,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('powertrain_checks'),
                    button: Obx(() => !powertrainChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              powertrainChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => powertrainChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: powertrainChecks.selections,
                        remarkSelection: powertrainChecks.remarks,
                        remarkSelectionChoose: powertrainChecks.remarksChoose,
                        listSelection: powertrainChecks.ListData,
                        showModal: powertrainChecks.checkModal,
                        show: powertrainChecks.isAllFieldsFilled,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('battery_checks'),
                    button: Obx(() => !batteryChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              batteryChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => batteryChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        subControllers1: batteryChecks.subControllers1,
                        subControllers2: batteryChecks.subControllers2,
                        selection: batteryChecks.selections,
                        remarkSelection: batteryChecks.remarks,
                        listSelection: batteryChecks.ListData,
                        additionalControllers:
                            batteryChecks.additionalControllers,
                        remarkSelectionChoose: batteryChecks.remarksChoose,
                        showModal: batteryChecks.checkModal,
                        show: batteryChecks.isAllFieldsFilled,
                        additional: batteryChecks.additional,
                        additional2: batteryChecks.additional2,
                        additionalChoose: batteryChecks.additionalChoose,
                        additionalChoose2: batteryChecks.additionalChoose2,
                        unitList: batteryChecks.unitList,
                        unit: 's.g.',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('charger_checks'),
                    button: Obx(() => !chargerChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              chargerChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => chargerChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: chargerChecks.selections,
                        remarkSelection: chargerChecks.remarks,
                        listSelection: chargerChecks.ListData,
                        remarkSelectionChoose: chargerChecks.remarksChoose,
                        showModal: chargerChecks.checkModal,
                        show: chargerChecks.isAllFieldsFilled,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('meterial_checks'),
                    button: Obx(() => !meterialHandling.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              meterialHandling.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => meterialHandling.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: meterialHandling.selections,
                        remarkSelection: meterialHandling.remarks,
                        remarkSelectionChoose: meterialHandling.remarksChoose,
                        listSelection: meterialHandling.ListData,
                        showModal: meterialHandling.checkModal,
                        show: meterialHandling.isAllFieldsFilled,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('mast_checks'),
                    button: Obx(() => !mastChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              mastChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => mastChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        additionalControllers: mastChecks.additionalControllers,
                        subControllers1: mastChecks.subControllers1,
                        subControllers2: mastChecks.subControllers2,
                        selection: mastChecks.selections,
                        remarkSelection: mastChecks.remarks,
                        remarkSelectionChoose: mastChecks.remarksChoose,
                        listSelection: mastChecks.ListData,
                        showModal: mastChecks.checkModal,
                        show: mastChecks.isAllFieldsFilled,
                        additional: mastChecks.additional,
                        additional2: mastChecks.additional2,
                        additionalChoose: mastChecks.additionalChoose,
                        additionalChoose2: mastChecks.additionalChoose2,
                        unitList: mastChecks.unitList,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('mhe'),
                    button: Obx(() => !ptPsOm.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              ptPsOm.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => ptPsOm.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        additionalControllers: ptPsOm.additionalControllers,
                        selection: ptPsOm.selections,
                        remarkSelection: ptPsOm.remarks,
                        remarkSelectionChoose: ptPsOm.remarksChoose,
                        listSelection: ptPsOm.ListData,
                        showModal: ptPsOm.checkModal,
                        show: ptPsOm.isAllFieldsFilled,
                        additional: ptPsOm.additional,
                        additionalChoose: ptPsOm.additionalChoose,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('vna_om_checks'),
                    button: Obx(() => !vnaOm.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              vnaOm.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => vnaOm.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        additionalControllers: vnaOm.additionalControllers,
                        selection: vnaOm.selections,
                        remarkSelection: vnaOm.remarks,
                        remarkSelectionChoose: vnaOm.remarksChoose,
                        listSelection: vnaOm.ListData,
                        showModal: vnaOm.checkModal,
                        show: vnaOm.isAllFieldsFilled,
                        additional: vnaOm.additional,
                        additionalChoose: vnaOm.additionalChoose,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('for_special'),
                    button: Obx(() => !forSpecial.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              forSpecial.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => forSpecial.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: forSpecial.selections,
                        remarkSelection: forSpecial.remarks,
                        remarkSelectionChoose: forSpecial.remarksChoose,
                        listSelection: forSpecial.ListData,
                        showModal: forSpecial.checkModal,
                        show: forSpecial.isAllFieldsFilled,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: context.tr('safety_maintenance'),
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
                      titleText: context.tr('process_staff'),
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
                              TextEditingController searchController =
                                  TextEditingController();

                              RxList<UsersZone> filteredUsers =
                                  RxList<UsersZone>(
                                      fillformController3.userByZone);

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
                                            fillformController3.userByZone
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
                                              fillformController3.selectedUser
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
                                text: fillformController3.selectedUser.value),
                            decoration: InputDecoration(
                                labelText: context.tr('inspector_2'),
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
