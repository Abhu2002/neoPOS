part of 'delete_user_bloc.dart';

abstract class UserDeletionState extends Equatable {}

class InitialUserDeletionState extends UserDeletionState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends UserDeletionState {
  ErrorState();
  @override
  List<Object?> get props => [];
}

class ConfirmationState extends UserDeletionState {
  final String id;

  ConfirmationState(this.id);
  @override
  List<Object?> get props => [id];
}

class UserDeleteState extends UserDeletionState {
  @override
  List<Object?> get props => [];
}
