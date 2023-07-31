import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:neopos/screens/table/Model/table.dart';
// import 'package:flutter/material.dart';

part 'create_table_event.dart';
part 'create_table_state.dart';

class CreateTableBloc extends Bloc<CreateTableEvent, CreateTableState> {
  void Function(String)? showMessage;
  CreateTableBloc() : super(CreateTableInitial()) {
    on<InputEvent>((event, emit) async {
      if (event.tableName != "") {
        if (event.tableCap != "") {
          if (int.tryParse(event.tableCap) == null) {
            emit(TableErrorState("Please Enter Number"));
          } else {
            emit(TableNameAvailableState());
          }
        } else {
          emit(TableErrorState("Please Enter a Capacity"));
        }
      } else {
        emit(TableErrorState("Please Enter a Name"));
      }
    });
    on<CreateTableFBEvent>((event, emit) async {
      try {
        List allname = [];
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("table").get().then((value) => {
              value.docs.forEach((element) {
                allname.add(element['table_name']);
              })
            });
        if (allname.contains(event.tableName)) {
          emit(TableErrorState("Please Pop"));
          showMessage!("Table Name Exist Please use Different Name");
        } else {
          final data = TableModel(
              tablename: event.tableName, tableCap: int.parse(event.tableCap));
          await db.collection("table").add(data.toFirestore()).then(
              (documentSnapshot) =>
                  {emit(TableCreatedState()), showMessage!("Table Created")});
          await FirebaseFirestore.instance.clearPersistence();
          await FirebaseFirestore.instance.terminate();
        }
      } catch (err) {
        // print(err);
      }
    });
  }
}
