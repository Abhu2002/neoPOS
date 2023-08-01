import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:neopos/models/table_model.dart';

class TablesRepository {
  final _firecloud = FirebaseFirestore.instance.collection("table");

  Future<List<TableModel>> get() async {
    List<TableModel> tablemodellist = [];
    try {
      final conn = await _firecloud.get();
      conn.docs.forEach((element) {
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

  Future<void> create({required String name, required String price}) async {
    try {
      await _firecloud.add({"name": name, "price": price});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
