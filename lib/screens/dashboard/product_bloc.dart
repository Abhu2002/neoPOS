
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';




part 'cart_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<CartEvent, ProductState> {
  ProductBloc() : super(ProductInit()) {
    on<OnStarted>(_loadProduct);
    on<NewItemAdded>(_itemAddedInCart);
    on<ItemRemoved>(_itemRemovedInCart);

  }

  Future<void> _loadProduct(CartEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final list = [];
    emit(ProductLoaded(list, const []));
  }

  void _itemAddedInCart(NewItemAdded event, Emitter<ProductState> emit) {
    List item=[];
   final stateCurrent= (state as ProductLoaded);
   item.addAll(stateCurrent.cartItem);
   item.add(event.item);
   emit(stateCurrent.copyWith(cartItem:item));
  }
  void _itemRemovedInCart(ItemRemoved event, Emitter<ProductState> emit) {
    List item=[];
    final stateCurrent= (state as ProductLoaded);
    item.addAll(stateCurrent.cartItem);
    item.remove(event.item);
    emit(stateCurrent.copyWith(cartItem:item));
  }

}
