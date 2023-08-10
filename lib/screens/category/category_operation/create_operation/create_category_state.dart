part of 'create_category_bloc.dart';

class CreateCategoryState extends Equatable {
  const CreateCategoryState();
  @override
  List<Object> get props => [];
}

class CreateCategoryInitial extends CreateCategoryState {}

class CategoryErrorState extends CreateCategoryState {
  final String errorMessage;
  const CategoryErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class CategoryCreatedState extends CreateCategoryState {
  bool created;
  CategoryCreatedState(this.created);
  @override
  List<Object> get props => [created];
}

class NameNotAvailableState extends CreateCategoryState {}
