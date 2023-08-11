part of 'read_products_bloc.dart';

abstract class ReadProductsEvent extends Equatable {
  const ReadProductsEvent();

  @override
  List<Object> get props => [];
}

class ReadLoadedDataEvent extends ReadProductsEvent {}

class ReadInitialEvent extends ReadProductsEvent {
  bool isFirst;
  ReadInitialEvent(this.isFirst);
}
