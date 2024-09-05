class BatteryReportModel {
  BtrMaintenance? btrMaintenance;
  List<BtrSpareparts>? btrSpareparts;
  List<Null>? btrSparepartsChange;
  List<Null>? btrSparepartsRecommended;
  List<BtrConditions>? btrConditions;
  List<SpecicVoltageCheck>? specicVoltageCheck;

  BatteryReportModel(
      {this.btrMaintenance,
      this.btrSpareparts,
      this.btrSparepartsChange,
      this.btrSparepartsRecommended,
      this.btrConditions,
      this.specicVoltageCheck});

  BatteryReportModel.fromJson(Map<String, dynamic> json) {
    btrMaintenance = json['btr_maintenance'] != null
        ? BtrMaintenance.fromJson(json['btr_maintenance'])
        : null;
    if (json['btr_spareparts'] != null) {
      btrSpareparts = <BtrSpareparts>[];
      json['btr_spareparts'].forEach((v) {
        btrSpareparts!.add(BtrSpareparts.fromJson(v));
      });
    } else {
      btrSpareparts = [];
    }
    if (json['btr_conditions'] != null) {
      btrConditions = <BtrConditions>[];
      json['btr_conditions'].forEach((v) {
        btrConditions!.add(BtrConditions.fromJson(v));
      });
    } else {
      btrConditions = [];
    }

    if (json['specic_voltage_check'] != null) {
      specicVoltageCheck = <SpecicVoltageCheck>[];
      json['specic_voltage_check'].forEach((v) {
        specicVoltageCheck!.add(SpecicVoltageCheck.fromJson(v));
      });
    } else {
      specicVoltageCheck = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (btrMaintenance != null) {
      data['btr_maintenance'] = btrMaintenance!.toJson();
    }
    if (btrSpareparts != null) {
      data['btr_spareparts'] = btrSpareparts!.map((v) => v.toJson()).toList();
    }

    if (btrConditions != null) {
      data['btr_conditions'] = btrConditions!.map((v) => v.toJson()).toList();
    }
    if (specicVoltageCheck != null) {
      data['specic_voltage_check'] =
          specicVoltageCheck!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BtrMaintenance {
  String? id;
  String? jobId;
  String? batteryBand;
  String? batteryModel;
  String? manufacturerNo;
  String? serialNo;
  String? batteryLifespan;
  String? informationVoltage;
  String? capacity;
  String? forkliftBrand;
  String? forkliftModel;
  String? forkliftSerial;
  String? forkliftOperation;
  String? shiftTime;
  String? hrs;
  String? ratio;
  String? chargingType;
  String? totalVoltage;
  String? correctiveAction;
  String? customerName;
  String? contactPerson;
  String? division;
  String? result;
  String? repairPm;
  String? signature;
  String? signaturePad;
  String? saveTime;
  String? relationId;
  String? createdAtLocal;
  String? lastUpdatedLocal;
  String? createdByRealname;
  String? tech1;
  String? tech2;

  BtrMaintenance({
    this.id,
    this.jobId,
    this.batteryBand,
    this.batteryModel,
    this.manufacturerNo,
    this.serialNo,
    this.batteryLifespan,
    this.informationVoltage,
    this.capacity,
    this.forkliftBrand,
    this.forkliftModel,
    this.forkliftSerial,
    this.forkliftOperation,
    this.shiftTime,
    this.hrs,
    this.ratio,
    this.chargingType,
    this.totalVoltage,
    this.correctiveAction,
    this.result,
    this.repairPm,
    this.signature,
    this.signaturePad,
    this.saveTime,
    this.relationId,
    this.createdAtLocal,
    this.lastUpdatedLocal,
    this.createdByRealname,
    this.contactPerson,
    this.customerName,
    this.division,
    this.tech2,
    this.tech1,
  });

  BtrMaintenance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    batteryBand = json['battery_band'];
    batteryModel = json['battery_model'];
    manufacturerNo = json['manufacturer_no'];
    serialNo = json['serial_no'];
    batteryLifespan = json['battery_lifespan'];
    informationVoltage = json['information_voltage'];
    capacity = json['capacity'];
    forkliftBrand = json['forklift_brand'];
    forkliftModel = json['forklift_model'];
    forkliftSerial = json['forklift_serial'];
    forkliftOperation = json['forklift_operation'];
    shiftTime = json['shift_time'];
    hrs = json['hrs'];
    ratio = json['ratio'];
    chargingType = json['charging_type'];
    totalVoltage = json['total_voltage'];
    correctiveAction = json['corrective_action'];
    result = json['result'];
    repairPm = json['repair_pm'];
    signature = json['signature'];
    signaturePad = json['signature_pad'];
    saveTime = json['save_time'];
    relationId = json['relation_id'];
    createdAtLocal = json['created_at_local'];
    lastUpdatedLocal = json['last_updated_local'];
    createdByRealname = json['created_by_realname'];
    division = json['division'];
    customerName = json['customer_name'];
    contactPerson = json['contact_person'];
    tech1 = json['tech1'];
    tech2 = json['tech2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['battery_band'] = batteryBand;
    data['battery_model'] = batteryModel;
    data['manufacturer_no'] = manufacturerNo;
    data['serial_no'] = serialNo;
    data['battery_lifespan'] = batteryLifespan;
    data['information_voltage'] = informationVoltage;
    data['capacity'] = capacity;
    data['forklift_brand'] = forkliftBrand;
    data['forklift_model'] = forkliftModel;
    data['forklift_serial'] = forkliftSerial;
    data['forklift_operation'] = forkliftOperation;
    data['shift_time'] = shiftTime;
    data['hrs'] = hrs;
    data['ratio'] = ratio;
    data['charging_type'] = chargingType;
    data['total_voltage'] = totalVoltage;
    data['corrective_action'] = correctiveAction;
    data['result'] = result;
    data['repair_pm'] = repairPm;
    data['signature'] = signature;
    data['signature_pad'] = signaturePad;
    data['save_time'] = saveTime;
    data['relation_id'] = relationId;
    data['created_at_local'] = createdAtLocal;
    data['last_updated_local'] = lastUpdatedLocal;
    data['created_by_realname'] = createdByRealname;
    data['contact_person'] = contactPerson;
    data['customer_name'] = customerName;
    data['division'] = division;
    data['tech1'] = tech1;
    data['tech2'] = tech2;
    return data;
  }
}

class BtrSpareparts {
  String? id;
  String? cCode;
  String? partNumber;
  String? description;
  String? quantity;
  String? additional;
  String? relationId;
  String? unitMeasure;
  String? salesPrice;
  bool? priceVat;
  String? createdAtLocal;
  String? lastUpdatedLocal;
  String? createdByRealname;

  BtrSpareparts(
      {this.id,
      this.cCode,
      this.partNumber,
      this.description,
      this.quantity,
      this.additional,
      this.relationId,
      this.unitMeasure,
      this.priceVat,
      this.salesPrice,
      this.createdAtLocal,
      this.lastUpdatedLocal,
      this.createdByRealname});

  BtrSpareparts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cCode = json['c_code'];
    partNumber = json['part_number'];
    description = json['description'];
    quantity = json['quantity'];
    additional = json['additional'];
    relationId = json['relation_id'];
    unitMeasure = json['unit_of_measure'];
    salesPrice = json['price'];
    priceVat = json['price_includes_vat'];
    createdAtLocal = json['created_at_local'];
    lastUpdatedLocal = json['last_updated_local'];
    createdByRealname = json['created_by_realname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['c_code'] = cCode;
    data['part_number'] = partNumber;
    data['description'] = description;
    data['quantity'] = quantity;
    data['additional'] = additional;
    data['relation_id'] = relationId;
    data['unit_of_measure'] = unitMeasure;
    data['price'] = salesPrice;
    data['price_includes_vat'] = priceVat;
    data['created_at_local'] = createdAtLocal;
    data['last_updated_local'] = lastUpdatedLocal;
    data['created_by_realname'] = createdByRealname;
    return data;
  }
}

class BtrConditions {
  String? id;
  String? jobId;
  String? itemId;
  String? nameTh;
  String? nameEn;
  String? fullName;
  String? status;
  String? checking;
  String? description;

  BtrConditions(
      {this.id,
      this.jobId,
      this.itemId,
      this.nameTh,
      this.nameEn,
      this.fullName,
      this.status,
      this.checking,
      this.description});

  BtrConditions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    itemId = json['item_id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    fullName = json['full_name'];
    status = json['status'];
    checking = json['checking'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['item_id'] = itemId;
    data['name_th'] = nameTh;
    data['name_en'] = nameEn;
    data['full_name'] = fullName;
    data['status'] = status;
    data['checking'] = checking;
    data['description'] = description;
    return data;
  }
}

class SpecicVoltageCheck {
  String? id;
  String? jobId;
  String? thp;
  String? temperature;
  String? voltageCheck;
  String? createdAtLocal;
  String? lastUpdatedLocal;
  String? createdByRealname;

  SpecicVoltageCheck(
      {this.id,
      this.jobId,
      this.thp,
      this.temperature,
      this.voltageCheck,
      this.createdAtLocal,
      this.lastUpdatedLocal,
      this.createdByRealname});

  SpecicVoltageCheck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    thp = json['thp'];
    temperature = json['temperature'];
    voltageCheck = json['voltage_check'];
    createdAtLocal = json['created_at_local'];
    lastUpdatedLocal = json['last_updated_local'];
    createdByRealname = json['created_by_realname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['thp'] = thp;
    data['temperature'] = temperature;
    data['voltage_check'] = voltageCheck;
    data['created_at_local'] = createdAtLocal;
    data['last_updated_local'] = lastUpdatedLocal;
    data['created_by_realname'] = createdByRealname;
    return data;
  }
}
