import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'category_update_event.dart';
import 'category_update_state.dart';

class CategoryUpdateBloc extends Bloc<CategoryEvent, CategoryState> {
  final FirebaseFirestore _fireStore = GetIt.I.get<FirebaseFirestore>();

  CategoryUpdateBloc() : super(CategoryInitialState()) {
    on<CategoryUpdateRequested>(_mapCategoryUpdateRequested);
  }

  Future<void> _mapCategoryUpdateRequested(
      CategoryUpdateRequested event, Emitter<CategoryState> emit) async {
    emit(CategoryUpdatingState());
    try {
      // Update the category in Firestore
      await _fireStore.collection("category").doc(event.categoryId).update({
        "category_name": event.newName,
      });
      emit(CategoryUpdatedState());
    } catch (e) {
      emit(CategoryErrorState("Failed to update category."));
    }
  }
}
