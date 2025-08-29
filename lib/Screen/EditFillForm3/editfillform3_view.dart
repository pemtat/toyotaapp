import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/auxiliarymotor.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/batterychecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/brakesystemchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/chargerchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/chassischeck.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/controllerlogic.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/drivemotorchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/forspecial.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/hydraulicmotor.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/initialchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/maintenance.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/mastchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/meterialhandling.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/powertrainchecks.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/ptpsos.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/safety.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/steeringmotor.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editdetail/vnaom.dart';
import 'package:toyotamobile/Screen/EditFillForm3/EditFillForm3_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_view.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
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

class EditFillFormView3 extends StatelessWidget {
  final String jobId;
  final String? readOnly;
  EditFillFormView3({super.key, required this.jobId, this.readOnly}) {
    fillformController3.fetchData(jobId, readOnly);
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 160,
                      child: ButtonRed(
                          title: context.tr('load_customer'),
                          onTap: () {
                            fetchPmTruckById(
                                fillformController3.jobId.value,
                                fillformController3.product,
                                fillformController3.serialNo,
                                fillformController3.model,
                                fillformController3.customerName);
                          }),
                    )
                  ],
                ),
                10.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('customer_name'),
                        textSet: fillformController3.customerName.value,
                        readOnly: 'yes',
                      ),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('department'),
                        textSet: fillformController3.department.value,
                        readOnly: readOnly == null ? null : 'yes',
                      ),
                    ),
                  ],
                ),
                20.kH,
                TextFieldWidget(
                  text: context.tr('contacted_name'),
                  textSet: fillformController3.contactedName.value,
                  readOnly: readOnly == null ? null : 'yes',
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        text: 'Product',
                        textSet: fillformController3.product.value,
                        readOnly: 'yes',
                      ),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                        text: 'Model',
                        textSet: fillformController3.model.value,
                        readOnly: 'yes',
                      ),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        text: context.tr('operation_hour'),
                        textSet: fillformController3.operationHour.value,
                        readOnly: readOnly == null ? null : 'yes',
                        required: true,
                      ),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                        text: 'Serial No',
                        textSet: fillformController3.serialNo.value,
                        readOnly: 'yes',
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
                TextFieldWidget(
                  text: context.tr('customer_fleet_no'),
                  textSet: fillformController3.customerFleetNo.value,
                  readOnly: readOnly == null ? null : 'yes',
                )
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
                    button: readOnly == null
                        ? Obx(() => !initialChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  initialChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => initialChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !chassisChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  chassisChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => chassisChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
                        additionalControllers:
                            chassisChecks.additionalControllers,
                        selection: chassisChecks.selections,
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
                    button: readOnly == null
                        ? Obx(() => !hydraulicmMotor.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  hydraulicmMotor.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => hydraulicmMotor.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: hydraulicmMotor.selections,
                        remarkSelection: hydraulicmMotor.remarks,
                        remarkSelectionChoose: hydraulicmMotor.remarksChoose,
                        listSelection: hydraulicmMotor.ListData,
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
                    button: readOnly == null
                        ? Obx(() => !steeringMotor.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  steeringMotor.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => steeringMotor.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !auxiliaryMotor.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  auxiliaryMotor.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => auxiliaryMotor.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !driveMotorChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  driveMotorChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => driveMotorChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: breakSystemChecks.selections,
                        additionalControllers:
                            breakSystemChecks.additionalControllers,
                        remarkSelection: breakSystemChecks.remarks,
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
                    button: readOnly == null
                        ? Obx(() => !controllerLogic.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  controllerLogic.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => controllerLogic.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !powertrainChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  powertrainChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => powertrainChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !batteryChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  batteryChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => batteryChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        subControllers1: batteryChecks.subControllers1,
                        subControllers2: batteryChecks.subControllers2,
                        additionalControllers:
                            batteryChecks.additionalControllers,
                        readOnly: readOnly == null ? null : 'yes',
                        selection: batteryChecks.selections,
                        remarkSelection: batteryChecks.remarks,
                        remarkSelectionChoose: batteryChecks.remarksChoose,
                        listSelection: batteryChecks.ListData,
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
                    button: readOnly == null
                        ? Obx(() => !chargerChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  chargerChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => chargerChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
                        selection: chargerChecks.selections,
                        remarkSelection: chargerChecks.remarks,
                        remarkSelectionChoose: chargerChecks.remarksChoose,
                        listSelection: chargerChecks.ListData,
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
                    button: readOnly == null
                        ? Obx(() => !meterialHandling.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  meterialHandling.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => meterialHandling.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !mastChecks.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  mastChecks.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => mastChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !ptPsOm.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  ptPsOm.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => ptPsOm.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !vnaOm.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  vnaOm.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => vnaOm.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                    button: readOnly == null
                        ? Obx(() => !forSpecial.isAllFieldsFilled.value
                            ? AddButton(
                                onTap: () {
                                  forSpecial.checkModal(context);
                                },
                              )
                            : Container())
                        : Container()),
                Obx(() => forSpecial.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        readOnly: readOnly == null ? null : 'yes',
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
                                          child:
                                              Text(context.tr('inspector_2'))),
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
                                                fillformController3
                                                        .selectedUser.value =
                                                    user.realname ?? '';
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          }).toList(),
                                        )),
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
                fillformController3.checkFormCompletion() == true
                    ? fillformController3.showSaveDialog(
                        context,
                        context.tr('save_message'),
                        context.tr('no'),
                        context.tr('yes'))
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialogNotOperationHour();
                        },
                      );
              },
              text: context.tr('save')),
        ),
      ),
    );
  }
}
