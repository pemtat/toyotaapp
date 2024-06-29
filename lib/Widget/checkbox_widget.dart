import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class CheckBoxWidget extends StatelessWidget {
  final String text;
  final RxList<String> listItem;
  final RxList<String> itemSet;
  const CheckBoxWidget({
    super.key,
    required this.text,
    required this.listItem,
    required this.itemSet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            updateCheckbox(text, itemSet);
          },
          child: Obx(
            () => Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: !listItem.contains(text)
                    ? Border.all(color: Colors.grey)
                    : Border.all(color: Colors.transparent),
                color:
                    listItem.contains(text) ? Colors.red : Colors.transparent,
              ),
              child: Center(
                child: listItem.contains(text)
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : const SizedBox(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyleList.text9),
        ),
      ],
    );
  }
}

class CheckBoxWidget2 extends StatelessWidget {
  final String text;
  final RxList<String> listItem;
  final RxList<String> itemSet;
  final RxList<String>? moreItemSet;
  final List<String> optionList;
  final List<String>? moreOptionList;
  final bool? more;
  final Rx<TextEditingController>? description;
  const CheckBoxWidget2(
      {super.key,
      required this.text,
      required this.listItem,
      required this.itemSet,
      required this.optionList,
      required this.description,
      this.more,
      this.moreItemSet,
      this.moreOptionList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(text, style: TextStyleList.subtitle3),
            if (more != null && moreItemSet != null && moreOptionList != null)
              Expanded(
                child: SingleCheckBoxWidget2(
                  itemSet: moreItemSet!,
                  optionList: moreOptionList!,
                ),
              ),
          ],
        ),
        8.kH,
        Column(
          children: optionList.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      updateCheckbox2(item, itemSet);
                    },
                    child: Obx(
                      () => Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: !listItem.contains(item)
                              ? Border.all(color: Colors.grey)
                              : Border.all(color: Colors.transparent),
                          color: listItem.contains(item)
                              ? Colors.red
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: listItem.contains(item)
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 18)
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(item, style: TextStyleList.text9),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        4.kH,
        if (description != null)
          TextFieldWidget(text: 'Description', textSet: description!.value),
        6.kH,
      ],
    );
  }
}

class SingleCheckBoxWidget2 extends StatelessWidget {
  final RxList<String> itemSet;
  final List<String> optionList;
  const SingleCheckBoxWidget2({
    super.key,
    required this.itemSet,
    required this.optionList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Row(
        children: optionList.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    updateCheckbox2(item, itemSet);
                  },
                  child: Obx(
                    () => Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: !itemSet.contains(item)
                            ? Border.all(color: Colors.grey)
                            : Border.all(color: Colors.transparent),
                        color: itemSet.contains(item)
                            ? Colors.red
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: itemSet.contains(item)
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 18)
                            : const SizedBox(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(item, style: TextStyleList.text9),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ignore: camel_case_types
class buildCheckbox extends StatelessWidget {
  final String status;
  final RxSet<String> selectedStatus;

  const buildCheckbox({
    super.key,
    required this.status,
    required this.selectedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = selectedStatus.contains(status);
      return Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              if (value != null && value) {
                selectedStatus.add(status);
              } else {
                selectedStatus.remove(status);
              }
            },
          ),
          Text(
            status.capitalizeFirst!,
            style: isSelected ? TextStyleList.text9 : null,
          ),
        ],
      );
    });
  }
}

class CheckBoxList extends StatelessWidget {
  final RxList<String> selectionsChoose;
  final int index;
  final String text;
  const CheckBoxList(
      {super.key,
      required this.selectionsChoose,
      required this.index,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            Checkbox(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              activeColor: red1,
              value: selectionsChoose[index] == text,
              onChanged: (value) {
                if (value == true) {
                  updateSelection(index, text, selectionsChoose);
                }
              },
            ),
            5.kH,
            Text(
              text,
              style: TextStyleList.text9,
            ),
          ],
        ));
  }
}
