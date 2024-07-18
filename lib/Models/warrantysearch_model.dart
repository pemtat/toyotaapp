class WarrantySearch {
  String? nameTruck;
  String? serial;
  String? model;
  int? warrantyType;
  int? warrantyStatus;
  String? coverageExpired;
  String? contractNumber;
  String? contractStart;
  String? contractEnd;
  String? orderNo;
  String? orderDate;

  WarrantySearch(
      {this.nameTruck,
      this.serial,
      this.model,
      this.warrantyType,
      this.warrantyStatus,
      this.coverageExpired,
      this.contractNumber,
      this.contractStart,
      this.contractEnd,
      this.orderNo,
      this.orderDate});

  WarrantySearch.fromJson(Map<String, dynamic> json) {
    nameTruck = json['NameTruck'];
    serial = json['Serial'];
    model = json['Model'];
    warrantyType = json['WarrantyType'];
    warrantyStatus = json['WarrantyStatus'];
    coverageExpired = json['CoverageExpired'];
    contractNumber = json['ContractNumber'];
    contractStart = json['ContractStart'];
    contractEnd = json['ContractEnd'];
    orderNo = json['OrderNo'];
    orderDate = json['OrderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NameTruck'] = nameTruck;
    data['Serial'] = serial;
    data['Model'] = model;
    data['WarrantyType'] = warrantyType;
    data['WarrantyStatus'] = warrantyStatus;
    data['CoverageExpired'] = coverageExpired;
    data['ContractNumber'] = contractNumber;
    data['ContractStart'] = contractStart;
    data['ContractEnd'] = contractEnd;
    data['OrderNo'] = orderNo;
    data['OrderDate'] = orderDate;
    return data;
  }
}
