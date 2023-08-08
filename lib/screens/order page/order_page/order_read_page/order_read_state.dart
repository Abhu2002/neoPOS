part of 'order_read_bloc.dart';

sealed class OrderReadState extends Equatable {
  const OrderReadState();

  @override
  List<Object> get props => [];
}

final class OrderReadInitial extends OrderReadState {}

class OrderReadLoadingState extends OrderReadState {}

class OrderReadLoadedState extends OrderReadState {
  final List all;
  const OrderReadLoadedState(
      this.all); //it receives from bloc and store it in properties
  @override
  List<Object> get props => [all];
}

class OrderErrorState extends OrderReadState {
  // it store the errorMesssage
  final String errorMessage;
  const OrderErrorState(this.errorMessage);
}
