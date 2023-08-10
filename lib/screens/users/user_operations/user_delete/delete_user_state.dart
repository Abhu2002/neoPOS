abstract class UserDeletionState {}

class InitialUserDeletionState extends UserDeletionState {}

class ErrorState extends UserDeletionState {
  final String error;

  ErrorState(this.error);
}

class ConfirmationState extends UserDeletionState {
  final String id;

  ConfirmationState(this.id);
}

class UserDeleteState extends UserDeletionState {}
