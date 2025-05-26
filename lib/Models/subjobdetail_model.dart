class SubJobDetail {
  String? id;
  String? reporterId;
  String? priority;
  String? severity;
  String? profileId;
  String? viewState;
  String? summary;
  String? dateSubmitted;
  String? bugId;
  String? status;
  String? resolution;
  String? projection;
  String? categoryId;
  String? projectId;
  String? handlerId;
  String? reproducibility;
  String? dueDate;
  String? lastUpdated;
  String? description;
  String? timeStart;
  String? timeEnd;
  String? comment;
  String? contentBefore;
  String? imageBefore;
  String? imageAfter;
  String? contentAfter;
  String? techRemark;
  String? techStatus;
  String? imgUrlBefore;
  String? imgUrlAfter;
  String? salesStatus;
  String? techManagerStatus;
  String? techManagerRemark;
  String? techManagerId;
  String? specialDiscount;
  String? vat;
  String? salesManagerStatus;
  String? salesManagerId;
  String? salesDirectorStatus;
  String? salesDirectorId;
  String? quotation;
  String? salesId;
  String? estimateStatus;
  String? adminStatus;
  String? codeStatusSparePart;
  String? adminId;
  String? documentNo;
  String? documentDate;
  String? customerStatus;
  String? purchaseOrderStatus;
  String? summaryBug;
  String? reportjobId;
  String? referenceCode;
  String? bugStatus;
  String? realName;
  String? companyName;
  String? email;
  String? emailCompany;
  String? phoneNumber;
  String? phoneCompany;
  String? address;
  String? nameTruck;
  String? serialNo;
  String? model;
  String? warrantyStatus;
  bool? partDisable;

  SubJobDetail(
      {this.id,
      this.reporterId,
      this.priority,
      this.severity,
      this.profileId,
      this.viewState,
      this.summary,
      this.dateSubmitted,
      this.bugId,
      this.status,
      this.resolution,
      this.projection,
      this.categoryId,
      this.projectId,
      this.handlerId,
      this.reproducibility,
      this.dueDate,
      this.lastUpdated,
      this.description,
      this.timeStart,
      this.timeEnd,
      this.comment,
      this.contentBefore,
      this.imageBefore,
      this.imageAfter,
      this.contentAfter,
      this.techRemark,
      this.techStatus,
      this.imgUrlBefore,
      this.imgUrlAfter,
      this.salesStatus,
      this.techManagerStatus,
      this.techManagerRemark,
      this.techManagerId,
      this.specialDiscount,
      this.vat,
      this.salesManagerStatus,
      this.salesManagerId,
      this.salesDirectorStatus,
      this.salesDirectorId,
      this.quotation,
      this.salesId,
      this.estimateStatus,
      this.adminStatus,
      this.codeStatusSparePart,
      this.adminId,
      this.documentNo,
      this.documentDate,
      this.customerStatus,
      this.purchaseOrderStatus,
      this.summaryBug,
      this.reportjobId,
      this.referenceCode,
      this.bugStatus,
      this.realName,
      this.companyName,
      this.email,
      this.emailCompany,
      this.phoneNumber,
      this.phoneCompany,
      this.address,
      this.nameTruck,
      this.serialNo,
      this.model,
      this.warrantyStatus,
      this.partDisable});

  SubJobDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporterId = json['reporter_id'];
    priority = json['priority'];
    severity = json['severity'];
    profileId = json['profile_id'];
    viewState = json['view_state'];
    summary = json['summary'];
    dateSubmitted = json['date_submitted'];
    bugId = json['bug_id'];
    status = json['status'];
    resolution = json['resolution'];
    projection = json['projection'];
    categoryId = json['category_id'];
    projectId = json['project_id'];
    handlerId = json['handler_id'];
    reproducibility = json['reproducibility'];
    dueDate = json['due_date'];
    lastUpdated = json['last_updated'];
    description = json['description'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    comment = json['comment'];
    contentBefore = json['content_before'];
    imageBefore = json['image_before'];
    imageAfter = json['image_after'];
    contentAfter = json['content_after'];
    techRemark = json['tech_remark'];
    techStatus = json['tech_status'];
    imgUrlBefore = json['img_url_before'];
    imgUrlAfter = json['img_url_after'];
    salesStatus = json['sales_status'];
    techManagerStatus = json['tech_manager_status'];
    techManagerRemark = json['tech_manager_remark'];
    techManagerId = json['tech_manager_id'];
    specialDiscount = json['special_discount'];
    vat = json['vat'];
    salesManagerStatus = json['sales_manager_status'];
    salesManagerId = json['sales_manager_id'];
    salesDirectorStatus = json['sales_director_status'];
    salesDirectorId = json['sales_director_id'];
    quotation = json['quotation'];
    salesId = json['sales_id'];
    estimateStatus = json['estimate_status'];
    adminStatus = json['admin_status'];
    codeStatusSparePart = json['code_status_spare_part'];
    adminId = json['admin_id'];
    documentNo = json['document_no'];
    documentDate = json['document_date'];
    customerStatus = json['customer_status'];
    purchaseOrderStatus = json['purchase_order_status'];
    summaryBug = json['summary_bug'];
    reportjobId = json['reportjob_id'];
    referenceCode = json['reference_code'];
    bugStatus = json['bug_status'];
    realName = json['realname'];
    companyName = json['company_name'];
    email = json['email'];
    emailCompany = json['email_company'];
    phoneNumber = json['phone_number'];
    phoneCompany = json['phone_company'];
    address = json['address'];
    nameTruck = json['name_truck'];
    serialNo = json['serial_no'];
    model = json['model'];
    warrantyStatus = json['warranty_status'];
    partDisable = json['part_disable'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reporter_id'] = reporterId;
    data['priority'] = priority;
    data['severity'] = severity;
    data['profile_id'] = profileId;
    data['view_state'] = viewState;
    data['summary'] = summary;
    data['date_submitted'] = dateSubmitted;
    data['bug_id'] = bugId;
    data['status'] = status;
    data['resolution'] = resolution;
    data['projection'] = projection;
    data['category_id'] = categoryId;
    data['project_id'] = projectId;
    data['handler_id'] = handlerId;
    data['reproducibility'] = reproducibility;
    data['due_date'] = dueDate;
    data['last_updated'] = lastUpdated;
    data['description'] = description;
    data['time_start'] = timeStart;
    data['time_end'] = timeEnd;
    data['comment'] = comment;
    data['content_before'] = contentBefore;
    data['image_before'] = imageBefore;
    data['image_after'] = imageAfter;
    data['content_after'] = contentAfter;
    data['tech_remark'] = techRemark;
    data['tech_status'] = techStatus;
    data['img_url_before'] = imgUrlBefore;
    data['img_url_after'] = imgUrlAfter;
    data['sales_status'] = salesStatus;
    data['tech_manager_status'] = techManagerStatus;
    data['tech_manager_remark'] = techManagerRemark;
    data['tech_manager_id'] = techManagerId;
    data['special_discount'] = specialDiscount;
    data['vat'] = vat;
    data['sales_manager_status'] = salesManagerStatus;
    data['sales_manager_id'] = salesManagerId;
    data['sales_director_status'] = salesDirectorStatus;
    data['sales_director_id'] = salesDirectorId;
    data['quotation'] = quotation;
    data['sales_id'] = salesId;
    data['estimate_status'] = estimateStatus;
    data['admin_status'] = adminStatus;
    data['code_status_spare_part'] = codeStatusSparePart;
    data['admin_id'] = adminId;
    data['document_no'] = documentNo;
    data['document_date'] = documentDate;
    data['customer_status'] = customerStatus;
    data['purchase_order_status'] = purchaseOrderStatus;
    data['summary_bug'] = summaryBug;
    data['reportjob_id'] = reportjobId;
    data['reference_code'] = referenceCode;
    data['bug_status'] = bugStatus;
    data['realname'] = realName;
    data['company_name'] = companyName;
    data['email'] = email;
    data['email_company'] = emailCompany;
    data['phone_number'] = phoneNumber;
    data['phone_company'] = phoneCompany;
    data['address'] = address;
    data['name_truck'] = nameTruck;
    data['serial_no'] = serialNo;
    data['model'] = model;
    data['warranty_status'] = warrantyStatus;
    data['part_disable'] = partDisable;
    return data;
  }
}
