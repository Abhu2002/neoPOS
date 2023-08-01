abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryUpdatingState extends CategoryState {}

class CategoryUpdatedState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState(this.error);
}
