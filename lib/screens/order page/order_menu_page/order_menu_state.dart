part of 'order_menu_bloc.dart';

abstract class OrderContentState extends Equatable {
  List<String> get allCats => [];

  List<Map<String, dynamic>> get allProds => [];

  get category => null;

  List<Product> get products => [];
}

class InitialState extends OrderContentState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends OrderContentState {
  @override
  final List<Map<String, dynamic>> allProds;
  @override
  final List<String> allCats;
  @override
  final List<Product> products;

  ProductLoadingState(this.allProds, this.allCats, this.products);

  @override
  List<Object> get props => [allProds!, allCats, products];
}

class FilterProductsState extends OrderContentState {
  @override
  final List<Map<String,dynamic>> allProds;
  @override
  final List<String> allCats;
  @override
  final String category;
  @override
  final List<Product> products;

  FilterProductsState(this.allProds, this.allCats, this.category, this.products);

  @override
  List<Object> get props => [allProds, allCats, category];
}

class ErrorState extends OrderContentState {
  final String errorMessage;

  ErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
