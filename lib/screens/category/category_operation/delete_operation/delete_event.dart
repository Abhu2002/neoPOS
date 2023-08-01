abstract class CategoryDeletionEvent {}

class CredentialsEnteredEvent extends CategoryDeletionEvent {
  final String username;
  final String password;

  CredentialsEnteredEvent(this.username, this.password);
}

class ConfirmTableDeletionEvent extends CategoryDeletionEvent {}
