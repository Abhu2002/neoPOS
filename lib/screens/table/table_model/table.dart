import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  final String? tableName;
  final int? tableCap;

  TableModel({
    this.tableName,
    this.tableCap,
  });

  factory TableModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TableModel(
      tableName: data?['tablename'],
      tableCap: data?['tableCap'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (tableName != null) "table_name": tableName,
      if (tableCap != null) "table_capacity": tableCap,
    };
  }
}

class LiveTableModel {
  final String? tableName;
final List<Map<String,dynamic>> products;
  LiveTableModel({
    this.tableName,
    required this.products

  });

  factory LiveTableModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return LiveTableModel(
      tableName: data?['tablename'],
      products: data?['products']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (tableName != null) "table_name": tableName,
      if(products!= null) "products":products
    };
  }
}
