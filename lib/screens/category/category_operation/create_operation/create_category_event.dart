part of 'create_category_bloc.dart';





abstract class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();

  @override
  List<Object> get props => [];
}

class CreateCategoryFBEvent extends CreateCategoryEvent {
  final String categoryName;
  const CreateCategoryFBEvent(this.categoryName);
  List<Object> get props => [categoryName];
}

class InputEvent extends CreateCategoryEvent {
  final String tableName;
  const InputEvent(this.tableName);
  List<Object> get props => [tableName];
}
