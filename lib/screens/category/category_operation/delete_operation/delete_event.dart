part of 'delete_bloc.dart';

abstract class CategoryDeletionEvent extends Equatable {}

class CredentialsEnteredEvent extends CategoryDeletionEvent {
  final String username;
  final String password;
  final String id;
  CredentialsEnteredEvent(this.username, this.password, this.id);

  @override
  List<Object?> get props => [username, password, id];
}

class ConfirmTableDeletionEvent extends CategoryDeletionEvent {
  final String id;
  ConfirmTableDeletionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
