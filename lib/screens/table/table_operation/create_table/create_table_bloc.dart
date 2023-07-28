import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:neopos/screens/table/Model/table.dart';
// import 'package:flutter/material.dart';

part 'create_table_event.dart';
part 'create_table_state.dart';

class CreateTableBloc extends Bloc<CreateTableEvent, CreateTableState> {
  CreateTableBloc() : super(CreateTableInitial()) {
    on<InputEvent>((event, emit) {
      if (event.tableName == "" && event.tableCap == "") {
        emit(TableErrorState("Please Enter a Name"));
      } else {
        emit(TableNameAvailableState());
      }
    });
    on<CreateTableFBEvent>((event, emit) async {
      // firebase Operation
      // print(event.tableCap);
      try {
        // final data = TableModel(
        //     tablename: event.tableName, tableCap: int.parse(event.tableCap));
        // print(data);
        Map<String, dynamic> data = {
          "table_id": 3,
          "table_name": event.tableName,
          "table_capacity": int.parse(event.tableCap)
        };
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("table").add(data).then((documentSnapshot) =>
            print("Added Data with ID: ${documentSnapshot.id}"));
        await FirebaseFirestore.instance.clearPersistence();
        await FirebaseFirestore.instance.terminate();
      } catch (err) {
        // print("1");
        print(err);
      }
    });
  }
}
