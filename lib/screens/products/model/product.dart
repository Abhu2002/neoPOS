import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? productName;
  final String? productType;
  final String? productDescription;
  final String? productCategory;
  final String? productImage;
  final int? productPrice;
  final bool? productAvailability;

  ProductModel(
      {this.productName,
      this.productType,
      this.productDescription,
      this.productCategory,
      this.productImage,
      this.productPrice,
      this.productAvailability});

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
        productName: data?['product_name'],
        productType: data?['product_type'],
        productDescription: data?['product_description'],
        productCategory: data?['product_category'],
        productImage: data?['product_image'],
        productPrice: data?['product_price'],
        productAvailability: data?['product_availability']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "product_name": productName,
      "product_type": productType,
      "product_description": productDescription,
      "product_category": productCategory,
      "product_image": productImage,
      "product_price": productPrice,
      "product_availability": productAvailability
    };
  }
}
