class CustomerById {
  String? customerNo;
  String? customerName;
  String? customerAddress;
  String? customerEmail;
  String? customerTaxID;
  String? billToCustomerNo;
  String? customerPostingGroup;
  String? paymentTerm;
  String? lastModify;

  CustomerById(
      {this.customerNo,
      this.customerName,
      this.customerAddress,
      this.customerEmail,
      this.customerTaxID,
      this.billToCustomerNo,
      this.customerPostingGroup,
      this.paymentTerm,
      this.lastModify});

  CustomerById.fromJson(Map<String, dynamic> json) {
    customerNo = json['CustomerNo'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
    customerEmail = json['CustomerEmail'];
    customerTaxID = json['CustomerTaxID'];
    billToCustomerNo = json['BillToCustomerNo'];
    customerPostingGroup = json['CustomerPostingGroup'];
    paymentTerm = json['PaymentTerm'];
    lastModify = json['LastModify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerNo'] = this.customerNo;
    data['CustomerName'] = this.customerName;
    data['CustomerAddress'] = this.customerAddress;
    data['CustomerEmail'] = this.customerEmail;
    data['CustomerTaxID'] = this.customerTaxID;
    data['BillToCustomerNo'] = this.billToCustomerNo;
    data['CustomerPostingGroup'] = this.customerPostingGroup;
    data['PaymentTerm'] = this.paymentTerm;
    data['LastModify'] = this.lastModify;
    return data;
  }
}
