import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
part 'table_event.dart';

part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc() : super(TableInitial()) {
    on<InitialEvent>((event, emit) async {
      //t creates it Initially
      try {
        emit(TableReadLoadingState());
        List allCat = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("table").get().then((value) => {
              value.docs.forEach((element) {
                allCat.add({
                  "tablecapacity": '${element['table_capacity']}',
                  "tablename": element['table_name'],
                  "docID": element.id
                });
              })
            });
        LoadDataEvent();
        emit(TableReadLoadedState(
            allCat)); //gives all document of tables to State
      } catch (err) {
        emit(const ErrorState(
            "Some Error Occur")); //calls state and stores message through parameter
      }
    });
  }
}
