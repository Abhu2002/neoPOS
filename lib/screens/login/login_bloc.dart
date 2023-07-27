import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/utils.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<UserIdChanged>(_onUserIdChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<OnLogin>(_onLogin);
  }

  VoidCallback? onLoginSuccess;
  void Function(String)? showMessage;

  void _onUserIdChanged(UserIdChanged event, Emitter<LoginState> emit) {
    final user_id = event.user_id;
    emit(state.copyWith(
        user_id: user_id.isNotEmpty ? user_id : event.user_id,
        canLogin:
            user_id.isNotEmpty && state.password.isNotEmpty ? true : false));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    emit(state.copyWith(
        password: password.isNotEmpty ? password : event.password,
        canLogin:
            password.isNotEmpty && state.user_id.isNotEmpty ? true : false));
  }

  Future<void> _onLogin(OnLogin event, Emitter<LoginState> emit) async {
    if (!state.user_id.isUserIdValid || !state.password.isPasswordValid) {
      emit(state.copyWith(
          state: LoginButtonState.enable, canLogin: false, verifyData: true));
      return;
    }

    emit(state.copyWith(
        user_id: state.user_id,
        password: state.password,
        state: LoginButtonState.progress,
        canLogin: false));
    try {var result;
      FirebaseFirestore database=FirebaseFirestore.instance;
      database.collection("users").where("user_id",isEqualTo: state.user_id).where("password",isEqualTo: state.password).get().
      then((value){
        print("VALUEEE;;;;;; ${value.size}");
        if(value.size != 0){
        print("Successfully Login ");
        for(var data in value.docs ){
          print('${data.id} => ${data.data()} ');
           result = data.data();
          onLoginSuccess!();
        }}
        else{
          showMessage!("Wrong Credentials");
          print("No data Found");
      }print ("result data....${result["user_id"]}");
      },onError: (e)=> print("Error then ka $e"));
    }
     catch (e) {
       print("Error $e");
    }
    emit(state.copyWith(
        state: LoginButtonState.enable,
        canLogin: false,
        user_id: '',
        password: '',
        verifyData: false));
  }
}
