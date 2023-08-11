part of 'create_category_bloc.dart';

abstract class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();

  @override
  List<Object> get props => [];
}

class NotNameAvaiableEvent extends CreateCategoryEvent {}

class CreateCategoryFBEvent extends CreateCategoryEvent {
  final String categoryName;

  const CreateCategoryFBEvent(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}