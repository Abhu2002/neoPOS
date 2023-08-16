part of 'create_category_bloc.dart';

class CreateCategoryState extends Equatable {
  const CreateCategoryState();
  @override
  List<Object> get props => [];
}

class CreateCategoryInitial extends CreateCategoryState {}

class CategoryCreatedState extends CreateCategoryState {
  // extends immutable class but needs to be mutable
  bool created;
  CategoryCreatedState(this.created);
  @override
  List<Object> get props => [created];
}

class NameNotAvailableState extends CreateCategoryState {}
