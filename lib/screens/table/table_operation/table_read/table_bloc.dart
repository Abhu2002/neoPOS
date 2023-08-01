import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/repository/tables_read.dart';

import '../../../../models/table_model.dart';

part 'table_event.dart';

part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  /*final TablesRepository tablesRepository;

  TablesBloc({required this.tablesRepository}) : super(InitialState()) {
    on<LoadReadSuccessTable>((event, emit) async {
      emit(TableReadLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await tablesRepository.get();
        emit(TableReadLoaded(mytables: data));
      } catch (e) {
        emit(TableError(e.toString()));
      }
    });
  }*/

  TableBloc() : super(TableInitial()) {
    on<InitialEvent>((event, emit) async {
      try {
        emit( TableLoadingState());
        List allcat = [];
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("table").get().then((value) => {
          value.docs.forEach((element) {
            allcat.add(
                { "tablecapacity": '${element['table_capacity']}', "tablename": element['table_name']});
          })
        });
        LoadDataEvent();
        emit(TableLoadedState(allcat));
      } catch (err) {
        emit(ErrorState("Some Error Occur"));
      }
    });
  }
}



