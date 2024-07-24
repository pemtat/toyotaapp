// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class ListChecksWidget extends StatelessWidget {
  final RxList<String> selection;
  final RxList<String> remarkSelection;
  final RxList<String> remarkChooseSelection;
  final List<String> listSelection;
  final RxBool show;
  final RxList<String>? additional;
  final Function(BuildContext) showModal;
  final String? unit;

  const ListChecksWidget(
      {super.key,
      required this.selection,
      required this.remarkSelection,
      required this.remarkChooseSelection,
      required this.listSelection,
      required this.showModal,
      this.additional,
      this.unit,
      required this.show});

  @override
  Widget build(BuildContext context) {
    int space = 10;
    int space2 = 6;

    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: selection.length,
                itemBuilder: (context, index) {
                  final list = listSelection[index];

                  final part = selection[index];
                  final remark = remarkSelection[index];

                  return additional != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (part != '' ||
                                remark != '' ||
                                additional![index] != '')
                              Row(
                                children: [
                                  Text(
                                    list,
                                    style: TextStyleList.subtext1,
                                  ),
                                  if (additional![index] != '')
                                    Text(
                                      ' (${additional![index]}$unit)',
                                      style: TextStyleList.subtext7,
                                    ),
                                ],
                              ),
                            if (part != '' ||
                                remark != '' ||
                                additional![index] != '')
                              space2.kH,
                            if (part != '')
                              Text(
                                part,
                                style: TextStyleList.text15,
                              ),
                            if (part != '') space2.kH,
                            if (remark != '')
                              ShowTextFieldWidget(
                                  text: remark, hintText: remark),
                            if (remark != '') space.kH,
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (part != '' || remark != '')
                              Text(
                                list,
                                style: TextStyleList.subtext1,
                              ),
                            if (part != '' || remark != '') space2.kH,
                            if (part != '')
                              Text(
                                part,
                                style: TextStyleList.text15,
                              ),
                            if (part != '') space2.kH,
                            if (remark != '')
                              ShowTextFieldWidget(
                                  text: remark, hintText: remark),
                            if (remark != '') space.kH,
                          ],
                        );
                },
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Theme(
                data: Theme.of(context).copyWith(
                  popupMenuTheme: const PopupMenuThemeData(
                    color: white3,
                  ),
                ),
                child: PopupMenuButton(
                  offset: const Offset(0, 30),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(
                        'Edit',
                        style: TextStyleList.text9,
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyleList.text9),
                    ),
                  ],
                  child: Image.asset(
                    'assets/boxedit.png',
                    width: 24,
                    height: 24,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      showModal(context);
                    } else if (value == 'delete') {
                      selection.value =
                          List<String>.filled(selection.length, '').obs;
                      remarkSelection.value =
                          List<String>.filled(remarkSelection.length, '').obs;
                      remarkChooseSelection.value =
                          List<String>.filled(remarkChooseSelection.length, '')
                              .obs;
                      if (additional != null) {
                        additional!.value =
                            List<String>.filled(additional!.length, '').obs;
                      }
                      show.value = false;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
