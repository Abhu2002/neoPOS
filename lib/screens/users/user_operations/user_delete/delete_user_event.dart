abstract class UserDeletionEvent {}

class UserCredentialsEnteredEvent extends UserDeletionEvent {
  final String username;
  final String password;
  final String id;
  UserCredentialsEnteredEvent(this.username, this.password,this.id);
}

class ConfirmUserDeletionEvent extends UserDeletionEvent {
  final String id;
  ConfirmUserDeletionEvent(this.id);
}
