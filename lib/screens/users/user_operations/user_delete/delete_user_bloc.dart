import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_user_event.dart';
import 'delete_user_state.dart';

class UserDeletionBloc extends Bloc<UserDeletionEvent, UserDeletionState> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // registered events for credentials check and for deletion of user
  UserDeletionBloc() : super(InitialUserDeletionState()) {
    on<UserCredentialsEnteredEvent>(_mapUserCredentialsEnteredEventToState);
    on<ConfirmUserDeletionEvent>(_mapConfirmUserDeletionEventToState);
  }

  // Events for checking credentials as well as user role
  void _mapUserCredentialsEnteredEventToState(UserCredentialsEnteredEvent event,
      Emitter<UserDeletionState> emit) async {
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

  //Event for deletion
  void _mapConfirmUserDeletionEventToState(
      ConfirmUserDeletionEvent event, Emitter<UserDeletionState> emit) {
    emit(UserDeleteState());
  }

  //delete user based on doc id.
  void deleteUser(String categoryId) async {
    await usersCollection.doc(categoryId).delete();
    add(ConfirmUserDeletionEvent());
  }
}
