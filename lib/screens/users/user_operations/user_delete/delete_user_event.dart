part of 'delete_user_bloc.dart';
abstract class UserDeletionEvent extends Equatable{}

class UserCredentialsEnteredEvent extends UserDeletionEvent {
  final String username;
  final String password;
  final String id;
  UserCredentialsEnteredEvent(this.username, this.password,this.id);

  @override
  List<Object?> get props => [username, password, id];
}

class ConfirmUserDeletionEvent extends UserDeletionEvent {
  final String id;
  ConfirmUserDeletionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
