part of 'order_menu_bloc.dart';

abstract class OrderContentState extends Equatable {
  List<String> get allCats => [];

  List<Map<String, dynamic>> get allProds => [];

  get category => null;
}

class InitialState extends OrderContentState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends OrderContentState {
  final List<Map<String, dynamic>> allProds;
  final List<String> allCats;

  ProductLoadingState(this.allProds, this.allCats);

  @override
  List<Object> get props => [allProds, allCats];
}

class FilterProductsState extends OrderContentState {
  final List<Map<String,dynamic>> allProds;
  final List<String> allCats;
  final String category;

  FilterProductsState(this.allProds, this.allCats, this.category);

  @override
  List<Object> get props => [allProds, allCats, category];
}