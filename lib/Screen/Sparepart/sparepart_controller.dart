import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';

class SparePartController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final isSelected = 1.obs;
  Rx<String> expandedTicketId = Rx<String>('');
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMoreData = true;
  UserController userController = Get.put(UserController());

  RxList<SubJobSparePart> jobList = <SubJobSparePart>[].obs;
  int offset = 0;
  int limit = 10;
  var selectedDate = Rx<DateTime?>(null);
  var expandedIndex = false.obs;

  final selectedStatus = <String>{}.obs;
  void clearFilters() {
    selectedStatus.clear();
    selectedDate.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (_) => fetchJobs(reset: true),
        time: Duration(milliseconds: 500));

    ever<DateTime?>(selectedDate, (_) {
      fetchJobs(reset: true);
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        fetchJobs();
      }
    });

    // fetchJobs(reset: true);
  }

  Future<void> fetchJobs({bool reset = false}) async {
    if (reset) {
      offset = 0;
      jobList.clear();
      hasMoreData = true;
    }
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;

    try {
      await fetchSubJobSparePartPage(
        id: userController.userInfo.first.id.toString(),
        option: jobController.techLevel.value == '1' ? 'tech' : 'manager',
        subJobSparePart: jobList,
        offset: offset,
        limit: limit,
        search: searchQuery.value,
        techManagerStatus: jobController.techLevel.value != '1'
            ? getStatusFromSelectionManager(isSelected.value)
            : null,
        estimateStatus: jobController.techLevel.value == '1'
            ? getStatusFromSelection(isSelected.value)
            : null,
        createdDate: selectedDate.value != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
            : null,
      );

      if (jobList.length < limit) {
        hasMoreData = false;
      } else {
        offset += limit;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingMore = false;
    }
  }

  String getStatusFromSelection(int selected) {
    switch (selected) {
      case 1:
        return '1';
      case 2:
        return '2';
      case 3:
        return '3';
      default:
        return '1';
    }
  }

  String getStatusFromSelectionManager(int selected) {
    switch (selected) {
      case 1:
        return '0';
      case 2:
        return '1';
      case 3:
        return '2';
      default:
        return '0';
    }
  }
}
