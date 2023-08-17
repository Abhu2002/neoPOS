part of 'order_history_bloc.dart';

sealed class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class OrderHistoryPageInitEvent extends OrderHistoryEvent {
  bool isfirst;
  OrderHistoryPageInitEvent(this.isfirst);
}

class ShowOrderProductsEvent extends OrderHistoryEvent {
  String id;
  List allOrders;
  bool showORhide = false;
  ShowOrderProductsEvent(this.id, this.allOrders, this.showORhide);
  @override
  List<Object> get props => [id, allOrders];
}

class ChangeVisibilityEvent extends OrderHistoryEvent {
  final bool showORhide;
  final List allOrder;
  final List productList;

  const ChangeVisibilityEvent(this.showORhide, this.allOrder, this.productList);
  @override
  List<Object> get props => [showORhide];
}
