import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Models/subjoball.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class SubTicketController extends GetxController {
  var subJobs = <Jobs>[].obs;

  var type = 'left'.obs;
  final isSelected = false.obs;
  final RxInt expandedIndex = (-1).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  var selectedDate = Rx<DateTime?>(null);
  final selectedStatus = <String>{}.obs;
  final isLoading = false.obs;

  Future<void> fetchData(String ticketId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(getSubJobByTicketId(ticketId)),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        SubJobsAll data = SubJobsAll.fromJson(
          jsonDecode(response.body),
        );
        if (data.jobs != null) {
          subJobs.value = data.jobs!;
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
