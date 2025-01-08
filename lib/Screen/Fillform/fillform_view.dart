import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/additional_spare.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/process_staff.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/rcode.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_result.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/wcode.dart';
import 'package:toyotamobile/Screen/FillForm/fillform_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/FillForm_widget/repairprodecure_widget.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_view.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/maintenance_widget.dart';
import 'package:toyotamobile/Widget/required_text_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/sparepartmanage_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FillFormView extends StatelessWidget {
  final String ticketId;
  final String jobId;
  FillFormView({super.key, required this.ticketId, required this.jobId}) {
    fillFormController.fetchData(ticketId, jobId);
  }

  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  final ProcessStaff processStaffController = Get.put(ProcessStaff());
  final FillformController fillFormController = Get.put(FillformController());
  int space = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
                backgroundColor: white3,
                title:
                    Text('Field Service Report', style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            6.kH,
            BoxContainer(
              children: [
                const RequiredTextLong(
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: fillFormController.fieldServiceReportList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CheckBoxWidget(
                        text: fillFormController.fieldServiceReportList[index],
                        listItem: fillFormController.fieldServiceReport,
                        itemSet: fillFormController.fieldServiceReport,
                        option: 'true',
                      ),
                    );
                  },
                ),
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Customer Name',
                          textSet: fillFormController.customerName.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Department',
                          textSet: fillFormController.department.value),
                    ),
                  ],
                ),
                20.kH,
                TextFieldWidget(
                    text: 'Contacted Name',
                    textSet: fillFormController.contactedName.value),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Product',
                          textSet: fillFormController.product.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Model',
                          textSet: fillFormController.model.value),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Operation Hour',
                          textSet: fillFormController.operationHour.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Serial No',
                          textSet: fillFormController.serialNo.value),
                    ),
                  ],
                ),
                20.kH,
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Mast Type',
                          textSet: fillFormController.mastType.value),
                    ),
                    10.wH,
                    Expanded(
                      child: TextFieldWidget(
                          text: 'Lift Height',
                          textSet: fillFormController.lifeHeight.value),
                    ),
                  ],
                ),
                20.kH,
                TextFieldWidget(
                    text: 'Customer Fleet No.',
                    textSet: fillFormController.customerFleetNo.value)
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                TextFieldWidget(
                    text: 'Fault', textSet: fillFormController.fault.value),
                20.kH,
                TextFieldWidget(
                    text: 'Error Code',
                    textSet: fillFormController.errorCode.value),
                // 20.kH,
                // TextFieldWidget(
                //     text: 'Work Order Number(Order No.)',
                //     textSet: fillFormController.workorderNumber.value)
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      required: 'yes',
                      titleText: 'R Code',
                      list: rcodeController.rCode,
                      onTap: () => rcodeController.rCodeModal(context),
                      moreText: getDisplayString(rcodeController.rCode)),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      required: 'yes',
                      titleText: 'W Code',
                      list: wcodeController.wCode,
                      onTap: () => wcodeController.wCodeModal(context),
                      moreText: getDisplayString(wcodeController.wCode)),
                ),
              ],
            ),
            space.kH,
            Obx(
              () => BoxContainer(
                children: [
                  TitleWithButton(
                      required: 'yes',
                      titleText: 'Repair prodecure',
                      button: rPController.repairProcedureList.isEmpty
                          ? AddButton(
                              onTap: () {
                                rPController.rPModal(context);
                              },
                            )
                          : Container()),
                  rPController.repairProcedureList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: rPController.repairProcedureList.length,
                          itemBuilder: (context, index) {
                            final part =
                                rPController.repairProcedureList[index];
                            return RepairProdecureWidget(
                              part: part,
                              index: index,
                              repairProcedureController: rPController,
                            );
                          },
                        )
                      : const SizedBox()
                ],
              ),
            ),
            space.kH,
            Obx(() => BoxContainer(children: [
                  TitleWithButton(
                    titleText: 'Spare part list',
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
                            return SparePartManageWidget(
                              part: part,
                              index: index,
                              editFunction: () {
                                sparePartListController.sparePartListEditModal(
                                    context, part);
                              },
                              sparePartList:
                                  sparePartListController.sparePartList,
                              changeShow: 'yes',
                            );
                          },
                        )
                      : const SizedBox(),
                  Obx(
                    () => fillFormController.sparePartRemark.value.text.isEmpty
                        ? RemarkButton(
                            title: '+ เพิ่มหมายเหตุ',
                            onTap: () {
                              sparePartRemarkEditModal(
                                  context,
                                  fillFormController.sparePartRemark,
                                  'Spare Part Remark');
                            },
                            backgroundColor: black3,
                          )
                        : SparePartRemarkShow(
                            remark: fillFormController.sparePartRemark,
                            editFunction: () {
                              sparePartRemarkEditModal(
                                  context,
                                  fillFormController.sparePartRemark,
                                  'Spare Part Remark');
                            },
                          ),
                  ),
                ])),
            space.kH,
            Obx(() => BoxContainer(
                  children: [
                    TitleWithButton(
                      titleText: 'Additional spare part list',
                      button: AddButton(
                        onTap: () {
                          additSparePartListController
                              .additSparePartListModal(context);
                        },
                      ),
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
                                changeShow: 'yes',
                              );
                            },
                          )
                        : const SizedBox(),
                    Obx(
                      () => fillFormController
                              .additionalSparePartRemark.value.text.isEmpty
                          ? RemarkButton(
                              title: '+ เพิ่มหมายเหตุ',
                              onTap: () {
                                sparePartRemarkEditModal(
                                    context,
                                    fillFormController
                                        .additionalSparePartRemark,
                                    'Additional Spare Part Remark');
                              },
                              backgroundColor: black3,
                            )
                          : SparePartRemarkShow(
                              remark:
                                  fillFormController.additionalSparePartRemark,
                              editFunction: () {
                                sparePartRemarkEditModal(
                                    context,
                                    fillFormController
                                        .additionalSparePartRemark,
                                    'Additional Spare Part Remark');
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
                      titleText: 'Repair Result',
                      button: repairResultController.maintenanceList.isEmpty
                          ? AddButton(
                              onTap: () {
                                repairResultController
                                    .repairResultModal(context);
                              },
                            )
                          : Container()),
                  repairResultController.maintenanceList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              repairResultController.maintenanceList.length,
                          itemBuilder: (context, index) {
                            final info =
                                repairResultController.maintenanceList[index];
                            return MaintenanceShowWidget(
                              info: info,
                              index: index,
                              editFunction: () {
                                repairResultController.repairResultEditModal(
                                    context, info);
                              },
                              maintenanceList:
                                  repairResultController.maintenanceList,
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
                      list: processStaffController.repairStaff,
                      onTap: () =>
                          processStaffController.repairStaffModal(context),
                      moreText:
                          getDisplayString(processStaffController.repairStaff)),
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
                                    children: fillFormController.userByZone
                                        .map<Widget>((UsersZone user) {
                                      return ListTile(
                                        title: Text(user.realname ?? 'No data'),
                                        onTap: () {
                                          fillFormController.selectedUser
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
                                text: fillFormController.selectedUser.value),
                            decoration: InputDecoration(
                                labelText: 'ผู้ตรวจซ่อม 2',
                                labelStyle: TextStyleList.text9),
                          ),
                        ),
                      );
                    }),
                  ),
                  Obx(() {
                    if (fillFormController.selectedUser.value != '') {
                      return InkWell(
                        onTap: () {
                          fillFormController.selectedUser.value = '';
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
            80.kH,
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration2(),
          child: EndButton(
              onPressed: () {
                fillFormController.checkFormCompletion() == true
                    ? fillFormController.showSavedDialog(
                        context, 'Are you confirm to save report?', 'No', 'Yes')
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialogNotComplete();
                        },
                      );
              },
              text: 'Save'),
        ),
      ),
    );
  }
}
