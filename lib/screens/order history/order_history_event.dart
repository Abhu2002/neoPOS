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
  List<Object> get props => [id, allOrders, showORhide];
}

class OrderHistroyFilterEvent extends OrderHistoryEvent {
  final String filter;
  const OrderHistroyFilterEvent(this.filter);
  @override
  List<Object> get props => [filter];
}