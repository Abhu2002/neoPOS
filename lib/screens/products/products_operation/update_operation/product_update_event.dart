part of 'product_update_bloc.dart';

abstract class ProductEvent extends Equatable {}

class InitialCategoryEvent extends ProductEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProductEvent extends ProductEvent {
  final String productId;
  final String productName;
  final String productDescription;
  final String productCategory;
  final double productPrice;
  final String productType;
  final String productUpdatedTime;
  final String oldImage;
  final XFile? imageFile;
  final bool productAvailability;
  UpdateProductEvent(
      {required this.productId,
      required this.productName,
      required this.productDescription,
      required this.productCategory,
      required this.productType,
      required this.productPrice,
      required this.productUpdatedTime,
      required this.imageFile,
      required this.oldImage,
      required this.productAvailability});

  @override
  List<Object?> get props => [
        productId,
        productName,
        productDescription,
        productCategory,
        productPrice,
        productType,
        productUpdatedTime,
        oldImage,
        imageFile
      ];
}

class CategoryChangedEvent extends ProductEvent {
  final String category;

  CategoryChangedEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class LoadingCategoryEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class LoadedCategoryEvent extends ProductEvent {
  final List<String> categories;

  LoadedCategoryEvent(this.categories);

  @override
  List<Object?> get props => [categories];
}

class ProductTypeUpdateEvent extends ProductEvent {
  final ProductType type;
  ProductTypeUpdateEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class ImageChangedUpdateEvent extends ProductEvent {
  final XFile imageFile;
  ImageChangedUpdateEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class UpdatingImageEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class CheckboxStateChangedEvent extends ProductEvent {
  final bool isChecked;

  CheckboxStateChangedEvent(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}
