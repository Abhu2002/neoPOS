abstract class TableDeletionEvent {}

class CredentialsEnteredEvent extends TableDeletionEvent {
  final String username;
  final String password;

  CredentialsEnteredEvent(this.username, this.password);
}

class ConfirmTableDeletionEvent extends TableDeletionEvent {}
