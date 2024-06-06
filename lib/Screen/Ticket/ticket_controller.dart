import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class TicketController extends GetxController {
  var type = 'left'.obs;
  final isSelected = false.obs;
  final RxInt expandedIndex = (-1).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  var selectedDate = Rx<DateTime?>(null);

  final selectedStatus = <String>{}.obs;
  void showAcceptDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: complete,
        );
      },
    );
  }

  void clearFilters() {
    selectedStatus.clear();
    selectedDate.value = null;
  }

  void complete() {}
}
