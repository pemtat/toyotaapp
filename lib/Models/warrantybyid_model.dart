class WarrantybyIdModel {
  String? nametruck;
  String? serial;
  String? model;
  String? warrantytype;
  String? warrantystatus;
  String? coverageexpired;
  Null contractnumber;
  Null contractstart;
  Null contractend;
  String? orderno;
  String? orderdate;
  String? userId;
  String? bugId;

  WarrantybyIdModel(
      {this.nametruck,
      this.serial,
      this.model,
      this.warrantytype,
      this.warrantystatus,
      this.coverageexpired,
      this.contractnumber,
      this.contractstart,
      this.contractend,
      this.orderno,
      this.orderdate,
      this.userId,
      this.bugId});

  WarrantybyIdModel.fromJson(Map<String, dynamic> json) {
    nametruck = json['nametruck'];
    serial = json['serial'];
    model = json['model'];
    warrantytype = json['warrantytype'];
    warrantystatus = json['warrantystatus'];
    coverageexpired = json['coverageexpired'];
    contractnumber = json['contractnumber'];
    contractstart = json['contractstart'];
    contractend = json['contractend'];
    orderno = json['orderno'];
    orderdate = json['orderdate'];
    userId = json['user_id'];
    bugId = json['bug_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nametruck'] = nametruck;
    data['serial'] = serial;
    data['model'] = model;
    data['warrantytype'] = warrantytype;
    data['warrantystatus'] = warrantystatus;
    data['coverageexpired'] = coverageexpired;
    data['contractnumber'] = contractnumber;
    data['contractstart'] = contractstart;
    data['contractend'] = contractend;
    data['orderno'] = orderno;
    data['orderdate'] = orderdate;
    data['user_id'] = userId;
    data['bug_id'] = bugId;
    return data;
  }
}
