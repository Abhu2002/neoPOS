part of 'login_bloc.dart';

enum LoginButtonState { disable, enable, progress }

class LoginState extends Equatable {
  const LoginState({
    this.userId = '',
    this.password = '',
    this.state = LoginButtonState.enable,
    this.canLogin = false,
    this.verifyData = false,
  });

  final String userId;
  final String password;
  final LoginButtonState state;
  final bool canLogin;
  final bool verifyData;

  LoginState copyWith(
      {String? userId,
      String? password,
      LoginButtonState? state,
      bool? canLogin,
      bool? verifyData}) {
    return LoginState(
        userId: userId ?? this.userId,
        password: password ?? this.password,
        state: state ?? this.state,
        verifyData: verifyData ?? this.verifyData,
        canLogin: canLogin ?? this.canLogin);
  }

  @override
  List<Object?> get props => [userId, password, state, canLogin, verifyData];
}
