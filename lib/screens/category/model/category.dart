import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? categoryName;
  final String? id;
  final int? sr;

  CategoryModel({required this.categoryName, this.id, this.sr});

  factory CategoryModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, int sr) {
    final data = snapshot;
    return CategoryModel(
        categoryName: data['category_name'], id: data.id, sr: sr);
  }

  Map<String, dynamic> toFirestore() {
    return {if (categoryName != null) "category_name": categoryName};
  }
}
