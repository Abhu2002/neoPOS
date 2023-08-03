part of 'create_user_bloc.dart';

class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object> get props => [];
}

class CreateUserInitial extends CreateUserState {}



class UserNameAvailableState extends CreateUserState {}



class UserErrorState extends CreateUserState {
  final String errorMessage;
  UserErrorState(this.errorMessage);
}

class UserCreatedState extends CreateUserState {}
