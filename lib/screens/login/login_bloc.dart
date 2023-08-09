import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
    final userId = event.userId;
    emit(state.copyWith(
        userId: userId.isNotEmpty ? userId : event.userId,
        canLogin:
            userId.isNotEmpty && state.password.isNotEmpty ? true : false));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    emit(state.copyWith(
        password: password.isNotEmpty ? password : event.password,
        canLogin:
            password.isNotEmpty && state.userId.isNotEmpty ? true : false));
  }

  Future<void> _onLogin(OnLogin event, Emitter<LoginState> emit) async {
    if (!state.userId.isNotEmptyValidator || !state.password.isValidPassword) {
      emit(state.copyWith(
          state: LoginButtonState.enable, canLogin: false, verifyData: true));
      return;
    }

    emit(state.copyWith(
        userId: state.userId,
        password: state.password,
        state: LoginButtonState.progress,
        canLogin: false));
    try {
      /// TODO: Use result later
      var result;
      FirebaseFirestore database = GetIt.I.get<FirebaseFirestore>();
      database
          .collection("users")
          .where("user_id", isEqualTo: state.userId)
          .where("password", isEqualTo: state.password)
          .get()
          .then((value) {
        if (value.size != 0) {
          for (var data in value.docs) {
            result = data.data();
            onLoginSuccess!();
          }
        } else {
          showMessage!("Invalid Credentials");
        }
      }, onError: (e) {});
    } catch (e) {
      showMessage!("Wrong Credentials");
    }
    emit(state.copyWith(
        state: LoginButtonState.enable,
        canLogin: false,
        userId: '',
        password: '',
        verifyData: false));
  }
}
