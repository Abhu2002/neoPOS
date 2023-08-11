part of 'delete_bloc.dart';

abstract class ProductDeletionState extends Equatable {}

class InitialProductDeletionState extends ProductDeletionState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends ProductDeletionState {
  final String error;

  ErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ConfirmationState extends ProductDeletionState {
  final String id;
  ConfirmationState(this.id);
  @override
  List<Object?> get props => [id];
}

class ProductDeleteState extends ProductDeletionState {
  @override
  List<Object?> get props => [];
}
