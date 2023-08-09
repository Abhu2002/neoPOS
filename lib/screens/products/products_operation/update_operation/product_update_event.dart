import 'package:image_picker/image_picker.dart';

import '../create_operation/create_product_dialog.dart';

abstract class ProductEvent {}

class InitialCategoryEvent extends ProductEvent {}

class UpdateProductEvent extends ProductEvent {
  final String productId;
  final String productName;
  final String productDescription;
  final String? productCategory;
  final double productPrice;
  final String productType;
  final String productUpdatedTime;
  final String oldImage;
  final XFile? imageFile;

  UpdateProductEvent(
      {required this.productId,
      required this.productName,
      required this.productDescription,
      this.productCategory,
      required this.productType,
      required this.productPrice,
      required this.productUpdatedTime,
      required this.imageFile,
      required this.oldImage});
}

class CategoryChangedEvent extends ProductEvent {
  final String category;

  CategoryChangedEvent(this.category);
}

class LoadingCategoryEvent extends ProductEvent {}

class LoadedCategoryEvent extends ProductEvent {
  final List<String> categories;

  LoadedCategoryEvent(this.categories);
}

class ProductTypeUpdateEvent extends ProductEvent {
  final ProductType type;
  ProductTypeUpdateEvent(this.type);
}

class ImageChangedUpdateEvent extends ProductEvent {
  final XFile imageFile;
  ImageChangedUpdateEvent(this.imageFile);
}
