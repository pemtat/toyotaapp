class CustomerModel {
  String? id;
  String? customerNo;
  String? name;
  String? searchName;
  String? address;
  String? address2;
  String? city;
  String? contact;
  String? phoneNo;
  String? customerPostingGroup;
  String? languageCode;
  String? salespersonCode;
  String? shipmentMethodCode;
  String? shippingAgentCode;
  String? placeOfExport;
  String? invoiceDiscCode;
  String? customerDiscGroup;
  String? countryRegionCode;
  String? cBlocked;
  String? billToCustomerNo;
  String? paymentMethodCode;
  String? pricesIncludingVat;
  String? locationCode;
  String? faxNo;
  String? vatRegistrationNo;
  String? combineShipments;
  String? genBusPostingGroup;
  String? postCode;
  String? county;
  String? email;
  String? taxAreaCode;
  String? vatBusPostingGroup;
  String? serviceZoneCode;
  String? contact2;
  String? cc;
  String? checkContactName;
  String? billingTel;
  String? billingFax;
  String? headOffice;
  String? branchNo;
  String? branchHo;
  String? branch;
  String? customerType;
  String? createBy;
  String? createDate;
  String? lastDateModified;

  CustomerModel(
      {this.id,
      this.customerNo,
      this.name,
      this.searchName,
      this.address,
      this.address2,
      this.city,
      this.contact,
      this.phoneNo,
      this.customerPostingGroup,
      this.languageCode,
      this.salespersonCode,
      this.shipmentMethodCode,
      this.shippingAgentCode,
      this.placeOfExport,
      this.invoiceDiscCode,
      this.customerDiscGroup,
      this.countryRegionCode,
      this.cBlocked,
      this.billToCustomerNo,
      this.paymentMethodCode,
      this.pricesIncludingVat,
      this.locationCode,
      this.faxNo,
      this.vatRegistrationNo,
      this.combineShipments,
      this.genBusPostingGroup,
      this.postCode,
      this.county,
      this.email,
      this.taxAreaCode,
      this.vatBusPostingGroup,
      this.serviceZoneCode,
      this.contact2,
      this.cc,
      this.checkContactName,
      this.billingTel,
      this.billingFax,
      this.headOffice,
      this.branchNo,
      this.branchHo,
      this.branch,
      this.customerType,
      this.createBy,
      this.createDate,
      this.lastDateModified});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerNo = json['customer_no'];
    name = json['name'];
    searchName = json['search_name'];
    address = json['address'];
    address2 = json['address_2'];
    city = json['city'];
    contact = json['contact'];
    phoneNo = json['phone_no'];
    customerPostingGroup = json['customer_posting_group'];
    languageCode = json['language_code'];
    salespersonCode = json['salesperson_code'];
    shipmentMethodCode = json['shipment_method_code'];
    shippingAgentCode = json['shipping_agent_code'];
    placeOfExport = json['place_of_export'];
    invoiceDiscCode = json['invoice_disc_code'];
    customerDiscGroup = json['customer_disc_group'];
    countryRegionCode = json['country_region_code'];
    cBlocked = json['c_blocked'];
    billToCustomerNo = json['bill_to_customer_no'];
    paymentMethodCode = json['payment_method_code'];
    pricesIncludingVat = json['prices_including_vat'];
    locationCode = json['location_code'];
    faxNo = json['fax_no'];
    vatRegistrationNo = json['vat_registration_no'];
    combineShipments = json['combine_shipments'];
    genBusPostingGroup = json['gen_bus_posting_group'];
    postCode = json['post_code'];
    county = json['county'];
    email = json['email'];
    taxAreaCode = json['tax_area_code'];
    vatBusPostingGroup = json['vat_bus_posting_group'];
    serviceZoneCode = json['service_zone_code'];
    contact2 = json['contact2'];
    cc = json['cc'];
    checkContactName = json['check_contact_name'];
    billingTel = json['billing_tel'];
    billingFax = json['billing_fax'];
    headOffice = json['head_office'];
    branchNo = json['branch_no'];
    branchHo = json['branch_ho'];
    branch = json['branch'];
    customerType = json['customer_type'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    lastDateModified = json['last_date_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customer_no'] = customerNo;
    data['name'] = name;
    data['search_name'] = searchName;
    data['address'] = address;
    data['address_2'] = address2;
    data['city'] = city;
    data['contact'] = contact;
    data['phone_no'] = phoneNo;
    data['customer_posting_group'] = customerPostingGroup;
    data['language_code'] = languageCode;
    data['salesperson_code'] = salespersonCode;
    data['shipment_method_code'] = shipmentMethodCode;
    data['shipping_agent_code'] = shippingAgentCode;
    data['place_of_export'] = placeOfExport;
    data['invoice_disc_code'] = invoiceDiscCode;
    data['customer_disc_group'] = customerDiscGroup;
    data['country_region_code'] = countryRegionCode;
    data['c_blocked'] = cBlocked;
    data['bill_to_customer_no'] = billToCustomerNo;
    data['payment_method_code'] = paymentMethodCode;
    data['prices_including_vat'] = pricesIncludingVat;
    data['location_code'] = locationCode;
    data['fax_no'] = faxNo;
    data['vat_registration_no'] = vatRegistrationNo;
    data['combine_shipments'] = combineShipments;
    data['gen_bus_posting_group'] = genBusPostingGroup;
    data['post_code'] = postCode;
    data['county'] = county;
    data['email'] = email;
    data['tax_area_code'] = taxAreaCode;
    data['vat_bus_posting_group'] = vatBusPostingGroup;
    data['service_zone_code'] = serviceZoneCode;
    data['contact2'] = contact2;
    data['cc'] = cc;
    data['check_contact_name'] = checkContactName;
    data['billing_tel'] = billingTel;
    data['billing_fax'] = billingFax;
    data['head_office'] = headOffice;
    data['branch_no'] = branchNo;
    data['branch_ho'] = branchHo;
    data['branch'] = branch;
    data['customer_type'] = customerType;
    data['create_by'] = createBy;
    data['create_date'] = createDate;
    data['last_date_modified'] = lastDateModified;
    return data;
  }
}
