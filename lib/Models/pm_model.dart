class PmModel {
  String? serviceItemNo;
  String? itemNo;
  String? serialNo;
  String? pmPlan;
  Null actual;
  String? description;
  String? customerNo;
  String? customerName;
  Null shipToCode;
  String? resourceNo;
  String? resourceName;
  String? serviceZoneCode;

  PmModel(
      {this.serviceItemNo,
      this.itemNo,
      this.serialNo,
      this.pmPlan,
      this.actual,
      this.description,
      this.customerNo,
      this.customerName,
      this.shipToCode,
      this.resourceNo,
      this.resourceName,
      this.serviceZoneCode});

  PmModel.fromJson(Map<String, dynamic> json) {
    serviceItemNo = json['service_item_no'];
    itemNo = json['item_no'];
    serialNo = json['serial_no'];
    pmPlan = json['pm_plan'];
    actual = json['actual'];
    description = json['description'];
    customerNo = json['customer_no'];
    customerName = json['customer_name'];
    shipToCode = json['ship_to_code'];
    resourceNo = json['resource_no'];
    resourceName = json['resource_name'];
    serviceZoneCode = json['service_zone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_item_no'] = serviceItemNo;
    data['item_no'] = itemNo;
    data['serial_no'] = serialNo;
    data['pm_plan'] = pmPlan;
    data['actual'] = actual;
    data['description'] = description;
    data['customer_no'] = customerNo;
    data['customer_name'] = customerName;
    data['ship_to_code'] = shipToCode;
    data['resource_no'] = resourceNo;
    data['resource_name'] = resourceName;
    data['service_zone_code'] = serviceZoneCode;
    return data;
  }
}
