abstract class ProductDeletionEvent {}

class CredentialsEnteredEvent extends ProductDeletionEvent {
  final String username;
  final String password;
  final String id;
  CredentialsEnteredEvent(this.username, this.password, this.id);
}

class ConfirmTableDeletionEvent extends ProductDeletionEvent {
  final String id;
  ConfirmTableDeletionEvent(this.id);
}
