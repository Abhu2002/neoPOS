part of 'delete_bloc.dart';

abstract class CategoryDeletionState extends Equatable {}

class InitialCategoryDeletionState extends CategoryDeletionState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends CategoryDeletionState {
  ErrorState();
  @override
  List<Object?> get props => [];
}

class ConfirmationState extends CategoryDeletionState {
  final String id;
  ConfirmationState(this.id);

  @override
  List<Object?> get props => [id];
}

class CategoryDeleteState extends CategoryDeletionState {
  @override
  List<Object?> get props => [];
}
