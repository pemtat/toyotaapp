import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/additional_spare.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/btr_sparepartlist.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/pvt_ic_sparepartlist.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/pvt_sparepartlist.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/sparepartlist.dart';
import 'package:toyotamobile/Screen/EditSparePart/editsparepart_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/sparepartmanage_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditSparePartView extends StatelessWidget {
  final List<Sparepart> sparepart;
  final List<Sparepart> additionalSparepart;
  final List<Sparepart> btrSparepart;
  final List<Sparepart> pvtSparepart;
  final List<Sparepart> pvtIcSparepart;
  final String jobId;
  final String bugId;
  final String projectId;
  EditSparePartView(
      {super.key,
      required this.sparepart,
      required this.additionalSparepart,
      required this.jobId,
      required this.bugId,
      required this.projectId,
      required this.btrSparepart,
      required this.pvtSparepart,
      required this.pvtIcSparepart}) {
    sparePartController.fetchForm(jobId, bugId, sparepart, additionalSparepart,
        btrSparepart, pvtSparepart, pvtIcSparepart, projectId);
  }
  final EditSparePartController sparePartController =
      Get.put(EditSparePartController());

  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());
  final SparepartList sparePartListController = Get.put(SparepartList());
  final BtrSparepartList btrSparepartList = Get.put(BtrSparepartList());
  final PvtSparepartList pvtSparepartList = Get.put(PvtSparepartList());
  final PvtIcSparepartList pvtIcSparepartList = Get.put(PvtIcSparepartList());
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
                title: Text('Edit Sparepart', style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: projectId == '1'
            ? Column(
                children: [
                  if (sparepart.isNotEmpty || additionalSparepart.isNotEmpty)
                    Obx(() => BoxContainer(
                          children: [
                            TitleWithButton(
                              titleText: 'Spare part List',
                              button: AddButton(
                                onTap: () {
                                  sparePartListController
                                      .sparePartListModal(context);
                                },
                              ),
                            ),
                            sparePartListController.sparePartList.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: sparePartListController
                                        .sparePartList.length,
                                    itemBuilder: (context, index) {
                                      final part = sparePartListController
                                          .sparePartList[index];
                                      return SparePartManageWidget(
                                        part: part,
                                        index: index,
                                        editFunction: () {
                                          sparePartListController
                                              .sparePartListEditModal(
                                                  context, part);
                                        },
                                        sparePartList: sparePartListController
                                            .sparePartList,
                                      );
                                    },
                                  )
                                : const SizedBox()
                          ],
                        )),
                  space.kH,
                  if (sparepart.isNotEmpty || additionalSparepart.isNotEmpty)
                    Obx(() => BoxContainer(
                          children: [
                            TitleWithButton(
                              titleText: 'Additional Spare Part List',
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                        sparePartList:
                                            additSparePartListController
                                                .additSparePartList,
                                      );
                                    },
                                  )
                                : const SizedBox(),
                          ],
                        )),
                  space.kH,
                  if (btrSparepart.isNotEmpty)
                    Obx(() => BoxContainer(
                          children: [
                            TitleWithButton(
                              titleText: 'Battery Spare Part List',
                              button: AddButton(
                                onTap: () {
                                  btrSparepartList.sparePartListModal(context);
                                },
                              ),
                            ),
                            btrSparepartList.btrSparePartList.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: btrSparepartList
                                        .btrSparePartList.length,
                                    itemBuilder: (context, index) {
                                      final part = btrSparepartList
                                          .btrSparePartList[index];
                                      return SparePartManageWidget(
                                        part: part,
                                        index: index,
                                        editFunction: () {
                                          btrSparepartList
                                              .sparePartListEditModal(
                                                  context, part);
                                        },
                                        sparePartList:
                                            btrSparepartList.btrSparePartList,
                                      );
                                    },
                                  )
                                : const SizedBox()
                          ],
                        )),
                  100.kH,
                ],
              )
            : Column(
                children: [
                  if (btrSparepart.isNotEmpty)
                    Obx(() => BoxContainer(
                          children: [
                            TitleWithButton(
                              titleText: 'Battery Spare Part List',
                              button: AddButton(
                                onTap: () {
                                  btrSparepartList.sparePartListModal(context);
                                },
                              ),
                            ),
                            btrSparepartList.btrSparePartList.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: btrSparepartList
                                        .btrSparePartList.length,
                                    itemBuilder: (context, index) {
                                      final part = btrSparepartList
                                          .btrSparePartList[index];
                                      return SparePartManageWidget(
                                        part: part,
                                        index: index,
                                        editFunction: () {
                                          btrSparepartList
                                              .sparePartListEditModal(
                                                  context, part);
                                        },
                                        sparePartList:
                                            btrSparepartList.btrSparePartList,
                                      );
                                    },
                                  )
                                : const SizedBox()
                          ],
                        )),
                  space.kH,
                  if (pvtSparepart.isNotEmpty)
                    Obx(() => BoxContainer(
                          children: [
                            TitleWithButton(
                              titleText: 'Periodic Spare Part List',
                              button: AddButton(
                                onTap: () {
                                  pvtSparepartList.sparePartListModal(context);
                                },
                              ),
                            ),
                            pvtSparepartList.pvtSparePartList.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: pvtSparepartList
                                        .pvtSparePartList.length,
                                    itemBuilder: (context, index) {
                                      final part = pvtSparepartList
                                          .pvtSparePartList[index];
                                      return SparePartManageWidget(
                                        part: part,
                                        index: index,
                                        editFunction: () {
                                          pvtSparepartList
                                              .sparePartListEditModal(
                                                  context, part);
                                        },
                                        sparePartList:
                                            pvtSparepartList.pvtSparePartList,
                                      );
                                    },
                                  )
                                : const SizedBox()
                          ],
                        )),
                  space.kH,
                  if (pvtIcSparepart.isNotEmpty)
                    Obx(() => BoxContainer(
                          children: [
                            TitleWithButton(
                              titleText: 'Periodic IC Spare Part List',
                              button: AddButton(
                                onTap: () {
                                  pvtIcSparepartList
                                      .sparePartListModal(context);
                                },
                              ),
                            ),
                            pvtIcSparepartList.pvtIcSparePartList.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: pvtIcSparepartList
                                        .pvtIcSparePartList.length,
                                    itemBuilder: (context, index) {
                                      final part = pvtIcSparepartList
                                          .pvtIcSparePartList[index];
                                      return SparePartManageWidget(
                                        part: part,
                                        index: index,
                                        editFunction: () {
                                          pvtIcSparepartList
                                              .sparePartListEditModal(
                                                  context, part);
                                        },
                                        sparePartList: pvtIcSparepartList
                                            .pvtIcSparePartList,
                                      );
                                    },
                                  )
                                : const SizedBox()
                          ],
                        )),
                  100.kH,
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration2(),
          child: EndButton(
              onPressed: () {
                sparePartController.showSavedDialog(
                    context, 'Are you confirm to save report?', 'No', 'Yes');
              },
              text: 'Save'),
        ),
      ),
    );
  }
}
