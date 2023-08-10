abstract class TableDeletionEvent {}

class CredentialsEnteredEvent extends TableDeletionEvent {
  final String username;
  final String password;
  final String id;
  CredentialsEnteredEvent(this.username, this.password,this.id);
}

class ConfirmTableDeletionEvent extends TableDeletionEvent {

  final String id;
  ConfirmTableDeletionEvent(this.id);


}
