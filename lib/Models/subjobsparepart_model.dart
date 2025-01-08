class SubJobSparePart {
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
  String? estimateStatus;
  String? quotation;
  String? techStatus;
  String? techRemark;
  String? salesStatus;
  String? techManagerStatus;
  String? techManagerRemark;
  String? resolution;
  String? projection;
  String? categoryId;
  String? documentNo;
  String? purchaseStatus;
  String? projectId;
  String? handlerId;
  String? reproducibility;
  String? dueDate;
  String? lastUpdated;
  String? warrantyStatus;
  String? description;
  String? reportjobId;
  String? summaryBug;
  String? createdDate;
  String? realname;
  String? referenceCode;
  String? bugStatus;
  String? trNoUrl;
  String? trNo;
  String? customerId;
  String? destinationAddress;
  String? adminId;
  List<Sparepart>? sparepart;
  List<Sparepart>? additionalSparepart;
  List<Sparepart>? btrSparepart;
  List<Sparepart>? pvtSparepart;
  List<Sparepart>? pvtSparepartIc;
  SubJobSparePart(
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
      this.estimateStatus,
      this.quotation,
      this.techStatus,
      this.techRemark,
      this.salesStatus,
      this.techManagerStatus,
      this.techManagerRemark,
      this.resolution,
      this.projection,
      this.categoryId,
      this.projectId,
      this.handlerId,
      this.reproducibility,
      this.dueDate,
      this.lastUpdated,
      this.warrantyStatus,
      this.description,
      this.purchaseStatus,
      this.reportjobId,
      this.createdDate,
      this.summaryBug,
      this.realname,
      this.referenceCode,
      this.sparepart,
      this.bugStatus,
      this.additionalSparepart,
      this.btrSparepart,
      this.pvtSparepart,
      this.pvtSparepartIc,
      this.trNoUrl,
      this.adminId,
      this.destinationAddress,
      this.trNo,
      this.documentNo});

  SubJobSparePart.fromJson(Map<String, dynamic> json) {
    id = json['job_id'];
    reporterId = json['reporter_id'];
    priority = json['priority'];
    severity = json['severity'];
    profileId = json['profile_id'];
    viewState = json['view_state'];
    summary = json['summary'];
    dateSubmitted = json['date_submitted'];
    bugId = json['bug_id'];
    status = json['status'];
    estimateStatus = json['estimate_status'];
    quotation = json['quotation'];
    techStatus = json['tech_status'];
    techRemark = json['tech_remark'];
    salesStatus = json['sales_status'];
    techManagerStatus = json['tech_manager_status'];
    techManagerRemark = json['tech_manager_remark'];
    resolution = json['resolution'];
    projection = json['projection'];
    categoryId = json['category_id'];
    projectId = json['project_id'];
    handlerId = json['handler_id'];
    reproducibility = json['reproducibility'];
    dueDate = json['due_date'];
    createdDate = json['created_date'];
    lastUpdated = json['last_updated'];
    warrantyStatus = json['warranty_status'];
    description = json['description'];
    reportjobId = json['reportjob_id'];
    documentNo = json['document_no'];
    summaryBug = json['summary_bug'];
    realname = json['realname'];
    trNoUrl = json['tr_no_url'];
    trNo = json['tr_no'];
    adminId = json['admin_id'];
    destinationAddress = json['destination_address'];
    purchaseStatus = json['purchase_order_status'];
    bugStatus = json['bug_status'];
    referenceCode = json['reference_code'];
    if (json['sparepart'] != null) {
      sparepart = <Sparepart>[];
      json['sparepart'].forEach((v) {
        sparepart!.add(Sparepart.fromJson(v));
      });
    }
    if (json['additional_sparepart'] != null) {
      additionalSparepart = <Sparepart>[];
      json['additional_sparepart'].forEach((v) {
        additionalSparepart!.add(Sparepart.fromJson(v));
      });
    }
    if (json['btr_sparepart'] != null) {
      btrSparepart = <Sparepart>[];
      json['btr_sparepart'].forEach((v) {
        btrSparepart!.add(Sparepart.fromJson(v));
      });
    }
    if (json['pvt_sparepart'] != null) {
      pvtSparepart = <Sparepart>[];
      json['pvt_sparepart'].forEach((v) {
        pvtSparepart!.add(Sparepart.fromJson(v));
      });
    }
    if (json['pvt_sparepart_ic'] != null) {
      pvtSparepartIc = <Sparepart>[];
      json['pvt_sparepart_ic'].forEach((v) {
        pvtSparepartIc!.add(Sparepart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = id;
    data['reporter_id'] = reporterId;
    data['priority'] = priority;
    data['severity'] = severity;
    data['profile_id'] = profileId;
    data['view_state'] = viewState;
    data['summary'] = summary;
    data['date_submitted'] = dateSubmitted;
    data['bug_id'] = bugId;
    data['status'] = status;
    data['estimate_status'] = estimateStatus;
    data['quotation'] = quotation;
    data['tech_status'] = techStatus;
    data['tech_remark'] = techRemark;
    data['sales_status'] = salesStatus;
    data['tech_manager_status'] = techManagerStatus;
    data['tech_manager_remark'] = techManagerRemark;
    data['resolution'] = resolution;
    data['projection'] = projection;
    data['category_id'] = categoryId;
    data['project_id'] = projectId;
    data['handler_id'] = handlerId;
    data['purchase_order_status'] = purchaseStatus;
    data['reproducibility'] = reproducibility;
    data['due_date'] = dueDate;
    data['document_no'] = documentNo;
    data['last_updated'] = lastUpdated;
    data['warranty_status'] = warrantyStatus;
    data['description'] = description;
    data['reportjob_id'] = reportjobId;
    data['summary_bug'] = summaryBug;
    data['realname'] = realname;
    data['reference_code'] = referenceCode;
    data['bug_status'] = bugStatus;
    data['tr_no_url'] = trNoUrl;
    data['tr_no'] = trNo;
    data['admin_id'] = adminId;
    data['created_date'] = createdDate;
    data['destination_address'] = destinationAddress;
    if (sparepart != null) {
      data['sparepart'] = sparepart!.map((v) => v.toJson()).toList();
    }
    if (additionalSparepart != null) {
      data['additional_sparepart'] =
          additionalSparepart!.map((v) => v.toJson()).toList();
    }
    if (btrSparepart != null) {
      data['btr_sparepart'] = btrSparepart!.map((v) => v.toJson()).toList();
    }
    if (pvtSparepart != null) {
      data['pvt_sparepart'] = pvtSparepart!.map((v) => v.toJson()).toList();
    }
    if (pvtSparepartIc != null) {
      data['pvt_sparepart_ic'] =
          pvtSparepartIc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sparepart {
  String? id;
  String? cCode;
  String? partNumber;
  String? description;
  String? quantity;
  String? changeNow;
  String? changeOnPm;
  String? unitMeasure;
  String? salesPrice;
  bool? priceVat;
  bool? additional;
  String? discount;
  String? summary;
  Sparepart(
      {this.id,
      this.cCode,
      this.partNumber,
      this.description,
      this.quantity,
      this.changeNow,
      this.changeOnPm,
      this.additional,
      this.unitMeasure,
      this.priceVat,
      this.salesPrice,
      this.discount,
      this.summary});

  Sparepart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cCode = json['c_code'];
    partNumber = json['part_number'];
    description = json['description'];
    quantity = json['quantity'];
    changeNow = json['change_now'];
    changeOnPm = json['change_on_pm'];
    additional = json['additional'] is String ? false : json['additional'];
    unitMeasure = json['unit_of_measure'];
    salesPrice = json['price'];
    priceVat = json['price_includes_vat'];
    discount = json['discount'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['c_code'] = cCode;
    data['part_number'] = partNumber;
    data['description'] = description;
    data['quantity'] = quantity;
    data['change_now'] = changeNow;
    data['change_on_pm'] = changeOnPm;
    data['additional'] = additional;
    data['unit_of_measure'] = unitMeasure;
    data['price'] = salesPrice;
    data['price_includes_vat'] = priceVat;
    data['discount'] = discount;
    data['summary'] = summary;
    return data;
  }
}
