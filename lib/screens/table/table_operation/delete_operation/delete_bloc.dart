import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'delete_event.dart';
import 'delete_state.dart';

class TableDeletionBloc extends Bloc<TableDeletionEvent, TableDeletionState> {
  final CollectionReference usersCollection =
      GetIt.I.get<FirebaseFirestore>().collection('users');
  final CollectionReference tableCollection =
      GetIt.I.get<FirebaseFirestore>().collection('table');
  final CollectionReference liveTableCollection =
  GetIt.I.get<FirebaseFirestore>().collection('live_table');

  TableDeletionBloc() : super(InitialTableDeletionState()) {
    on<CredentialsEnteredEvent>(_mapCredentialsEnteredEventToState);
    on<ConfirmTableDeletionEvent>(_mapConfirmTableDeletionEventToState);
  }

  void _mapCredentialsEnteredEventToState(
      CredentialsEnteredEvent event, Emitter<TableDeletionState> emit) async {
    String username = event.username;
    String password = event.password;

    QuerySnapshot querySnapshot =
        await usersCollection.where('user_id', isEqualTo: username).get();

    if (querySnapshot.size != 0) {
      var userData = querySnapshot.docs[0].data();
      if (userData != null && userData is Map<String, dynamic>) {
        String role = userData['user_role'];

        if (userData['password'] == password && role == 'admin') {
          emit(ConfirmationState());
        } else {
          emit(ErrorState('Invalid credentials or insufficient permissions.'));
        }
      }
    } else {
      emit(ErrorState('Invalid credentials or insufficient permissions.'));
    }
  }

  void _mapConfirmTableDeletionEventToState(
      ConfirmTableDeletionEvent event, Emitter<TableDeletionState> emit) {
    emit(TableDeleteState());
  }

  void deleteTable(String docID) async {
     var liveDocID;
     var livename;
     try {
       var doc = await tableCollection.doc(docID).get();
       var data = doc.data()as Map<String, dynamic>;
       livename = data['table_name'];
       print(livename);
     } catch (e) {
       print("Error getting document: $e");
     }
     //liveDocID = await liveTableCollection.where(['table_name'] ,isEqualTo: livename).get();
    //await liveTableCollection.doc(liveDocID).delete();

     var livedata=await liveTableCollection.where("table_name",isEqualTo: livename).get();
     for (var docSnapshot in livedata.docs) {
        liveDocID = docSnapshot.id;
     }
     print(liveDocID);
     await tableCollection.doc(docID).delete();
     await liveTableCollection.doc(liveDocID).delete();
    add(ConfirmTableDeletionEvent());
  }
}
