import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignedjobsController extends GetxController {
  final RxInt expandedIndex = (-2).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
}