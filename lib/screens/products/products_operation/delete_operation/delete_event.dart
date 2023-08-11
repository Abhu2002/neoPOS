part of 'delete_bloc.dart';
abstract class ProductDeletionEvent extends Equatable{}

class CredentialsEnteredEvent extends ProductDeletionEvent {
  final String username;
  final String password;
  final String id;
  CredentialsEnteredEvent(this.username, this.password, this.id);

  @override
  List<Object?> get props => [username,password,id];
}

class ConfirmTableDeletionEvent extends ProductDeletionEvent {
  final String id;
  ConfirmTableDeletionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
