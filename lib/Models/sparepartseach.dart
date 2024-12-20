class Product {
  final String no;
  final String model;
  // final String productClass;
  final int inventory;
  final String baseUnitOfMeasure;
  // final String vatProdPostingGroup;
  // final String costingMethod;
  // final String vendorNo;
  // final String productGroupCode;
  // final String serviceItemGroup;
  // final int salesPrice;
  final bool priceIncludesVat;
  // final String productImage;

  Product({
    required this.no,
    required this.model,
    // required this.productClass,
    required this.inventory,
    required this.baseUnitOfMeasure,
    // required this.vatProdPostingGroup,
    // required this.costingMethod,
    // required this.vendorNo,
    // required this.productGroupCode,
    // required this.serviceItemGroup,
    // required this.salesPrice,
    required this.priceIncludesVat,
    // required this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      no: json['sp_no'],
      model: json['sp_model'],
      // productClass: json['Class'],
      inventory: int.parse(json['inventory']),
      baseUnitOfMeasure: json['base_unit_of_measure'],
      // vatProdPostingGroup: json['VAT_Prod_Posting_Group'],
      // costingMethod: json['Costing_Method'],
      // vendorNo: json['Vendor_No'],
      // productGroupCode: json['Product_Group_Code'],
      // serviceItemGroup: json['Service_Item_Group'],
      // salesPrice: json['SalesPrice'],
      priceIncludesVat: json['vat_prod_posting_group'] == 'VAT7' ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sp_no': no,
      'sp_model': model,
      // 'Class': productClass,
      'inventory': inventory,
      'base_unit_of_measure': baseUnitOfMeasure,
      // 'VAT_Prod_Posting_Group': vatProdPostingGroup,
      // 'Costing_Method': costingMethod,
      // 'Vendor_No': vendorNo,
      // 'Product_Group_Code': productGroupCode,
      // 'Service_Item_Group': serviceItemGroup,
      // 'SalesPrice': salesPrice,
      'vat_prod_posting_group': priceIncludesVat,
      // 'Product_Image': productImage,
    };
  }
}
