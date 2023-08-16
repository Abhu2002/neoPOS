part of 'order_history_bloc.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  num get amount => 0;
  String get orderId => "";
  List get allOrder => [];
  List get productList => [];
  @override
  List<Object> get props => [];
}

final class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistoryLoaded extends OrderHistoryState {
  final List allOrder;
  final List productList;
  const OrderHistoryLoaded(this.allOrder, this.productList);
  @override
  List<Object> get props => [allOrder, productList];
}

class OrderHistoryErrorState extends OrderHistoryState {
  final String errorMessage;
  const OrderHistoryErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class ShowProductsState extends OrderHistoryState {
  final List productList;
  final List allOrder;
  final num amount;
  final String orderId;
  ShowProductsState(this.allOrder, this.productList, this.amount, this.orderId);

  @override
  List<Object> get props => [allOrder, productList, amount];
}

