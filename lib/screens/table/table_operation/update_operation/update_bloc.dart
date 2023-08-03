import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'update_event.dart';
import 'update_state.dart';
import 'package:get_it/get_it.dart';

class TableUpdateBloc extends Bloc<TableEvent, TableState> {
  final FirebaseFirestore _fireStore = GetIt.I.get<FirebaseFirestore>();

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
      emit(TableErrorState("Failed to update table."));
    }
  }
}
