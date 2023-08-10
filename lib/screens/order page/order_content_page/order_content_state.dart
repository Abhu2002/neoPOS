import 'package:equatable/equatable.dart';

abstract class OrderContentState extends Equatable {}

class InitialState extends OrderContentState{
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends OrderContentState {
  final List<Map<String,dynamic>> allProds;
  ProductLoadingState(this.allProds);

  @override
  List<Object> get props => [allProds];
}