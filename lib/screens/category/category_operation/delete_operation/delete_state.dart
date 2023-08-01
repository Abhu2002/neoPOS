abstract class CategoryDeletionState {}

class InitialCategoryDeletionState extends CategoryDeletionState {}

class ErrorState extends CategoryDeletionState {
  final String error;

  ErrorState(this.error);
}

class ConfirmationState extends CategoryDeletionState {}

class CategoryDeleteState extends CategoryDeletionState {}
