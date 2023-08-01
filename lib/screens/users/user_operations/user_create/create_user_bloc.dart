import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../model/user.dart';

// import 'package:flutter/material.dart';

part 'create_user_event.dart';

part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  void Function(String)? showMessage;

  CreateUserBloc() : super(CreateUserInitial()) {
    on<InputEvent>((event, emit) async {
      if (event.userName != "") {
        emit(UserNameAvailableState());
      } else {
        emit(UserErrorState("Please Enter a Name"));
      }
    });
    on<CreateUserFBEvent>((event, emit) async {
      try {
        List allname = [];
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("users").get().then((value) => {
              value.docs.forEach((element) {
                allname.add(element['user_id']);
              })
            });
        if (allname.contains(event.userName)) {
          emit(UserErrorState("Please Pop"));
          showMessage!("User Name Exist Please use Different Name");
        } else {
          final data = UserModel(
              username: event.userName,
              firstname: event.firstname,
              lastname: event.lastname,
              password: event.password,
              userrole: event.userrole,
              addedon:
                  "${DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())}",
              updatedon:
                  "${DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())}");
          await db.collection("users").add(data.toFirestore()).then(
              (documentSnapshot) =>
                  {emit(UserCreatedState()), showMessage!("User Created")});
          await FirebaseFirestore.instance.clearPersistence();
          await FirebaseFirestore.instance.terminate();
        }
      } catch (err) {
        // print(err);
      }
    });
  }
}
