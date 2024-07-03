import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/pm_model.dart';

class PMAssignedJobsController extends GetxController {
  final RxInt expandedIndex = (-2).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final isSelected = 1.obs;

  var selectedDate = Rx<DateTime?>(null);
  final selectedStatus = <String>{}.obs;
  void clearFilters() {
    selectedStatus.clear();
    selectedDate.value = null;
  }

  var currentPage = 1.obs;
  var itemsPerPage = 10;
  // Other variables and methods...

  void nextPage() {
    currentPage.value++;
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  List<PmModel> getPagedItems(List<PmModel> items) {
    if (items.length <= itemsPerPage) {
      return items;
    }

    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, items.length);

    if (startIndex >= items.length || startIndex < 0) {
      return [];
    }

    return items.sublist(startIndex, endIndex);
  }
}
