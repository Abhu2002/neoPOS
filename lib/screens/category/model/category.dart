import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? categoryname;


  CategoryModel({
    this.categoryname,

  });

  factory CategoryModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return CategoryModel(
      categoryname: data?['categoryname'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (categoryname != null) "category_name": categoryname
    };
  }
}