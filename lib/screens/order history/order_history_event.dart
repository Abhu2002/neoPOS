part of 'order_history_bloc.dart';

sealed class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class OrderHistoryPageInitEvent extends OrderHistoryEvent {
  bool isFirst;
  OrderHistoryPageInitEvent(this.isFirst);
}

class ShowOrderProductsEvent extends OrderHistoryEvent {
  String id;
  List allOrders;
  ShowOrderProductsEvent(this.id, this.allOrders);
  @override
  List<Object> get props => [id, allOrders];
}
