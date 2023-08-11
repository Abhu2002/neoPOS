part of 'delete_bloc.dart';
abstract class TableDeletionEvent extends Equatable{}

class CredentialsEnteredEvent extends TableDeletionEvent {
  final String username;
  final String password;
  final String id;
  CredentialsEnteredEvent(this.username, this.password,this.id);
  @override
  List<Object?> get props => [username,password,id];
}

class ConfirmTableDeletionEvent extends TableDeletionEvent {

  final String id;
  ConfirmTableDeletionEvent(this.id);
  @override
  List<Object?> get props => [id];
}
