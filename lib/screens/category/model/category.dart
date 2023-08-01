import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? categoryName;

  CategoryModel({
    this.categoryName,
  });

  factory CategoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CategoryModel(
      categoryName: data?['categoryname'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {if (categoryName != null) "category_name": categoryName};
  }
}
