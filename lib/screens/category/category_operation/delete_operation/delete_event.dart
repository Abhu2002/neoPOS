part of 'delete_bloc.dart';

abstract class CategoryDeletionEvent extends Equatable {}

class CredentialsEnteredEvent extends CategoryDeletionEvent {
  final String username;
  final String password;
  final String id;
  final String categoryName;
  CredentialsEnteredEvent(this.username, this.password, this.id, this.categoryName);

  @override
  List<Object?> get props => [username, password, id];
}

class ConfirmTableDeletionEvent extends CategoryDeletionEvent {
  final String id;
  final String name;
  ConfirmTableDeletionEvent(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}
