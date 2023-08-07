abstract class ProductState {
  get category => null;
}

class ProductInitial extends ProductState {}

class ProductUpdated extends ProductState {}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class LoadedCategoryState extends ProductState {
  final List<dynamic> categories;

  LoadedCategoryState(this.categories);
}

class ErrorProductState extends ProductState {
  final String errorMessage;

  ErrorProductState(this.errorMessage);
}

class CategoryChangedState extends ProductState {
  final String category;

  CategoryChangedState(this.category);
}