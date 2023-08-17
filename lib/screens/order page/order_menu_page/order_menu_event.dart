part of 'order_menu_bloc.dart';

abstract class OrderContentEvent extends Equatable {}

class InitialEvent extends OrderContentEvent {
  @override
  List<Object> get props => [];
}

class ProductLoadingEvent extends OrderContentEvent {
  final String tableId;

  ProductLoadingEvent(this.tableId);

  @override
  List<Object?> get props => [tableId];
}

class AddOrderFBEvent extends OrderContentEvent {
  final String productName;
  final String productType;
  final String productCategory;
  final String productPrice;
  final String quantity;
  final String docId;

  AddOrderFBEvent(this.productName, this.productType, this.productCategory,
      this.productPrice, this.quantity, this.docId);

  @override
  List<Object> get props => [
    productName,
    productType,
    productCategory,
    productPrice,
    quantity,
    docId
  ];
}

class CheckoutOrderFBEvent extends OrderContentEvent {
  final String customerName;
  final String customerMbNo;
  final String paymentMode;
  final int totalPrice;
  final String docId;

  CheckoutOrderFBEvent(this.customerName, this.customerMbNo, this.paymentMode,
      this.totalPrice, this.docId);

  @override
  List<Object> get props =>
      [customerName, customerMbNo, paymentMode, totalPrice, docId];
}

class FilterProductsEvent extends OrderContentEvent {
  final String category;
  final List<Map<String, dynamic>> allProds;
  final List<String> allCats;
  final String tableId;

  FilterProductsEvent(this.category, this.allProds, this.allCats, this.tableId);

  @override
  List<Object> get props => [category, allProds, allCats];
}

class DecreaseQuantityEvent extends OrderContentEvent {
  late final int id;
  final String tableId;
  final int quantity;

  DecreaseQuantityEvent(this.id, this.tableId, this.quantity);

  @override
  List<Object?> get props => [id, tableId, quantity];
}

class IncreaseQuantityEvent extends OrderContentEvent {
  late final int id;
  final String tableId;
  final int quantity;

  IncreaseQuantityEvent(this.id, this.tableId, this.quantity);

  @override
  List<Object?> get props => [id, tableId, quantity];
}

class DeleteOrderEvent extends OrderContentEvent {
  final int id;
  final String tableId;

  DeleteOrderEvent(this.id, this.tableId);

  @override
  List<Object?> get props => [id, tableId];
}
