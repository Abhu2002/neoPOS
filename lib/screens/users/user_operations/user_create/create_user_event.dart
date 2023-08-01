part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class CreateUserFBEvent extends CreateUserEvent {
  final String userName;
  final String firstname;
  final String lastname;
  final String password;
  final String userrole;

  const CreateUserFBEvent(this.userName, this.firstname, this.lastname,
      this.password, this.userrole);
  List<Object> get props => [userName, firstname, lastname, password, userrole];
}

class InputEvent extends CreateUserEvent {
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String userRole;
  const InputEvent(this.userName, this.firstName, this.lastName, this.password,
      this.userRole);
  List<Object> get props => [firstName, lastName, userName, password, userRole];
}
