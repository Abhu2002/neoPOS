part of 'delete_bloc.dart';

abstract class TableDeletionState extends Equatable {}

class InitialTableDeletionState extends TableDeletionState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends TableDeletionState {
  ErrorState();
  @override
  List<Object?> get props => [];
}

class ConfirmationState extends TableDeletionState {
  final String id;
  ConfirmationState(this.id);
  @override
  List<Object?> get props => [id];
}

class TableDeleteState extends TableDeletionState {
  @override
  List<Object?> get props => [];
}
