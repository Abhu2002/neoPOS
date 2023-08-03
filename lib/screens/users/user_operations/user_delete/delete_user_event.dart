abstract class UserDeletionEvent {}

class UserCredentialsEnteredEvent extends UserDeletionEvent {
  final String username;
  final String password;

  UserCredentialsEnteredEvent(this.username, this.password);
}

class ConfirmUserDeletionEvent extends UserDeletionEvent {}
