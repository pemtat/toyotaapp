// ignore_for_file: file_names

class BatteryInformationModel {
  String batteryBand;
  String batteryModel;
  String mfgNo;
  String serialNo;
  double batteryLifespan;
  double voltage;
  double capacity;

  BatteryInformationModel({
    required this.batteryBand,
    required this.batteryModel,
    required this.mfgNo,
    required this.serialNo,
    required this.batteryLifespan,
    required this.voltage,
    required this.capacity,
  });
}
