import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';
part 'category_update_event.dart';
part 'category_update_state.dart';

class CategoryUpdateBloc extends Bloc<CategoryEvent, CategoryState> {
  final FirebaseFirestore _fireStore = GetIt.I.get<FirebaseFirestore>();
  void Function(String)? showMessage;
  CategoryUpdateBloc() : super(CategoryInitialState()) {
    on<CategoryUpdateRequested>(_mapCategoryUpdateRequested);
  }

  Future<void> _mapCategoryUpdateRequested(
      CategoryUpdateRequested event, Emitter<CategoryState> emit) async {
    emit(CategoryUpdatingState());
    try {
      String oldCat;
      var doc =
          await _fireStore.collection("category").doc(event.categoryId).get();
      var data = doc.data() as Map<String, dynamic>;
      oldCat = data['category_name'];
      var allDocIds = [];

      // get all doc ids of products containing the category
      await _fireStore
          .collection("products")
          .where("product_category", isEqualTo: oldCat)
          .get()
          .then((value) {
        final docSnapshots = value.docs;
        for (var doc in docSnapshots) {
          allDocIds.add(doc.id);
        }
      });

      // Update the category in Firestore
      await _fireStore.collection("category").doc(event.categoryId).update({
        "category_name": event.newName,
      });

      // update all products with new category name
      allDocIds.forEach((docId) async {
        await _fireStore.collection("products").doc(docId).update({
          "product_category": event.newName,
        });
      });
      emit(CategoryUpdatedState());
    } catch (e) {
      throw Exception("Error updating category $e");
    }
  }
}
