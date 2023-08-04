abstract class ProductDeletionEvent {}

class CredentialsEnteredEvent extends ProductDeletionEvent {
  final String username;
  final String password;

  CredentialsEnteredEvent(this.username, this.password);
}

class ConfirmTableDeletionEvent extends ProductDeletionEvent {}
