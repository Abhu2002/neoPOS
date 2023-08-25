part of 'delete_bloc.dart';

abstract class CategoryDeletionState extends Equatable {}

class InitialCategoryDeletionState extends CategoryDeletionState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends CategoryDeletionState {
  String errorMessage;
  ErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class ConfirmationState extends CategoryDeletionState {
  final String id;
  final String categoyName;
  ConfirmationState(this.id, this.categoyName);

  @override
  List<Object?> get props => [id, categoyName];
}

class CategoryDeleteState extends CategoryDeletionState {
  @override
  List<Object?> get props => [];
}
