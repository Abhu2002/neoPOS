part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserIdChanged extends LoginEvent {
  final String userId;

  UserIdChanged(this.userId);

  @override
  List<Object> get props => [userId];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class OnLogin extends LoginEvent {
  @override
  List<Object> get props => [];
}
