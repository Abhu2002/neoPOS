abstract class UpdateUserState {}

class UpdateUserInitialState extends UpdateUserState {}

class UserUpdatingState extends UpdateUserState {}

class UserUpdatedState extends UpdateUserState {}

class UserErrorState extends UpdateUserState {
  final String error;

  UserErrorState(this.error);
}
