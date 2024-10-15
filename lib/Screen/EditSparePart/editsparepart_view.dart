import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/EditSparePart/editdetail/additional_spare.dart';
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
  final String jobId;
  final String bugId;
  EditSparePartView(
      {super.key,
      required this.sparepart,
      required this.additionalSparepart,
      required this.jobId,
      required this.bugId}) {
    sparePartController.fetchForm(jobId, bugId, sparepart, additionalSparepart);
  }
  final AdditSparepartList additSparePartListController =
      Get.put(AdditSparepartList());

  final SparepartList sparePartListController = Get.put(SparepartList());
  final EditSparePartController sparePartController =
      Get.put(EditSparePartController());

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
        child: Column(
          children: [
            Obx(() => BoxContainer(
                  children: [
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
                                  sparePartListController
                                      .sparePartListEditModal(context, part);
                                },
                                sparePartList:
                                    sparePartListController.sparePartList,
                              );
                            },
                          )
                        : const SizedBox()
                  ],
                )),
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
