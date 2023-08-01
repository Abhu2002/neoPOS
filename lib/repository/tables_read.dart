import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:neopos/models/table_model.dart';

class TablesRepository {
  final _firecloud = FirebaseFirestore.instance.collection("table");  //directly reading collection from table

  Future<List<TableModel>> get() async {  //it read each collection from table and retrieving json object
    List<TableModel> tablemodellist = [];
    try {
      final conn = await _firecloud.get();
      conn.docs.forEach((element) { // each document is iterated
        return tablemodellist.add(TableModel.fromJson(element.data()));
      });
      return tablemodellist;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}':${e.message}");
      }
      return tablemodellist;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
