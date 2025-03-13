class TruckByIdModel {
  String? id;
  String? customerName;
  String? contactName;
  String? tNo;
  String? tSerialNo;
  String? tModel;
  String? tWarranty;

  TruckByIdModel(
      {this.id,
      this.customerName,
      this.contactName,
      this.tNo,
      this.tSerialNo,
      this.tModel,
      this.tWarranty});

  TruckByIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    contactName = json['contact_name'];
    tNo = json['t_no'];
    tSerialNo = json['t_serial_no'];
    tModel = json['t_model'];
    tWarranty = json['t_warranty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customer_name'] = customerName;
    data['contact_name'] = contactName;
    data['t_no'] = tNo;
    data['t_serial_no'] = tSerialNo;
    data['t_model'] = tModel;
    data['t_warranty'] = tWarranty;
    return data;
  }
}
