import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverduejobController extends GetxController {
  final isSelected = 1.obs;

  final RxInt expandedIndex = (-2).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  var selectedDate = Rx<DateTime?>(null);
  final selectedStatus = <String>{}.obs;

  void clearFilters() {
    selectedStatus.clear();
    selectedDate.value = null;
  }
}
