import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SparePartController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final isSelected = 1.obs;
  Rx<String> expandedTicketId = Rx<String>('');
  var selectedDate = Rx<DateTime?>(null);
  var expandedIndex = false.obs;

  final selectedStatus = <String>{}.obs;
  void clearFilters() {
    selectedStatus.clear();
    selectedDate.value = null;
  }
}
