abstract class ProductDeletionState {}

class InitialProductDeletionState extends ProductDeletionState {}

class ErrorState extends ProductDeletionState {
  final String error;

  ErrorState(this.error);
}

class ConfirmationState extends ProductDeletionState {}

class ProductDeleteState extends ProductDeletionState {}
