import 'package:toyotamobile/Models/subjobsparepart_model.dart';

bool checkEmptySparePart(
  List<Sparepart> sparePart,
  List<Sparepart> additionalSparePart,
  List<Sparepart> btrSparePart,
  List<Sparepart> pvtSparePart,
  List<Sparepart> pvtIcSparePart,
) {
  final filteredSparepart = sparePart.isNotEmpty
      ? sparePart.where((item) => item.quantity != '0').toList()
      : sparePart;
  final filteredAdditionalSparepart = additionalSparePart.isNotEmpty
      ? additionalSparePart.where((item) => item.quantity != '0').toList()
      : additionalSparePart;
  final filteredBtrSparepart = btrSparePart.isNotEmpty
      ? btrSparePart.where((item) => item.quantity != '0').toList()
      : btrSparePart;
  final filteredPvtSparepart = pvtSparePart.isNotEmpty
      ? pvtSparePart.where((item) => item.quantity != '0').toList()
      : pvtSparePart;
  final filteredPvtIcSparepart = pvtIcSparePart.isNotEmpty
      ? pvtIcSparePart.where((item) => item.quantity != '0').toList()
      : pvtIcSparePart;

  if (filteredSparepart.isEmpty &&
      filteredAdditionalSparepart.isEmpty &&
      filteredBtrSparepart.isEmpty &&
      filteredPvtSparepart.isEmpty &&
      filteredPvtIcSparepart.isEmpty) {
    return true;
  }

  return false;
}
