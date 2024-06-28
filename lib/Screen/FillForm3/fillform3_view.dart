import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/chassischeck.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/forklife_information.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/hydraulicmotor.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/initialchecks.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/repairpm.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/batteryusage_widget.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/corrective_action.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/specic_gravity.dart';
import 'package:toyotamobile/Screen/FillForm3/adddetail/steeringmotor.dart';
import 'package:toyotamobile/Screen/FillForm3/fillform3_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/FIllForm3_widget/listcheck_widget.dart';
import 'package:toyotamobile/Widget/FIllForm3_widget/batteryusage_widget.dart';
import 'package:toyotamobile/Widget/FIllForm3_widget/forkliftinformation_widget.dart';
import 'package:toyotamobile/Widget/FIllForm3_widget/sparepart_widget.dart';
import 'package:toyotamobile/Widget/FIllForm3_widget/specicgravity_widget.dart';
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
    final BatteryUsage batteryUsageController = Get.put(BatteryUsage());
    final SpecicGravity specicGravityController = Get.put(SpecicGravity());
    final CorrectiveAction correctiveActionController =
        Get.put(CorrectiveAction());
    final SparepartList sparePartListController = Get.put(SparepartList());
    final AdditSparepartList additSparePartListController =
        Get.put(AdditSparepartList());
    final InitialChecks initialChecks = Get.put(InitialChecks());
    final ChassisChecks chassisChecks = Get.put(ChassisChecks());
    final HydraulicmMotor hydraulicmMotor = Get.put(HydraulicmMotor());
    final FillformController3 fillformController3 =
        Get.put(FillformController3());
    final SteeringMotor steeringMotor = Get.put(SteeringMotor());
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
