class SparePartModel {
  String cCodePage;
  String partNumber;
  String partDetails;
  int quantity;
  String? changeNow;
  String? changeOnPM;
  String unitMeasure;
  String salesPrice;
  String priceVat;
  int additional;
  String? relationId;
  SparePartModel({
    required this.cCodePage,
    required this.partNumber,
    required this.partDetails,
    required this.quantity,
    required this.unitMeasure,
    required this.salesPrice,
    required this.priceVat,
    this.changeNow,
    this.changeOnPM,
    required this.additional,
    this.relationId,
  });
  Map<String, dynamic> toJson() {
    var price = double.tryParse(salesPrice) ?? 0.0;
    return {
      'relation_id': "",
      'c_code': cCodePage,
      'part_number': partNumber,
      'description': partDetails,
      'quantity': quantity.toString(),
      'unit_of_measure': unitMeasure,
      'price': price,
      'price_includes_vat': priceVat == '1' ? 1 : 0,
      'change_now': changeNow,
      'change_on_pm': changeOnPM,
      'additional': additional,
    };
  }
}
