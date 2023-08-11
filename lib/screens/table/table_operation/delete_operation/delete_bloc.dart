import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';
part  'delete_event.dart';
part  'delete_state.dart';

class TableDeletionBloc extends Bloc<TableDeletionEvent, TableDeletionState> {
  final CollectionReference usersCollection =
      GetIt.I.get<FirebaseFirestore>().collection('users');
  final CollectionReference tableCollection =
      GetIt.I.get<FirebaseFirestore>().collection('table');
  final CollectionReference liveTableCollection =
      GetIt.I.get<FirebaseFirestore>().collection('live_table');
  void Function(String)? showMessage;

  TableDeletionBloc() : super(InitialTableDeletionState()) {
    on<CredentialsEnteredEvent>(_mapCredentialsEnteredEventToState);
    on<ConfirmTableDeletionEvent>(_mapConfirmTableDeletionEventToState);
  }

  void _mapCredentialsEnteredEventToState(
      CredentialsEnteredEvent event, Emitter<TableDeletionState> emit) async {

    var liveDocID;
    var livename;
    String username = event.username;
    String password = event.password;
    String  docId = event.id;


    QuerySnapshot querySnapshot =
        await usersCollection.where('user_id', isEqualTo: username).get();

    if (querySnapshot.size != 0) {
      var userData = querySnapshot.docs[0].data();
      if (userData != null && userData is Map<String, dynamic>) {
        String role = userData['user_role'];

        if (userData['password'] == password && role == 'admin') {
          try {
            var doc = await tableCollection.doc(docId).get();
            var data = doc.data() as Map<String, dynamic>;
            livename = data['table_name'];
          } catch (e) {
            throw Exception("Error: $e");
          }

          var livedata = await liveTableCollection
              .where("table_name", isEqualTo: livename)
              .get();
          for (var docSnapshot in livedata.docs) {
            liveDocID = docSnapshot.id;
          }

          await tableCollection.doc(docId).delete();
          emit(TableDeleteState());
          await liveTableCollection.doc(liveDocID).delete();
        }
         else {
          emit(ErrorState());
        }
      }
    } else {
      emit(ErrorState());
    }
  }

  void _mapConfirmTableDeletionEventToState(
      ConfirmTableDeletionEvent event, Emitter<TableDeletionState> emit) {
    emit(ConfirmationState(event.id));
  }
}
