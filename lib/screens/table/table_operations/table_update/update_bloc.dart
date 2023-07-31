import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neopos/utils/utils.dart';

part 'update_event.dart';

part 'update_state.dart';

class UpdateTableBloc extends Bloc<UpdateEvent, UpdateTableState> {
  UpdateTableBloc() : super(const UpdateTableState()) {
    on<TableIdChanged>(_onTableIdChanged);
    on<TableNameChanged>(_onTableNameChanged);
    on<TableCapacityChanged>(_onTableCapacityChanged);
    on<OnUpdate>(_onUpdate);
  }

  VoidCallback? onUpdateSuccess;
  void Function(String)? showMessage;

  void _onTableIdChanged(TableIdChanged event, Emitter<UpdateTableState> emit) {
    final tableId = event.tableId;
    emit(state.copyWith(
        tableId: tableId.isNotEmpty ? tableId : event.tableId,
        canUpdate: tableId.isNotEmpty &&
            state.tableName.isNotEmpty &&
            state.tableCapacity
                .toString()
                .isNotEmpty
            ? true
            : false));
  }

  void _onTableNameChanged(TableNameChanged event,
      Emitter<UpdateTableState> emit) {
    final tableName = event.tableName;
    emit(state.copyWith(
        tableName: tableName.isNotEmpty ? tableName : event.tableName,
        canUpdate: tableName.isNotEmpty &&
            state.tableId.isNotEmpty &&
            state.tableCapacity
                .toString()
                .isNotEmpty
            ? true
            : false));
  }

  void _onTableCapacityChanged(TableCapacityChanged event,
      Emitter<UpdateTableState> emit) {
    final tableCapacity = event.tableCapacity;
    emit(state.copyWith(
        tableCapacity: tableCapacity
            .toString()
            .isNotEmpty
            ? tableCapacity
            : event.tableCapacity,
        canUpdate: tableCapacity
            .toString()
            .isNotEmpty &&
            state.tableId.isNotEmpty &&
            state.tableName.isNotEmpty
            ? true
            : false));
  }


  Future<void> _onUpdate(OnUpdate event, Emitter<UpdateTableState> emit) async {
    if (!state.tableId.isNotEmptyValidator ||
        !state.tableName.isNotEmptyValidator ||
        !state.tableCapacity
            .toString()
            .isNotEmptyValidator) {
      emit(state.copyWith(
          state: UpdateButtonState.enable, canUpdate: false, verifyData: true));
      return;
    }

    emit(state.copyWith(
        tableId: state.tableId,
        tableName: state.tableName,
        state: UpdateButtonState.progress,
        canUpdate: false));
    try {
      /// TODO: Use result later
      // var result;
      var id;
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("table").get().then((querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');

            if(docSnapshot.id == "U2jiN2etD0vSw6HAh1Lh") {
              id = docSnapshot.id;
              break;
            }
          }

          db.collection("table").doc(id).update({
                  "table_name": state.tableName,
                  "table_capacity": state.tableCapacity,
                }).then(
                        (value) {
                          // print("Document updated successfully");
                          showMessage!("Table Updated Successfully!");
                          onUpdateSuccess!();
                        },
                    onError: (e) => showMessage!("Error updating table $e"));
      });

      // FirebaseFirestore database = FirebaseFirestore.instance;
      // database
      //     .collection("table")
      //     .where("id", isEqualTo: '7TfirNLKPsQwev6Rq5OJ')
      //     .get()
      //     .then((value) {
      //       var id;
      //   if (value.size != 0) {
      //     for (var data in value.docs) {
      //       id = data.id;
      //       result = data.data();
      //       onUpdateSuccess!();
      //     }
      //
      //     database.collection("table").doc("$id").update({
      //       "table_name": state.tableName,
      //       "table_capacity": state.tableCapacity,
      //     }).then(
      //             (value) => print("Document updated successfully"),
      //         onError: (e) => print("Error updating document $e"));
      //   } else {
      //     showMessage!("No such table");
      //   }
      // }, onError: (e) {});
    } catch (e) {
      showMessage!("Wrong Credentials");
    }
    emit(state.copyWith(
        tableId: state.tableId,
        tableName: state.tableName,
        state: UpdateButtonState.progress,
        canUpdate: false));
  }
}
