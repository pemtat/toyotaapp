class SparePartModel {
  String cCodePage;
  String partNumber;
  String partDetails;
  int quantity;
  String? changeNow;
  String? changeOnPM;
  String unitMeasure;
  int additional;
  String? relationId;
  SparePartModel({
    required this.cCodePage,
    required this.partNumber,
    required this.partDetails,
    required this.quantity,
    required this.unitMeasure,
    this.changeNow,
    this.changeOnPM,
    required this.additional,
    this.relationId,
  });
  Map<String, dynamic> toJson() {
    return {
      'relation_id': "",
      'c_code': cCodePage,
      'part_number': partNumber,
      'description': partDetails,
      'quantity': quantity.toString(),
      'unit_of_measure': unitMeasure,
      'change_now': changeNow,
      'change_on_pm': changeOnPM,
      'additional': additional,
    };
  }
}
