part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class CreateUserFBEvent extends CreateUserEvent {
  final String userName;
  final String firstName;
  final String lastName;
  final String password;
  final String userRole;

  const CreateUserFBEvent(this.userName, this.firstName, this.lastName,
      this.password, this.userRole);
  @override
  List<Object> get props => [userName, firstName, lastName, password, userRole];
}

class InputEvent extends CreateUserEvent {
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String userRole;
  const InputEvent(this.userName, this.firstName, this.lastName, this.password,
      this.userRole);
  @override
  List<Object> get props => [firstName, lastName, userName, password, userRole];
}
