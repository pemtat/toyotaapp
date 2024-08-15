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
  String? processStaff;
  String? relationId;
  String? saveTime;
  String? signature;
  String? signaturePad;
  String? cCode;
  String? partNumber;
  String? description;
  String? quantity;
  String? changeNow;
  String? changeOnPm;
  String? operationHour;
  String? mastType;
  String? lifeHeight;
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

  RepairReportModel({
    this.id,
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
    this.additional,
    this.contactedName,
    this.customerFleet,
    this.customerName,
    this.department,
    this.lifeHeight,
    this.mastType,
    this.model,
    this.operationHour,
    this.product,
    this.serialNo,
    this.tech2,
    this.tech1,
  });

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
    processStaff = json['process_staff'];
    relationId = json['relation_id'];
    saveTime = json['save_time'];
    signature = json['signature'];
    signaturePad = json['signature_pad'];
    cCode = json['c_code'];
    partNumber = json['part_number'];
    description = json['description'];
    quantity = json['quantity'];
    changeNow = json['change_now'];
    changeOnPm = json['change_on_pm'];
    additional = json['additional'];
    contactedName = json['contacted_name'];
    customerFleet = json['customer_fleet'];
    customerName = json['customer_name'];
    department = json['department'];
    lifeHeight = json['life_height'];
    mastType = json['mast_type'];
    model = json['model'];
    operationHour = json['operation_hour'];
    product = json['product'];
    serialNo = json['serial_no'];
    tech2 = json['tech2'];
    tech1 = json['tech1'];
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
    data['process_staff'] = processStaff;
    data['relation_id'] = relationId;
    data['save_time'] = saveTime;
    data['signature'] = signature;
    data['signature_pad'] = signaturePad;
    data['c_code'] = cCode;
    data['part_number'] = partNumber;
    data['description'] = description;
    data['quantity'] = quantity;
    data['change_now'] = changeNow;
    data['change_on_pm'] = changeOnPm;
    data['additional'] = additional;
    data['contacted_name'] = contactedName;
    data['customer_fleet'] = customerFleet;
    data['customer_name'] = customerName;
    data['department'] = department;
    data['life_height'] = lifeHeight;
    data['mast_type'] = mastType;
    data['model'] = model;
    data['operation_hour'] = operationHour;
    data['product'] = product;
    data['serial_no'] = serialNo;
    data['tech2'] = tech2;
    data['tech1'] = tech1;
    return data;
  }
}
