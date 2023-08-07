part of 'create_product_bloc.dart';

class CreateProductState extends Equatable {
  const CreateProductState();

  @override
  List<Object> get props => [];
}

class CreateProductInitial extends CreateProductState {}

class CategoryLoadingState extends CreateProductState {}

class CategoryLoadedState extends CreateProductState {
  final List<dynamic> categories;

  const CategoryLoadedState(this.categories);

  @override
  List<Object> get props => [categories];
}

class ProductNameAvailableState extends CreateProductState {}

class ProductErrorState extends CreateProductState {
  final String errorMessage;

  const ProductErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ProductCreatedState extends CreateProductState {
  bool created;

  ProductCreatedState(this.created);

  @override
  List<Object> get props => [created];
}
