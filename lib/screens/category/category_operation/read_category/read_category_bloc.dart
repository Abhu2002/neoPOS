import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'read_category_event.dart';
part 'read_category_state.dart';

class ReadCategoryBloc extends Bloc<ReadCategoryEvent, ReadCategoryState> {
  ReadCategoryBloc() : super(ReadCategoryInitial()) {
    on<InitialEvent>((event, emit) async {
      try {
        emit(DataLoadingState());
        List allcat = [];
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("category").get().then((value) => {
              value.docs.forEach((element) {
                allcat.add(
                    {"Id": element.id, "Category": element['category_name']});
              })
            });
        LoadDataEvent();
        emit(DataLoadedState(allcat));
      } catch (err) {
        emit(ErrorState("Some Error Occur"));
      }
    });
  }
}
