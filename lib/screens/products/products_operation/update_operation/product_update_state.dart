import 'package:image_picker/image_picker.dart';

import '../create_operation/create_product_dialog.dart';

abstract class ProductState {
  get category => null;

  get type => null;
  XFile? get imageFile => null;
}

class ProductInitial extends ProductState {}

class ProductUpdated extends ProductState {}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class LoadedCategoryState extends ProductState {
  final List<dynamic> categories;

  LoadedCategoryState(this.categories);
}

class ErrorProductState extends ProductState {
  final String errorMessage;

  ErrorProductState(this.errorMessage);
}

class CategoryChangedState extends ProductState {
  final String category;

  CategoryChangedState(this.category);
}

class ProductTypeUpdateState extends ProductState{
  final ProductType type;

  ProductTypeUpdateState(this.type);
}

class ImageChangedUpdateState extends ProductState {
  final XFile imageFile;

  ImageChangedUpdateState(this.imageFile);
}