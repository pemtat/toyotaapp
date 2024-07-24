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
  String? phoneNo;

  CustomerById(
      {this.customerNo,
      this.customerName,
      this.customerAddress,
      this.customerEmail,
      this.customerTaxID,
      this.billToCustomerNo,
      this.customerPostingGroup,
      this.paymentTerm,
      this.lastModify,
      this.phoneNo});

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
    phoneNo = json['Phone_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerNo'] = customerNo;
    data['CustomerName'] = customerName;
    data['CustomerAddress'] = customerAddress;
    data['CustomerEmail'] = customerEmail;
    data['CustomerTaxID'] = customerTaxID;
    data['BillToCustomerNo'] = billToCustomerNo;
    data['CustomerPostingGroup'] = customerPostingGroup;
    data['PaymentTerm'] = paymentTerm;
    data['LastModify'] = lastModify;
    data['Phone_No'] = phoneNo;
    return data;
  }
}
