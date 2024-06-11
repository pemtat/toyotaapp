import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Styles/text.dart';

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
              width: 18,
              height: 18,
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
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
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
