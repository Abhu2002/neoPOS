import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/utils.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<OnLogin>(_onLogin);
  }

  VoidCallback? onLoginSuccess;
  void Function(String)? showMessage;

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = event.email;
    emit(state.copyWith(
        email: email.isNotEmpty ? email : event.email,
        canLogin:
            email.isNotEmpty && state.password.isNotEmpty ? true : false));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    emit(state.copyWith(
        password: password.isNotEmpty ? password : event.password,
        canLogin:
            password.isNotEmpty && state.email.isNotEmpty ? true : false));
  }

  Future<void> _onLogin(OnLogin event, Emitter<LoginState> emit) async {
    if (!state.email.isEmailValid || !state.password.isPasswordValid) {
      emit(state.copyWith(
          state: LoginButtonState.enable, canLogin: false, verifyData: true));
      return;
    }

    emit(state.copyWith(
        email: state.email,
        password: state.password,
        state: LoginButtonState.progress,
        canLogin: false));
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.email, password: state.password);
      if ((credential.user?.email ?? "").isNotEmpty == true &&
          onLoginSuccess != null) {
        onLoginSuccess!();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (showMessage != null) showMessage!('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        if (showMessage != null) {
          showMessage!('Wrong password provided for that user.');
        }
      }
    }
    emit(state.copyWith(
        state: LoginButtonState.enable,
        canLogin: false,
        email: '',
        password: '',
        verifyData: false));
  }
}
