
import 'package:image_picker/image_picker.dart';

abstract class ProductEvent {}

class UpdateProductEvent extends ProductEvent {
  final String productId;
  final String productName;
  final String productDescription;
  final String? productCategory;
  final double productPrice;
  final String productType;
  final String productUpdatedTime;
  final XFile imageFile;

  UpdateProductEvent({
    required this.productId,
    required this.productName,
    required this.productDescription,
    this.productCategory,
    required this.productType,
    required this.productPrice,
    required this.productUpdatedTime,
    required this.imageFile,
  });
}

