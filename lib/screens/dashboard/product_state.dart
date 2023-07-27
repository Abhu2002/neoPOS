
part  of'product_bloc.dart';
abstract class ProductState extends Equatable {}

class ProductInit extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List list;
 final  List cartItem;

  ProductLoaded(this.list, this.cartItem);

  @override
  List<Object?> get props => [list,cartItem];

  ProductLoaded copyWith({List? list, List? cartItem}) {
    return ProductLoaded(list ?? this.list, cartItem ?? this.cartItem);
  }
}
