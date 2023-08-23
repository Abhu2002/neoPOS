part of 'order_menu_bloc.dart';

abstract class OrderContentState extends Equatable {
  List<String> get allCats => [];

  List<Map<String, dynamic>> get allProds => [];

  get category => null;

  bool get showORhide => true;

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

  @override
  bool showORhide;
  ProductLoadingState(
      this.allProds, this.allCats, this.products, this.showORhide);

  @override
  List<Object> get props => [allProds, allCats, products, showORhide];
}

class FilterProductsState extends OrderContentState {
  @override
  final List<Map<String, dynamic>> allProds;
  @override
  final List<String> allCats;
  @override
  final String category;
  @override
  final List<Product> products;
  @override
  bool get showORhide => false;

  FilterProductsState(
      this.allProds, this.allCats, this.category, this.products);

  @override
  List<Object> get props => [allProds, allCats, category];
}

class ErrorState extends OrderContentState {
  final String errorMessage;

  ErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
