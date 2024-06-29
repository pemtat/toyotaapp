import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/fillform.dart';
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
import 'package:toyotamobile/Widget/FIllForm3_widget/maintenance_widget.dart';
import 'package:toyotamobile/Widget/FIllForm3_widget/sparepart_widget.dart';
import 'package:toyotamobile/Widget/FIllForm3_widget/listcheck_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class FillFormView3 extends StatelessWidget {
  const FillFormView3({super.key});

  @override
  Widget build(BuildContext context) {
    final AuxiliaryMotor auxiliaryMotor = Get.put(AuxiliaryMotor());
    final DriveMotorChecks driveMotorChecks = Get.put(DriveMotorChecks());
    Get.put(SparepartList());

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

    int space = 8;

    return Scaffold(
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
                backgroundColor: white3,
                title: Text('Periodic Maintenance Report',
                    style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    titleText: 'Intial Checks',
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
                    titleText: 'Chassis Checks',
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
                        remarkSelection: chassisChecks.remarks,
                        listSelection: chassisChecks.ListData,
                        showModal: chassisChecks.checkModal,
                        show: chassisChecks.isAllFieldsFilled,
                        additional: chassisChecks.additional,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: 'Hydraulic motor & Punp Checks',
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
                        showModal: hydraulicmMotor.checkModal,
                        show: hydraulicmMotor.isAllFieldsFilled,
                        additional: hydraulicmMotor.additional,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText:
                        'Steering Motor & Hydraulic steering\nsystem checks (CBE)',
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
                        listSelection: steeringMotor.ListData,
                        showModal: steeringMotor.checkModal,
                        show: steeringMotor.isAllFieldsFilled,
                        additional: steeringMotor.additional,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: 'Auxiliary Motor Checks (Raymond)',
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
                        listSelection: auxiliaryMotor.ListData,
                        showModal: auxiliaryMotor.checkModal,
                        show: auxiliaryMotor.isAllFieldsFilled,
                        additional: auxiliaryMotor.additional,
                        unit: '',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: 'Drive Motor Checks',
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
                        listSelection: driveMotorChecks.ListData,
                        showModal: driveMotorChecks.checkModal,
                        show: driveMotorChecks.isAllFieldsFilled,
                        additional: driveMotorChecks.additional,
                        unit: '',
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
                    ? ListChecksWidget(
                        selection: breakSystemChecks.selections,
                        remarkSelection: breakSystemChecks.remarks,
                        listSelection: breakSystemChecks.ListData,
                        showModal: breakSystemChecks.checkModal,
                        show: breakSystemChecks.isAllFieldsFilled,
                        additional: breakSystemChecks.additional,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: 'Controller, Logic Box Checks',
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
                    titleText: 'Powertrain Checks',
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
                    titleText: 'Battery Checks',
                    button: Obx(() => !batteryChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              batteryChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => batteryChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: batteryChecks.selections,
                        remarkSelection: batteryChecks.remarks,
                        listSelection: batteryChecks.ListData,
                        showModal: batteryChecks.checkModal,
                        show: batteryChecks.isAllFieldsFilled,
                        additional: batteryChecks.additional,
                        additional2: batteryChecks.additional2,
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
                    titleText: 'Charger Checks',
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
                    titleText: 'Meterial Handling System Checks',
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
                    titleText: 'Mast Checks',
                    button: Obx(() => !mastChecks.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              mastChecks.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => mastChecks.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: mastChecks.selections,
                        remarkSelection: mastChecks.remarks,
                        listSelection: mastChecks.ListData,
                        showModal: mastChecks.checkModal,
                        show: mastChecks.isAllFieldsFilled,
                        additional: mastChecks.additional,
                        additional2: mastChecks.additional2,
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
                    titleText: 'PT/PS เเละ OS / List for MHE class 3',
                    button: Obx(() => !ptPsOm.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              ptPsOm.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => ptPsOm.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: ptPsOm.selections,
                        remarkSelection: ptPsOm.remarks,
                        listSelection: ptPsOm.ListData,
                        showModal: ptPsOm.checkModal,
                        show: ptPsOm.isAllFieldsFilled,
                        additional: ptPsOm.additional,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: "VNA เเละ OM / List for VNA & OME model",
                    button: Obx(() => !vnaOm.isAllFieldsFilled.value
                        ? AddButton(
                            onTap: () {
                              vnaOm.checkModal(context);
                            },
                          )
                        : Container())),
                Obx(() => vnaOm.isAllFieldsFilled.value
                    ? ListChecksWidget(
                        selection: vnaOm.selections,
                        remarkSelection: vnaOm.remarks,
                        listSelection: vnaOm.ListData,
                        showModal: vnaOm.checkModal,
                        show: vnaOm.isAllFieldsFilled,
                        additional: vnaOm.additional,
                        unit: 'mm',
                      )
                    : const SizedBox())
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                    titleText: "For Special equipment",
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
                    titleText: "Safty",
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
                        button: sparepartList.sparePartList.length < 8
                            ? AddButton(
                                onTap: () {
                                  sparepartList.sparePartListModal(context);
                                },
                              )
                            : Container()),
                    sparepartList.sparePartList.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sparepartList.sparePartList.length,
                            itemBuilder: (context, index) {
                              final part = sparepartList.sparePartList[index];
                              return PartDetailWidget2(
                                part: part,
                                index: index,
                                sparePartListController: sparepartList,
                                additional: false,
                              );
                            },
                          )
                        : const SizedBox()
                  ],
                )),
            space.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
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
                            return MaintenanceWidget(
                              info: info,
                              index: index,
                              batteryUsageController: maintenance,
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
            space.kH,
            BoxContainer(
              children: [
                Container(
                    height: 200,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: SfSignaturePad(
                        key: fillformController3.signature,
                        onDrawEnd: fillformController3.saveSignature,
                        backgroundColor: Colors.white,
                        strokeColor: Colors.black,
                        minimumStrokeWidth: 1.0,
                        maximumStrokeWidth: 4.0)),
                10.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: fillformController3.clearSignature,
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
                    textSet: fillformController3.signatureController),
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
                fillformController3.showSaveDialog(
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
