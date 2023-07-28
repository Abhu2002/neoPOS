import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  final String? tablename;
  final int? tableCap;

  TableModel({
    this.tablename,
    this.tableCap,
  });

  factory TableModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TableModel(
      tablename: data?['tablename'],
      tableCap: data?['tableCap'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (tablename != null) "name": tablename,
      if (tableCap != null) "state": tableCap,
    };
  }
}
