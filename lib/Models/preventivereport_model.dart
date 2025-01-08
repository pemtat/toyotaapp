class PreventivereportModel {
  PvtMaintenance? pvtMaintenance;
  List<PvtCheckingTypeMaster>? pvtCheckingTypeMaster;
  List<DarDetails>? darDetails;
  List<MaintenanceRecords>? maintenanceRecords;

  PreventivereportModel(
      {this.pvtMaintenance,
      this.pvtCheckingTypeMaster,
      this.darDetails,
      this.maintenanceRecords});

  PreventivereportModel.fromJson(Map<String, dynamic> json) {
    if (json['pvt_maintenance'] is bool) {
      pvtMaintenance = null;
    } else {
      pvtMaintenance = json['pvt_maintenance'] != null
          ? PvtMaintenance.fromJson(json['pvt_maintenance'])
          : null;
    }
    if (json['pvt_checking_type_master'] != null) {
      pvtCheckingTypeMaster = <PvtCheckingTypeMaster>[];
      json['pvt_checking_type_master'].forEach((v) {
        pvtCheckingTypeMaster!.add(PvtCheckingTypeMaster.fromJson(v));
      });
    }
    if (json['dar_details'] != null) {
      darDetails = <DarDetails>[];
      json['dar_details'].forEach((v) {
        darDetails!.add(DarDetails.fromJson(v));
      });
    }
    if (json['maintenance_records'] != null) {
      maintenanceRecords = <MaintenanceRecords>[];
      json['maintenance_records'].forEach((v) {
        maintenanceRecords!.add(MaintenanceRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pvtMaintenance != null) {
      data['pvt_maintenance'] = pvtMaintenance!.toJson();
    }
    if (pvtCheckingTypeMaster != null) {
      data['pvt_checking_type_master'] =
          pvtCheckingTypeMaster!.map((v) => v.toJson()).toList();
    }
    if (darDetails != null) {
      data['dar_details'] = darDetails!.map((v) => v.toJson()).toList();
    }
    if (maintenanceRecords != null) {
      data['maintenance_records'] =
          maintenanceRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PvtMaintenance {
  String? id;
  String? jobId;
  String? safetyTravelAlarm;
  String? safetyRearviewMirror;
  String? safetySeatBelt;
  String? mtServiceResult;
  String? officerChecking;
  String? customerChecking;
  String? customerScore;
  String? customerDescription;
  String? createdAt;
  String? createdBy;
  String? lastUpdated;
  String? hr;
  String? m;
  String? signature;
  String? signaturePad;
  String? signaturePadUrl;
  String? saveTime;
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
  String? sparePartRemark;
  String? serviceType;
  String? chassicNo;
  PvtMaintenance(
      {this.id,
      this.jobId,
      this.safetyTravelAlarm,
      this.safetyRearviewMirror,
      this.safetySeatBelt,
      this.mtServiceResult,
      this.officerChecking,
      this.customerChecking,
      this.customerScore,
      this.customerDescription,
      this.createdAt,
      this.createdBy,
      this.lastUpdated,
      this.hr,
      this.m,
      this.signature,
      this.signaturePad,
      this.signaturePadUrl,
      this.saveTime,
      this.customerFleet,
      this.liftHeight,
      this.mastType,
      this.operationHour,
      this.tech2,
      this.tech1,
      this.contactedName,
      this.customerName,
      this.department,
      this.model,
      this.product,
      this.serialNo,
      this.serviceType,
      this.chassicNo,
      this.sparePartRemark});

  PvtMaintenance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    safetyTravelAlarm = json['safety_travel_alarm'];
    safetyRearviewMirror = json['safety_rearview_mirror'];
    safetySeatBelt = json['safety_seat_belt'];
    mtServiceResult = json['mt_service_result'];
    officerChecking = json['officer_checking'];
    customerChecking = json['customer_checking'];
    customerScore = json['customer_score'];
    customerDescription = json['customer_description'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    lastUpdated = json['last_updated'];
    hr = json['hr'];
    m = json['m'];
    signature = json['signature'];
    signaturePad = json['signature_pad'];
    signaturePadUrl = json['signature_pad_url'];
    saveTime = json['save_time'];
    customerFleet = json['customer_fleet'];
    liftHeight = json['lift_height'];
    mastType = json['mast_type'];
    operationHour = json['operation_hour'];
    tech2 = json['tech2'];
    tech1 = json['tech1'];
    contactedName = json['contacted_name'];
    customerName = json['customer_name'];
    department = json['department'];
    model = json['model'];
    product = json['product'];
    serialNo = json['serial_no'];
    sparePartRemark = json['spare_part_remark'];
    serviceType = json['service_type'];
    chassicNo = json['chassis_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['safety_travel_alarm'] = safetyTravelAlarm;
    data['safety_rearview_mirror'] = safetyRearviewMirror;
    data['safety_seat_belt'] = safetySeatBelt;
    data['mt_service_result'] = mtServiceResult;
    data['officer_checking'] = officerChecking;
    data['customer_checking'] = customerChecking;
    data['customer_score'] = customerScore;
    data['customer_description'] = customerDescription;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['last_updated'] = lastUpdated;
    data['hr'] = hr;
    data['m'] = m;
    data['signature'] = signature;
    data['signature_pad_url'] = signaturePadUrl;
    data['save_time'] = saveTime;
    data['customer_fleet'] = customerFleet;
    data['lift_height'] = liftHeight;
    data['mast_type'] = mastType;
    data['operation_hour'] = operationHour;
    data['tech2'] = tech2;
    data['tech1'] = tech1;
    data['contacted_name'] = contactedName;
    data['customer_name'] = customerName;
    data['department'] = department;
    data['model'] = model;
    data['product'] = product;
    data['serial_no'] = serialNo;
    data['spare_part_remark'] = sparePartRemark;
    data['service_type'] = serviceType;
    data['chassis_no'] = chassicNo;
    return data;
  }
}

class PvtCheckingTypeMaster {
  String? id;
  String? code;
  String? nameTh;
  String? nameEn;
  String? createdAt;
  String? createdBy;
  String? realnameCreate;
  String? fullname;
  List<MaintenanceRecords>? maintenanceRecords;

  PvtCheckingTypeMaster(
      {this.id,
      this.code,
      this.nameTh,
      this.nameEn,
      this.createdAt,
      this.createdBy,
      this.realnameCreate,
      this.fullname,
      this.maintenanceRecords});

  PvtCheckingTypeMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    realnameCreate = json['realname_create'];
    fullname = json['fullname'];
    if (json['maintenance_records'] != null) {
      maintenanceRecords = <MaintenanceRecords>[];
      json['maintenance_records'].forEach((v) {
        maintenanceRecords!.add(MaintenanceRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name_th'] = nameTh;
    data['name_en'] = nameEn;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['realname_create'] = realnameCreate;
    data['fullname'] = fullname;
    if (maintenanceRecords != null) {
      data['maintenance_records'] =
          maintenanceRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaintenanceRecords {
  String? id;
  String? jobId;
  String? pvtCategoryCode;
  String? pvtMaintenanceCode;
  String? fullName;
  String? ok;
  String? poor;
  String? status;
  String? name;
  String? data1;
  String? nextDetails1;
  String? data2;
  String? nextDetails2;
  String? pvtTypeCode;
  String? nameTh;
  String? nameEn;
  String? fullnameType;
  String? createByRealname;
  String? remark;

  MaintenanceRecords(
      {this.id,
      this.jobId,
      this.pvtCategoryCode,
      this.pvtMaintenanceCode,
      this.fullName,
      this.ok,
      this.poor,
      this.status,
      this.name,
      this.data1,
      this.nextDetails1,
      this.data2,
      this.nextDetails2,
      this.pvtTypeCode,
      this.nameTh,
      this.nameEn,
      this.fullnameType,
      this.createByRealname,
      this.remark});

  MaintenanceRecords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    pvtCategoryCode = json['pvt_category_code'];
    pvtMaintenanceCode = json['pvt_maintenance_code'];
    fullName = json['full_name'];
    ok = json['ok'];
    poor = json['poor'];
    status = json['status'];
    name = json['name'];
    data1 = json['data_1'];
    nextDetails1 = json['next_details_1'];
    data2 = json['data_2'];
    nextDetails2 = json['next_details_2'];
    pvtTypeCode = json['pvt_type_code'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    fullnameType = json['fullname_type'];
    createByRealname = json['create_by_realname'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['pvt_category_code'] = pvtCategoryCode;
    data['pvt_maintenance_code'] = pvtMaintenanceCode;
    data['full_name'] = fullName;
    data['ok'] = ok;
    data['poor'] = poor;
    data['status'] = status;
    data['name'] = name;
    data['data_1'] = data1;
    data['next_details_1'] = nextDetails1;
    data['data_2'] = data2;
    data['next_details_2'] = nextDetails2;
    data['pvt_type_code'] = pvtTypeCode;
    data['name_th'] = nameTh;
    data['name_en'] = nameEn;
    data['fullname_type'] = fullnameType;
    data['create_by_realname'] = createByRealname;
    data['remark'] = remark;
    return data;
  }
}

class DarDetails {
  String? id;
  String? jobCode;
  String? no;
  String? pageCode;
  String? description;
  String? partNumber;
  String? qty;
  String? createdAtLocal;
  String? lastUpdatedLocal;
  String? createdByRealname;
  String? unitMeasure;
  String? salesPrice;
  bool? priceVat;

  DarDetails(
      {this.id,
      this.jobCode,
      this.no,
      this.pageCode,
      this.description,
      this.partNumber,
      this.qty,
      this.priceVat,
      this.salesPrice,
      this.createdAtLocal,
      this.lastUpdatedLocal,
      this.createdByRealname,
      this.unitMeasure});

  DarDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobCode = json['job_code'];
    no = json['no'];
    pageCode = json['page_code'];
    description = json['description'];
    partNumber = json['part_number'];
    qty = json['qty'];
    createdAtLocal = json['created_at_local'];
    lastUpdatedLocal = json['last_updated_local'];
    createdByRealname = json['created_by_realname'];
    unitMeasure = json['unit_of_measure'];
    salesPrice = json['price'];
    priceVat = json['price_includes_vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_code'] = jobCode;
    data['no'] = no;
    data['page_code'] = pageCode;
    data['description'] = description;
    data['part_number'] = partNumber;
    data['qty'] = qty;
    data['created_at_local'] = createdAtLocal;
    data['last_updated_local'] = lastUpdatedLocal;
    data['created_by_realname'] = createdByRealname;
    data['unit_of_measure'] = unitMeasure;
    data['price'] = salesPrice;
    data['price_includes_vat'] = priceVat;
    return data;
  }
}
