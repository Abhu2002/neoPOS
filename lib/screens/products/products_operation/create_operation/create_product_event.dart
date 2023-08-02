part of 'create_product_bloc.dart';

abstract class CreateProductEvent extends Equatable {
  const CreateProductEvent();

  @override
  List<Object> get props => [];
}

class CreateProductFBEvent extends CreateProductEvent {
  final String productName;
  final String productType;
  final String productDescription;
  final String productCategory;
  final String productImage;
  final int productPrice;
  final bool productAvailability;

  const CreateProductFBEvent(
      this.productName,
      this.productType,
      this.productDescription,
      this.productCategory,
      this.productImage,
      this.productPrice,
      this.productAvailability);

  @override
  List<Object> get props => [
        productName,
        productType,
        productDescription,
        productCategory,
        productImage,
        productPrice,
        productAvailability
      ];
}

class InputEvent extends CreateProductEvent {
  final String productName;

  const InputEvent(this.productName);

  @override
  List<Object> get props => [productName];
}

class CategoryLoadedEvent extends CreateProductEvent {
  final List<String> categories;

  const CategoryLoadedEvent(this.categories);

  @override
  List<Object> get props => [categories];
}
