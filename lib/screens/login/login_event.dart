
part of 'login_bloc.dart';
abstract class LoginEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class UserIdChanged extends LoginEvent{
  final String user_id;
  UserIdChanged(this.user_id);

  @override
  List<Object> get props => [user_id];
}

class PasswordChanged extends LoginEvent{
  final String password;
  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class OnLogin extends LoginEvent{

  @override
  List<Object> get props => [];
}