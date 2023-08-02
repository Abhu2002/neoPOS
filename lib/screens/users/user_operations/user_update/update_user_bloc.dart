import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neopos/screens/users/user_operations/user_update/update_user_event.dart';
import 'package:neopos/screens/users/user_operations/user_update/update_user_state.dart';
import 'package:intl/intl.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  UpdateUserBloc() : super(UpdateUserInitialState()) {
    on<UpdateUserBlocRequested>(_mapUpdateUserBlocRequested);
  }

  Future<void> _mapUpdateUserBlocRequested(
      UpdateUserBlocRequested event, Emitter<UpdateUserState> emit) async {
    emit(UserUpdatingState());
    try {
      // Update the category in Firestore
      await _fireStore.collection("users").doc(event.docId).update({
        "user_id": event.newUserId,
        "first_name": event.newFirstName,
        "last_name": event.newLastName,
        "password": event.newPassword,
        "updated_on":
            "${DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())}"
      });
      emit(UserUpdatedState());
    } catch (e) {
      emit(UserErrorState("Failed to update User."));
    }
  }
}
