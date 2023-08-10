abstract class TableDeletionState {}

class InitialTableDeletionState extends TableDeletionState {}

class ErrorState extends TableDeletionState {
  final String error;

  ErrorState(this.error);
}

class ConfirmationState extends TableDeletionState {

  final String id;
  ConfirmationState(this.id);
}

class TableDeleteState extends TableDeletionState {}
