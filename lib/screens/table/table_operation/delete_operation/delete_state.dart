abstract class TableDeletionState {}

class InitialTableDeletionState extends TableDeletionState {}

class ErrorState extends TableDeletionState {
  final String error;

  ErrorState(this.error);
}

class ConfirmationState extends TableDeletionState {}

class TableDeleteState extends TableDeletionState {}
