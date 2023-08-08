part of 'create_product_bloc.dart';

abstract class CreateProductEvent extends Equatable {
  const CreateProductEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends CreateProductEvent {}

class ProductCreatingEvent extends CreateProductEvent {}

class CreateProductFBEvent extends CreateProductEvent {
  final String productName;
  final String productType;
  final String productDescription;
  final String productCategory;
  final XFile productImage;
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

class CategoryLoadingEvent extends CreateProductEvent {}

class CategoryLoadedEvent extends CreateProductEvent {
  final List<String> categories;

  const CategoryLoadedEvent(this.categories);

  @override
  List<Object> get props => [categories];
}


class CategoryChangedEvent extends CreateProductEvent {
  final String category;

  const CategoryChangedEvent(this.category);

  @override
  List<Object> get props => [category];
}

class ProductTypeEvent extends CreateProductEvent{
  final ProductType type;
  const ProductTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}

class ProductPriceCheckEvent extends CreateProductEvent {
  final String price;
  const ProductPriceCheckEvent(this.price);

  @override
  List<Object> get props => [price];
}

class ImageChangedEvent extends CreateProductEvent {
  final XFile imageFile;
  const ImageChangedEvent(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}