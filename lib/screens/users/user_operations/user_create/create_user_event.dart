part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class UserInitialEvent extends CreateUserEvent {}

class CreateUserFBEvent extends CreateUserEvent {
  final String userid;
  final String firstName;
  final String lastName;
  final String password;
  final String userRole;

  const CreateUserFBEvent(
      this.userid, this.firstName, this.lastName, this.password, this.userRole);
  @override
  List<Object> get props => [userid, firstName, lastName, password, userRole];
}
