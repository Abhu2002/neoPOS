abstract class ProductDeletionState {}

class InitialProductDeletionState extends ProductDeletionState {}

class ErrorState extends ProductDeletionState {
  final String error;

  ErrorState(this.error);
}

class ConfirmationState extends ProductDeletionState {
  final String id;
  ConfirmationState(this.id);
}

class ProductDeleteState extends ProductDeletionState {}
