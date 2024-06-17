class SparePartModel {
  String cCodePage;
  String partNumber;
  String partDetails;
  int quantity;
  String changeNow;
  String changeOnPM;
  int additional;

  SparePartModel({
    required this.cCodePage,
    required this.partNumber,
    required this.partDetails,
    required this.quantity,
    required this.changeNow,
    required this.changeOnPM,
    required this.additional,
  });
  Map<String, dynamic> toJson() {
    return {
      'c_code': cCodePage,
      'part_number': partNumber,
      'description': partDetails,
      'quantity': quantity.toString(),
      'change_now': changeNow,
      'change_on_pm': changeOnPM,
      'additional': additional,
    };
  }
}
