import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';

final HomeController jobController = Get.put(HomeController());

Future<void> refresh() async {
  await Future.delayed(const Duration(seconds: 1));
  jobController.fetchDataFromAssignJob();
}
