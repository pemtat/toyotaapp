String checkQuantityStatus(String? partQuantity, String? storeQuantity) {
  final double quantity = double.tryParse(partQuantity ?? '0') ?? 0;
  final double storeQty = double.tryParse(storeQuantity ?? '0') ?? 0;
  return quantity <= storeQty ? 'Ready' : 'Not Ready';
}
