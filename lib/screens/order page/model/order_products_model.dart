class Product {
  final String productCategory;
  final String productName;
  final String productPrice;
  final String productType;
  late String quantity;
  final int? productId;

  Product(
      {required this.productCategory,
      required this.productName,
      required this.productPrice,
      required this.productType,
      required this.quantity,
      this.productId});
}
