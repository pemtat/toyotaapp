class WarrantyTruckbyId {
  String? serialNo;
  String? no;
  String? model;
  String? truckClass;
  String? inventory;
  String? baseUnitOfMeasure;
  String? vatProdPostingGroup;
  String? costingMethod;
  String? vendorNo;
  String? productGroupCode;
  String? serviceItemGroup;
  String? userId;
  String? bugId;
  String? warranty;

  WarrantyTruckbyId({
    this.serialNo,
    this.no,
    this.model,
    this.truckClass,
    this.inventory,
    this.baseUnitOfMeasure,
    this.vatProdPostingGroup,
    this.costingMethod,
    this.vendorNo,
    this.productGroupCode,
    this.serviceItemGroup,
    this.userId,
    this.bugId,
    this.warranty,
  });

  WarrantyTruckbyId.fromJson(Map<String, dynamic> json) {
    serialNo = json['serial_no'];
    no = json['no'];
    model = json['model'];
    truckClass = json['class'];
    inventory = json['inventory'];
    baseUnitOfMeasure = json['base_unit_of_measure'];
    vatProdPostingGroup = json['vat_prod_posting_group'];
    costingMethod = json['costing_method'];
    vendorNo = json['vendor_no'];
    productGroupCode = json['product_group_code'];
    serviceItemGroup = json['service_item_group'];
    userId = json['user_id'];
    bugId = json['bug_id'];
    warranty = json['warranty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serial_no'] = serialNo;
    data['no'] = no;
    data['model'] = model;
    data['class'] = truckClass;
    data['inventory'] = inventory;
    data['base_unit_of_measure'] = baseUnitOfMeasure;
    data['vat_prod_posting_group'] = vatProdPostingGroup;
    data['costing_method'] = costingMethod;
    data['vendor_no'] = vendorNo;
    data['product_group_code'] = productGroupCode;
    data['service_item_group'] = serviceItemGroup;
    data['user_id'] = userId;
    data['bug_id'] = bugId;
    data['warranty'] = warranty;
    return data;
  }
}
