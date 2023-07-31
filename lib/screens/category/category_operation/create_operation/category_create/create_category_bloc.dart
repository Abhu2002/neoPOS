import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../model/category.dart';

// import 'package:flutter/material.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  void Function(String)? showMessage;
  CreateCategoryBloc() : super(CreateCategoryInitial()) {
    on<InputEvent>((event, emit) async {
      if (event.tableName != "") {
        emit(CategoryNameAvailableState());
      } else {
        emit(CategoryErrorState("Please Enter a Name"));
      }
    });
    on<CreateCategoryFBEvent>((event, emit) async {
      try {
        List allname = [];
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("category").get().then((value) => {
              value.docs.forEach((element) {
                allname.add(element['category_name']);
              })
            });
        if (allname.contains(event.categoryName)) {
          emit(CategoryErrorState("Please Pop"));
          showMessage!("Category Name Exist Please use Different Name");
        } else {
          final data = CategoryModel(categoryname: event.categoryName);
          await db.collection("category").add(data.toFirestore()).then(
              (documentSnapshot) => {
                    emit(CategoryCreatedState()),
                    showMessage!("Category Created")
                  });
          await FirebaseFirestore.instance.clearPersistence();
          await FirebaseFirestore.instance.terminate();
        }
      } catch (err) {
        // print(err);
      }
    });
  }
}
