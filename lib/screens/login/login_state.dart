part of 'login_bloc.dart';

enum LoginButtonState { disable, enable, progress }

class LoginState extends Equatable {


  const LoginState(
      {this.user_id = '',
      this.password = '',
      this.state = LoginButtonState.enable,
      this.canLogin = false,
      this.verifyData = false,
  });

  final String user_id;
  final String password;
  final LoginButtonState state;
  final bool canLogin;
  final bool verifyData;

  LoginState copyWith(
      {String? user_id, String? password, LoginButtonState? state, bool? canLogin,bool? verifyData }) {
    return LoginState(
        user_id: user_id ?? this.user_id,
        password: password ?? this.password,
        state: state ?? this.state,
        verifyData:verifyData??this.verifyData,
        canLogin: canLogin ?? this.canLogin);
  }

  @override
  List<Object?> get props => [user_id, password, state, canLogin,verifyData];
}
