class BatteryUsageModel {
  double shiftTime;
  double hrsPerShift;
  double ratio;
  List<String> chargingType;

  BatteryUsageModel(
      {required this.shiftTime,
      required this.hrsPerShift,
      required this.ratio,
      required this.chargingType});
}
