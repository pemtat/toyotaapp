import 'package:get/get.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';

class ReturnSparepartController extends GetxController {
  final RxList<Sparepart> selectedSpareParts = <Sparepart>[].obs;
  void updateReturnNo(int index, String newValue, List<Sparepart> spareparts) {
    spareparts[index].returnNo.value = newValue;
  }
}
