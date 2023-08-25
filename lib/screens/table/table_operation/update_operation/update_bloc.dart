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
  final CollectionReference tableCollection =
  GetIt.I.get<FirebaseFirestore>().collection('table');
  final CollectionReference liveTableCollection =
  GetIt.I.get<FirebaseFirestore>().collection('live_table');
  TableUpdateBloc() : super(TableInitialState()) {
    on<TableUpdateRequested>(_mapTableUpdateRequested);
  }

  Future<void> _mapTableUpdateRequested(
      TableUpdateRequested event, Emitter<TableState> emit) async {
    emit(TableUpdatingState());
    try {
      var liveDocID;
      var livename;
      var doc = await tableCollection.doc(event.tableId).get();
      var data = doc.data() as Map<String, dynamic>;
      livename = data['table_name'];
      var livedata = await liveTableCollection
          .where("table_name", isEqualTo: livename)
          .get();
      for (var docSnapshot in livedata.docs) {
        liveDocID = docSnapshot.id;
      }
      // Update the Table in Firestore
      await _fireStore.collection("table").doc(event.tableId).update({
        "table_name": event.newName,
        "table_capacity": int.parse(event.newCapacity)
      });
      await _fireStore.collection("live_table").doc(liveDocID).update({
        "table_name": event.newName
      });
      emit(TableUpdatedState());
    } catch (e) {
      throw Exception("Error creating product $e");
    }
  }
}
