class SparePartModel {
  String cCodePage;
  String partNumber;
  String partDetails;
  int quantity;
  String changeNow;
  String changeOnPM;

  SparePartModel({
    required this.cCodePage,
    required this.partNumber,
    required this.partDetails,
    required this.quantity,
    required this.changeNow,
    required this.changeOnPM,
  });
}

class BatteryModel {
  String a;
  String b;
  String c;
  String d;
  String e;
  String f;
  String g;

  BatteryModel({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.g,
  });
}
