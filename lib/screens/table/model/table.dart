import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  final String? tableName;
  final String? id;
  final int? tableCap;

  TableModel({required this.tableName, this.id, this.tableCap});

  factory TableModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return TableModel(
        tableName: data['table_name'],
        id: data.id,
        tableCap: data['table_capacity']);
  }
}
