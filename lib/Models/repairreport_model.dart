class RepairReportModel {
  String? id;
  String? jobIssueId;
  String? fieldReport;
  String? faultReport;
  String? errorCodeReport;
  String? orderNo;
  String? rCode;
  String? wCode;
  String? produre;
  String? problem;
  String? repairResult;
  String? hr;
  String? m;
  String? processStaff;
  String? relationId;
  String? saveTime;
  String? signature;
  String? signaturePad;
  String? signaturePadUrl;
  String? cCode;
  String? partNumber;
  String? description;
  String? quantity;
  String? unitMeasure;
  String? salesPrice;
  bool? priceVat;
  String? changeNow;
  String? changeOnPm;
  String? operationHour;
  String? mastType;
  String? liftHeight;
  String? customerFleet;
  String? tech1;
  String? tech2;
  String? customerName;
  String? department;
  String? contactedName;
  String? product;
  String? model;
  String? serialNo;
  bool? additional;

  RepairReportModel(
      {this.id,
      this.jobIssueId,
      this.fieldReport,
      this.faultReport,
      this.errorCodeReport,
      this.orderNo,
      this.rCode,
      this.wCode,
      this.produre,
      this.problem,
      this.repairResult,
      this.hr,
      this.m,
      this.processStaff,
      this.relationId,
      this.saveTime,
      this.signature,
      this.signaturePad,
      this.cCode,
      this.partNumber,
      this.description,
      this.quantity,
      this.changeNow,
      this.changeOnPm,
      this.unitMeasure,
      this.additional,
      this.contactedName,
      this.customerFleet,
      this.customerName,
      this.department,
      this.liftHeight,
      this.mastType,
      this.model,
      this.operationHour,
      this.product,
      this.serialNo,
      this.tech2,
      this.tech1,
      this.priceVat,
      this.signaturePadUrl,
      this.salesPrice});

  RepairReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobIssueId = json['job_issue_id'];
    fieldReport = json['field_report'];
    faultReport = json['fault_report'];
    errorCodeReport = json['error_code_report'];
    orderNo = json['order_no'];
    rCode = json['r_code'];
    wCode = json['w_code'];
    produre = json['produre'];
    problem = json['problem'];
    repairResult = json['repair_result'];
    hr = json['hr'];
    m = json['m'];
    processStaff = json['process_staff'];
    relationId = json['relation_id'];
    saveTime = json['save_time'];
    signature = json['signature'];
    signaturePad = json['signature_pad'];
    signaturePadUrl = json['signature_pad_url'];
    cCode = json['c_code'];
    partNumber = json['part_number'];
    description = json['description'];
    quantity = json['quantity'];
    changeNow = json['change_now'];
    changeOnPm = json['change_on_pm'];
    unitMeasure = json['unit_of_measure'];
    additional = json['additional'];
    contactedName = json['contacted_name'];
    customerFleet = json['customer_fleet'];
    customerName = json['customer_name'];
    department = json['department'];
    liftHeight = json['lift_height'];
    mastType = json['mast_type'];
    model = json['model'];
    operationHour = json['operation_hour'];
    product = json['product'];
    serialNo = json['serial_no'];
    tech2 = json['tech2'];
    tech1 = json['tech1'];
    salesPrice = json['price'];
    priceVat = json['price_includes_vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_issue_id'] = jobIssueId;
    data['field_report'] = fieldReport;
    data['fault_report'] = faultReport;
    data['error_code_report'] = errorCodeReport;
    data['order_no'] = orderNo;
    data['r_code'] = rCode;
    data['w_code'] = wCode;
    data['produre'] = produre;
    data['problem'] = problem;
    data['repair_result'] = repairResult;
    data['hr'] = hr;
    data['m'] = m;
    data['process_staff'] = processStaff;
    data['relation_id'] = relationId;
    data['save_time'] = saveTime;
    data['signature'] = signature;
    data['signature_pad'] = signaturePad;
    data['signature_pad_url'] = signaturePadUrl;
    data['c_code'] = cCode;
    data['part_number'] = partNumber;
    data['description'] = description;
    data['quantity'] = quantity;
    data['change_now'] = changeNow;
    data['change_on_pm'] = changeOnPm;
    data['unit_of_measure'] = unitMeasure;
    data['additional'] = additional;
    data['contacted_name'] = contactedName;
    data['customer_fleet'] = customerFleet;
    data['customer_name'] = customerName;
    data['department'] = department;
    data['lift_height'] = liftHeight;
    data['mast_type'] = mastType;
    data['model'] = model;
    data['operation_hour'] = operationHour;
    data['product'] = product;
    data['serial_no'] = serialNo;
    data['tech2'] = tech2;
    data['tech1'] = tech1;
    data['price'] = salesPrice;
    data['price_includes_vat'] = priceVat;
    return data;
  }
}
