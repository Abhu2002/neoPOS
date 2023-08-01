import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'table_deletion_event.dart';
import 'table_deletion_state.dart';

class TableDeletionBloc extends Bloc<TableDeletionEvent, TableDeletionState> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference tablesCollection =
      FirebaseFirestore.instance.collection('table');

  TableDeletionBloc() : super(InitialTableDeletionState()) {
    on<CredentialsEnteredEvent>(_mapCredentialsEnteredEventToState);
    on<ConfirmTableDeletionEvent>(_mapConfirmTableDeletionEventToState);
  }

  void _mapCredentialsEnteredEventToState(
      CredentialsEnteredEvent event, Emitter<TableDeletionState> emit) async {
    String username = event.username;
    String password = event.password;

    QuerySnapshot querySnapshot =
        await usersCollection.where('first_name', isEqualTo: username).get();

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
    emit(TableDeletedState());
  }

  void deleteTable(String tableId) async {
    await tablesCollection.doc(tableId).delete();
    add(ConfirmTableDeletionEvent());
  }
}
