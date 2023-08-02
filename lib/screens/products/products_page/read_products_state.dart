part of 'read_products_bloc.dart';

abstract class ReadProductsState extends Equatable {
  const ReadProductsState();
  
  @override
  List<Object> get props => [];
}

class ReadProductsInitial extends ReadProductsState {}
