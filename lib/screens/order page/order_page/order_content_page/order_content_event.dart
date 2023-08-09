import 'package:equatable/equatable.dart';

abstract class OrderContentEvent extends Equatable {}

class InitialEvent extends OrderContentEvent {
  @override
  List<Object> get props => [];
}

class ProductLoadingEvent extends OrderContentEvent {
  @override
  List<Object> get props => [];
}