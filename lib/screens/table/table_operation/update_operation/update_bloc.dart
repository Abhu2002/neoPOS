import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';

part 'update_event.dart';
part 'update_state.dart';

class TableUpdateBloc extends Bloc<TableEvent, TableState> {
  final FirebaseFirestore _fireStore = GetIt.I.get<FirebaseFirestore>();
  void Function(String)? showMessage;
  TableUpdateBloc() : super(TableInitialState()) {
    on<TableUpdateRequested>(_mapTableUpdateRequested);
  }

  Future<void> _mapTableUpdateRequested(
      TableUpdateRequested event, Emitter<TableState> emit) async {
    emit(TableUpdatingState());
    try {
      // Update the Table in Firestore
      await _fireStore.collection("table").doc(event.tableId).update(
          {"table_name": event.newName, "table_capacity": event.newCapacity});
      emit(TableUpdatedState());
    } catch (e) {
      showMessage!("$e");
    }
  }
}
