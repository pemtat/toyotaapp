import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class TicketController extends GetxController {
  final isSelected = 1.obs;
  final RxInt expandedIndex = (-2).obs;
  final RxInt expandedIndex2 = (-2).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  var selectedDate = Rx<DateTime?>(null);
  final HomeController jobController = Get.put(HomeController());
  final selectedStatus = <String>{}.obs;
  final RxInt displayedPmItems = 10.obs;
  final ScrollController scrollController = ScrollController();
  var loading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   scrollController.addListener(_onScroll);
  //   jobController.fetchPMdataPage(1);
  // }

  // @override
  // void dispose() {
  //   scrollController.removeListener(_onScroll);
  //   scrollController.dispose();
  //   super.dispose();
  // }

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

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      jobController.loadMore();
    }
  }

  void clearFilters() {
    selectedStatus.clear();
    selectedDate.value = null;
  }

  void complete() {}
}
