part of 'read_products_bloc.dart';

abstract class ReadProductsState extends Equatable {
  const ReadProductsState();

  @override
  List<Object> get props => [];
}

class ReadProductsInitial extends ReadProductsState {}

class ReadDataLoadingState extends ReadProductsState {}

class ReadDataLoadedState extends ReadProductsState {
  final List allProducts;
  const ReadDataLoadedState(this.allProducts);
  @override
  List<Object> get props => [allProducts];
}
class ButtonState extends ReadProductsState{
final SideMenuDisplayMode mod;
const ButtonState(this.mod);
@override
List<Object> get props => [mod];
}

class ReadErrorState extends ReadProductsState {
  final String errorMessage;
  const ReadErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
