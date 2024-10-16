class ProductDetails {
  final String no;
  final String model;
  // final String productClass;
  final int inventory;
  final String baseUnitOfMeasure;
  // final String vatProdPostingGroup;
  final String costingMethod;
  // final String vendorNo;
  // final String productGroupCode;
  // final String serviceItemGroup;
  final int salesPrice;
  final bool priceIncludesVat;
  // final String productImage;

  ProductDetails({
    required this.no,
    required this.model,
    // required this.productClass,
    required this.inventory,
    required this.baseUnitOfMeasure,
    // required this.vatProdPostingGroup,
    required this.costingMethod,
    // required this.vendorNo,
    // required this.productGroupCode,
    // required this.serviceItemGroup,
    required this.salesPrice,
    required this.priceIncludesVat,
    // required this.productImage,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      no: json['No'],
      model: json['Model'],
      // productClass: json['Class'],
      inventory: (json['Inventory'] is double)
          ? (json['Inventory'] as double).toInt()
          : (json['Inventory'] as int),
      baseUnitOfMeasure: json['Base_Unit_of_Measure'],
      // vatProdPostingGroup: json['VAT_Prod_Posting_Group'],
      costingMethod: json['Costing_Method'],
      // vendorNo: json['Vendor_No'],
      // productGroupCode: json['Product_Group_Code'],
      // serviceItemGroup: json['Service_Item_Group'],
      salesPrice: json['SalesPrice'],
      priceIncludesVat: json['Price_Includes_VAT'] is int
          ? json['Price_Includes_VAT'] == 1
          : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'No': no,
      'Model': model,
      // 'Class': productClass,
      'Inventory': inventory,
      'Base_Unit_of_Measure': baseUnitOfMeasure,
      // 'VAT_Prod_Posting_Group': vatProdPostingGroup,
      'Costing_Method': costingMethod,
      // 'Vendor_No': vendorNo,
      // 'Product_Group_Code': productGroupCode,
      // 'Service_Item_Group': serviceItemGroup,
      'SalesPrice': salesPrice,
      'Price_Includes_VAT': priceIncludesVat,
      // 'Product_Image': productImage,
    };
  }
}
