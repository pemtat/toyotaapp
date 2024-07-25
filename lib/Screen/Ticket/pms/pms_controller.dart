import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class PmsController extends GetxController {
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
  final UserController userController = Get.put(UserController());
  RxBool jobLoading = false.obs;
  var loading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await userController.fetchData();
    scrollController.addListener(onScroll);
    jobLoading.value = false;
    // jobController
    //     .fetchPMdataPage(1, userController.userInfo.first.id.toString())
    //     .whenComplete(() => jobLoading.value = false);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
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

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!loading.value) {
        loading.value = true;
        jobController
            .loadMorePM(userController.userInfo.first.id.toString())
            .whenComplete(() => loading.value = false);
      }
    }
  }

  void clearFilters() {
    selectedStatus.clear();
    selectedDate.value = null;
  }

  void complete() {}
}
