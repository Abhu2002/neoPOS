import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProductModel {
  final String? id;
  final String? productName;
  final String? productType;
  final String? productDescription;
  final String? productCategory;
  final String? productImage;
  final num? productPrice;
  final bool? productAvailability;
  final String? dateAdded;
  final String? dateUpdated;

  static DateTime dateTime = DateTime.now();
  static DateTime date = DateFormat.yMd(dateTime) as DateTime;

  ProductModel({
    this.id,
    this.productName,
    this.productType,
    this.productDescription,
    this.productCategory,
    this.productImage,
    this.productPrice,
    this.productAvailability,
    this.dateAdded,
    this.dateUpdated,
  });

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot;
    return ProductModel(
      id: data.id,
      productName: data['product_name'],
      productType: data['product_type'],
      productDescription: data['product_description'],
      productCategory: data['product_category'],
      productImage: data['product_image'],
      productPrice: data['product_price'],
      productAvailability: data['product_availability'],
      dateAdded: data['date_added'],
      dateUpdated: data['date_updated'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "product_name": productName,
      "product_type": productType,
      "product_description": productDescription,
      "product_category": productCategory,
      "product_image": productImage,
      "product_price": productPrice,
      "product_availability": productAvailability,
      "date_added": dateAdded,
      "date_updated": dateUpdated,
    };
  }
}
