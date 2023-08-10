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
class AddOrderFBEvent extends OrderContentEvent {
  final String productName;
  final String productType;
  final String productCategory;
  final String productPrice;
final String quantity;

   AddOrderFBEvent(
      this.productName,
      this.productType,
      this.productCategory,
      this.productPrice,
       this.quantity
  );

  @override
  List<Object> get props => [
    productName,
    productType,
    productCategory,
    productPrice,
  ];}