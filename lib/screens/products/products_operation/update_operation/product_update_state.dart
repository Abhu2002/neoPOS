import 'package:image_picker/image_picker.dart';

abstract class UpdateProductState {
  XFile? get imageFile => null;
}

class ProductInitial extends UpdateProductState {}

class ProductUpdated extends UpdateProductState {}

class ProductError extends UpdateProductState {
  final String message;

  ProductError(this.message);
}
