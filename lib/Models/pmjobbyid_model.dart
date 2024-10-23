class PmModel {
  String? id;
  String? handlerId;
  String? status;
  String? reporterId;
  String? techRemark;
  String? techStatus;
  String? dueDate;
  String? description;
  String? serialNo;
  String? customerNo;
  String? address;
  String? phoneNo;
  String? pmRef;
  String? customerName;
  String? pmPlan;
  String? actual;
  String? resourceNo;
  String? resourceName;
  String? serviceZoneCode;
  String? customerStatus;
  String? tNo;
  String? tSerialNo;
  String? tModel;
  String? tWarranty;

  PmModel(
      {this.id,
      this.handlerId,
      this.status,
      this.reporterId,
      this.techRemark,
      this.techStatus,
      this.dueDate,
      this.description,
      this.serialNo,
      this.customerNo,
      this.address,
      this.phoneNo,
      this.pmRef,
      this.customerName,
      this.pmPlan,
      this.actual,
      this.resourceNo,
      this.resourceName,
      this.serviceZoneCode,
      this.customerStatus,
      this.tNo,
      this.tSerialNo,
      this.tModel,
      this.tWarranty});

  PmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handlerId = json['handler_id'];
    status = json['status'];
    reporterId = json['reporter_id'];
    techRemark = json['tech_remark'];
    techStatus = json['tech_status'];
    dueDate = json['due_date_formatted'];
    description = json['description'];
    serialNo = json['serial_no'];
    customerNo = json['customer_no'];
    address = json['address'];
    phoneNo = json['phone_no'];
    pmRef = json['pm_ref'];
    customerName = json['customer_name'];
    pmPlan = json['pm_plan'];
    actual = json['actual'];
    resourceNo = json['resource_no'];
    resourceName = json['resource_name'];
    serviceZoneCode = json['service_zone_code'];
    customerStatus = json['customer_status'];
    tNo = json['t_no'];
    tSerialNo = json['t_serial_no'];
    tModel = json['t_model'];
    tWarranty = json['t_warranty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handler_id'] = handlerId;
    data['status'] = status;
    data['reporter_id'] = reporterId;
    data['tech_remark'] = techRemark;
    data['tech_status'] = techStatus;
    data['due_date_formatted'] = dueDate;
    data['description'] = description;
    data['serial_no'] = serialNo;
    data['customer_no'] = customerNo;
    data['address'] = address;
    data['phone_no'] = phoneNo;
    data['pm_ref'] = pmRef;
    data['customer_name'] = customerName;
    data['pm_plan'] = pmPlan;
    data['actual'] = actual;
    data['resource_no'] = resourceNo;
    data['resource_name'] = resourceName;
    data['service_zone_code'] = serviceZoneCode;
    data['customer_status'] = customerStatus;
    data['t_no'] = tNo;
    data['t_serial_no'] = tSerialNo;
    data['t_model'] = tModel;
    data['t_warranty'] = tWarranty;
    return data;
  }
}
