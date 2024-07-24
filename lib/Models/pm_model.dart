class PmModel {
  String? id;
  String? handlerId;
  String? status;
  String? reporterId;
  String? dueDate;
  String? serialNo;
  String? description;
  String? customerNo;
  String? customerName;
  String? pmRef;
  String? actual;
  String? resourceNo;
  String? resourceName;
  String? serviceZoneCode;
  String? pmPlan;
  String? techStatus;
  String? techRemark;
  String? customerStatus;

  PmModel(
      {this.id,
      this.handlerId,
      this.reporterId,
      this.serialNo,
      this.status,
      this.dueDate,
      this.description,
      this.actual,
      this.customerNo,
      this.customerName,
      this.resourceNo,
      this.resourceName,
      this.pmRef,
      this.pmPlan,
      this.serviceZoneCode,
      this.techRemark,
      this.techStatus,
      this.customerStatus});

  PmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handlerId = json['handler_id'];
    serialNo = json['serial_no'];
    status = json['status'];
    reporterId = json['reporter_id'];
    dueDate = json['due_date_formatted'];
    actual = json['actual'];
    description = json['description'];
    customerNo = json['customer_no'];
    customerName = json['customer_name'];
    pmRef = json['pm_ref'];
    pmPlan = json['pm_plan'];
    resourceNo = json['resource_no'];
    resourceName = json['resource_name'];
    serviceZoneCode = json['service_zone_code'];
    techRemark = json['tech_remark'];
    techStatus = json['tech_status'];
    customerStatus = json['customer_status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handler_id'] = handlerId;
    data['serial_no'] = serialNo;
    data['status'] = status;
    data['reporter_id'] = reporterId;
    data['due_date_formatted'] = dueDate;
    data['actual'] = actual;
    data['description'] = description;
    data['customer_no'] = customerNo;
    data['customer_name'] = customerName;
    data['pm_ref'] = pmRef;
    data['pm_plan'] = pmPlan;
    data['resource_no'] = resourceNo;
    data['resource_name'] = resourceName;
    data['service_zone_code'] = serviceZoneCode;
    data['tech_remark'] = techRemark;
    data['tech_status'] = techStatus;
    data['customer_status'] = customerStatus;

    return data;
  }
}
