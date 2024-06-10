class ServiceItem {
  final int jobId;
  final String serviceItemNo;
  final String itemNo;
  final String serialNo;
  final DateTime pmPlan;
  final DateTime actual;
  final String status;
  final String description;
  final String customerNo;
  final String customerName;
  final String shipToCode;
  final String resourceNo;
  final String resourceName;
  final String serviceZoneCode;

  ServiceItem({
    required this.jobId,
    required this.serviceItemNo,
    required this.itemNo,
    required this.serialNo,
    required this.pmPlan,
    required this.actual,
    required this.status,
    required this.description,
    required this.customerNo,
    required this.customerName,
    required this.shipToCode,
    required this.resourceNo,
    required this.resourceName,
    required this.serviceZoneCode,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      jobId: json['jobId'],
      serviceItemNo: json['serviceItemNo'],
      itemNo: json['itemNo'],
      serialNo: json['serialNo'],
      pmPlan: DateTime.parse(json['pmPlan']),
      actual: DateTime.parse(json['actual']),
      status: json['status'],
      description: json['description'],
      customerNo: json['customerNo'],
      customerName: json['customerName'],
      shipToCode: json['shipToCode'],
      resourceNo: json['resourceNo'],
      resourceName: json['resourceName'],
      serviceZoneCode: json['serviceZoneCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceItemNo': serviceItemNo,
      'itemNo': itemNo,
      'serialNo': serialNo,
      'pmPlan': pmPlan.toIso8601String(),
      'actual': actual.toIso8601String(),
      'description': description,
      'customerNo': customerNo,
      'customerName': customerName,
      'shipToCode': shipToCode,
      'resourceNo': resourceNo,
      'resourceName': resourceName,
      'serviceZoneCode': serviceZoneCode,
    };
  }
}
