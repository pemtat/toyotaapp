import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/userbyzone_model.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/process_staff.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/rcode.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_procedure.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/repair_result.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditFillForm/editdetail/wcode.dart';
import 'package:toyotamobile/Screen/EditFillForm/editfillform_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/EditFillForm_widget/repairprodecure_widget.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_view.dart';
import 'package:toyotamobile/Widget/SparePartRemark_widget/sparepart_remark_widget.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/maintenance_widget.dart';
import 'package:toyotamobile/Widget/required_text_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/sparepartmanage_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

// ignore: must_be_immutable
class EditFillFormView extends StatelessWidget {
  final String reportId;
  final String ticketId;
  final String jobId;
  final String? readOnly;
  final bool? partDisable;
  EditFillFormView(
      {super.key,
      required this.reportId,
      required this.ticketId,
      required this.jobId,
      this.readOnly,
      this.partDisable}) {
    fillFormController.fetchForm(
        reportId, ticketId, jobId, readOnly, partDisable);
  }

  final Rcode rcodeController = Get.put(Rcode());
  final Wcode wcodeController = Get.put(Wcode());
  final RepairProcedure rPController = Get.put(RepairProcedure());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final RepairResult repairResultController = Get.put(RepairResult());
  final RepairStaff repairStaffController = Get.put(RepairStaff());
  final EditFillformController fillFormController =
      Get.put(EditFillformController());
  final JobDetailController jobController = Get.put(JobDetailController());

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
                title: Text(context.tr('field_service_report'),
                    style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: Obx(
        () {
          if (fillFormController.reportList.isEmpty) {
            return const Center(child: CircleLoading());
          }
          return SingleChildScrollView(
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
                      itemCount:
                          fillFormController.fieldServiceReportList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CheckBoxWidget(
                              option: 'true',
                              readOnly: readOnly == null ? null : 'yes',
                              text: fillFormController
                                  .fieldServiceReportList[index],
                              listItem: fillFormController.fieldServiceReport,
                              itemSet: fillFormController.fieldServiceReport),
                        );
                      },
                    ),
                  ],
                ),
                14.kH,
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
                                fetchJobTruckById(
                                    fillFormController.ticketId.value,
                                    fillFormController.product,
                                    fillFormController.serialNo,
                                    fillFormController.model,
                                    fillFormController.customerName,
                                    fillFormController.contactedName);
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
                            textSet: fillFormController.customerName.value,
                            readOnly: 'yes',
                          ),
                        ),
                        10.wH,
                        Expanded(
                          child: TextFieldWidget(
                            text: context.tr('department'),
                            textSet: fillFormController.department.value,
                            readOnly: readOnly == null ? null : 'yes',
                          ),
                        ),
                      ],
                    ),
                    20.kH,
                    TextFieldWidget(
                      text: context.tr('contacted_name'),
                      textSet: fillFormController.contactedName.value,
                      readOnly: readOnly == null ? null : 'yes',
                    ),
                    20.kH,
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            text: 'Product',
                            textSet: fillFormController.product.value,
                            readOnly: 'yes',
                          ),
                        ),
                        10.wH,
                        Expanded(
                          child: TextFieldWidget(
                            text: 'Model',
                            textSet: fillFormController.model.value,
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
                            textSet: fillFormController.operationHour.value,
                            readOnly: readOnly == null ? null : 'yes',
                            required: true,
                          ),
                        ),
                        10.wH,
                        Expanded(
                          child: TextFieldWidget(
                            text: 'Serial No',
                            textSet: fillFormController.serialNo.value,
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
                            textSet: fillFormController.mastType.value,
                            readOnly: readOnly == null ? null : 'yes',
                          ),
                        ),
                        10.wH,
                        Expanded(
                          child: TextFieldWidget(
                            text: context.tr('lift_height'),
                            textSet: fillFormController.lifeHeight.value,
                            readOnly: readOnly == null ? null : 'yes',
                          ),
                        ),
                      ],
                    ),
                    20.kH,
                    TextFieldWidget(
                      text: context.tr('customer_fleet_no'),
                      textSet: fillFormController.customerFleetNo.value,
                      readOnly: readOnly == null ? null : 'yes',
                    )
                  ],
                ),
                14.kH,
                BoxContainer(
                  children: [
                    TextFieldWidget(
                        text: context.tr('fault'),
                        textSet: fillFormController.fault.value,
                        readOnly: readOnly == null ? null : 'yes'),
                    20.kH,
                    TextFieldWidget(
                      text: 'Error Code',
                      textSet: fillFormController.errorCode.value,
                      readOnly: readOnly == null ? null : 'yes',
                    ),
                    // 20.kH,
                    // TextFieldWidget(
                    //   text: 'Work Order Number(Order No.)',
                    //   textSet: fillFormController.workorderNumber.value,
                    //   readOnly: readOnly == null ? null : 'yes',
                    // )
                  ],
                ),
                14.kH,
                BoxContainer(
                  children: [
                    Obx(
                      () => AddEditBox(
                          required: 'yes',
                          readOnly: readOnly == null ? null : 'yes',
                          titleText: 'R Code',
                          list: rcodeController.rCode,
                          onTap: () => rcodeController.rCodeModal(context),
                          moreText: getTranslateText(
                              rcodeController.rCode, context, 'rCode')),
                    ),
                  ],
                ),
                space.kH,
                BoxContainer(
                  children: [
                    Obx(
                      () => AddEditBox(
                          required: 'yes',
                          readOnly: readOnly == null ? null : 'yes',
                          titleText: 'W Code',
                          list: wcodeController.wCode,
                          onTap: () => wcodeController.wCodeModal(context),
                          moreText: getTranslateText(
                              wcodeController.wCode, context, 'wCode')),
                    ),
                  ],
                ),
                space.kH,
                Obx(
                  () => BoxContainer(
                    children: [
                      TitleWithButton(
                          required: 'yes',
                          titleText: context.tr('repair_prodecure'),
                          button: readOnly == null
                              ? rPController.repairProcedureList.isEmpty
                                  ? AddButton(
                                      onTap: () {
                                        rPController.rPModal(context);
                                      },
                                    )
                                  : Container()
                              : Container()),
                      rPController.repairProcedureList.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  rPController.repairProcedureList.length,
                              itemBuilder: (context, index) {
                                final part =
                                    rPController.repairProcedureList[index];
                                return RepairProdecureWidget(
                                  readOnly: readOnly == null ? null : 'yes',
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
                Obx(() => BoxContainer(
                      children: [
                        TitleWithButton(
                          titleText: context.tr('spare_part_list'),
                          button: partDisable == true
                              ? Container()
                              : AddButton(
                                  onTap: () {
                                    sparePartListController
                                        .sparePartListModal(context);
                                  },
                                ),
                        ),
                        sparePartListController.sparePartList.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: sparePartListController
                                    .sparePartList.length,
                                itemBuilder: (context, index) {
                                  final part = sparePartListController
                                      .sparePartList[index];
                                  return SparePartManageWidget(
                                    part: part,
                                    index: index,
                                    readOnly:
                                        partDisable == true ? 'yes' : null,
                                    editFunction: () {
                                      sparePartListController
                                          .sparePartListEditModal(
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
                          () => fillFormController
                                  .sparePartRemark.value.text.isEmpty
                              ? RemarkButton(
                                  title: '+ ${context.tr('add_remark')}',
                                  onTap: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillFormController.sparePartRemark,
                                        context.tr('spare_part_remark'));
                                  },
                                  backgroundColor: black3,
                                )
                              : SparePartRemarkShow(
                                  remark: fillFormController.sparePartRemark,
                                  editFunction: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillFormController.sparePartRemark,
                                        context.tr('spare_part_remark'));
                                  },
                                ),
                        ),
                      ],
                    )),
                space.kH,
                Obx(() => BoxContainer(
                      children: [
                        TitleWithButton(
                          titleText: context.tr('additional_spare_part_list'),
                          button: AddButton(
                            onTap: () {
                              additSparePartListController
                                  .additSparePartListModal(context);
                            },
                          ),
                        ),
                        additSparePartListController
                                .additSparePartList.isNotEmpty
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
                                  title: '+ ${context.tr('add_remark')}',
                                  onTap: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillFormController
                                            .additionalSparePartRemark,
                                        context.tr(
                                            'additional_spare_part_remark'));
                                  },
                                  backgroundColor: black3,
                                )
                              : SparePartRemarkShow(
                                  remark: fillFormController
                                      .additionalSparePartRemark,
                                  editFunction: () {
                                    sparePartRemarkEditModal(
                                        context,
                                        fillFormController
                                            .additionalSparePartRemark,
                                        context.tr(
                                            'additional_spare_part_remark'));
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
                          titleText: context.tr('repair_result'),
                          button: repairResultController.maintenanceList.isEmpty
                              ? readOnly == null
                                  ? AddButton(
                                      onTap: () {
                                        repairResultController
                                            .repairResultModal(context);
                                      },
                                    )
                                  : Container()
                              : Container()),
                      repairResultController.maintenanceList.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  repairResultController.maintenanceList.length,
                              itemBuilder: (context, index) {
                                final info = repairResultController
                                    .maintenanceList[index];
                                return MaintenanceShowWidget(
                                  readOnly: readOnly,
                                  info: info,
                                  index: index,
                                  editFunction: () {
                                    repairResultController
                                        .repairResultEditModal(context, info);
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
                          titleText: context.tr('process_staff'),
                          readOnly: readOnly == null ? null : 'yes',
                          list: repairStaffController.repairStaff,
                          onTap: () =>
                              repairStaffController.repairStaffModal(context),
                          moreText: getDisplayString(
                              repairStaffController.repairStaff)),
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
                                            fillFormController.userByZone);

                                    return AlertDialog(
                                      backgroundColor: white3,
                                      title: Column(
                                        children: [
                                          Center(
                                              child: Text(
                                                  context.tr('inspector_2'))),
                                          10.kH,
                                          TextField(
                                            controller: searchController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  context.tr('search_name'),
                                              prefixIcon: Icon(Icons.search),
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (query) {
                                              filteredUsers.value =
                                                  fillFormController.userByZone
                                                      .where((user) =>
                                                          user.realname !=
                                                              null &&
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
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width: 300,
                                        child: Obx(() => ListView(
                                              children: filteredUsers
                                                  .map<Widget>(
                                                      (UsersZone user) {
                                                return ListTile(
                                                  title: Text(user.realname ??
                                                      'No data'),
                                                  onTap: () {
                                                    fillFormController
                                                            .selectedUser
                                                            .value =
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
                                    text:
                                        fillFormController.selectedUser.value),
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
                100.kH,
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration2(),
          child: EndButton(
              onPressed: () {
                fillFormController.checkFormCompletion() == true ||
                        readOnly != null
                    ? fillFormController.showSavedDialog(
                        context,
                        context.tr('save_message'),
                        context.tr('no'),
                        context.tr('yes'),
                        partDisable)
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialogNotComplete();
                        },
                      );
              },
              text: context.tr('save')),
        ),
      ),
    );
  }
}
