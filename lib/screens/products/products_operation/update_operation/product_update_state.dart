abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductUpdated extends ProductState {}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
