part of 'order_read_bloc.dart';

sealed class OrderReadEvent extends Equatable {
  const OrderReadEvent();

  @override
  List<Object> get props => [];
}

class OrderReadLoadDataEvent extends OrderReadEvent {}

class OrderReadInitialEvent extends OrderReadEvent {
  bool isFirst;
  OrderReadInitialEvent(this.isFirst);
}
