import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PMCompleteJobsController extends GetxController {
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
