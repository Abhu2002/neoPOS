import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_event.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_state.dart';

class UpdateProductBloc extends Bloc<ProductEvent, ProductState> {
  // Collection reference to the products table..
  final CollectionReference productsCollection =
  FirebaseFirestore.instance.collection('products');

  // firebase storage instance..
  final FirebaseStorage storage = FirebaseStorage.instance;

  // registered event for update product..
  UpdateProductBloc() : super(ProductInitial()) {
    on<UpdateProductEvent>(_mapUpdateProductEventToState);
  }

  // Event for updating products in Firebase FireStore products table..
  Future<void> _mapUpdateProductEventToState(UpdateProductEvent event,
      Emitter<ProductState> emit) async {
    try {
      // getting image download url..
      String imagePath = await _uploadProductImage(event.imageFile);

      await _updateProduct(
        event.productId,
        event.productName,
        event.productPrice,
        event.productDescription,
        event.productUpdatedTime,
        event.productType,
        imagePath,
      );
      emit(ProductUpdated());
    } catch (e) {
      emit(ProductError("Error updating product: $e"));
    }
  }

  // storing image in firebase database..
  Future<String> _uploadProductImage(XFile imageFile) async {
    try {
      Uint8List imageData = await XFile(imageFile.path).readAsBytes();

      String fileName = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      Reference ref = storage.ref().child('product_images/$fileName.jpeg');
      TaskSnapshot snapshot = await ref.putData(imageData);
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  // updating product in firebase fireStore..
  Future<void> _updateProduct(String productId,
      String productName,
      double productPrice,
      String productDescription, String productUpdatedTime, String productType,
      String imagePath) {
    return productsCollection.doc(productId).update({
      'product_name': productName,
      'product_price': productPrice,
      'product_image': imagePath,
      'product_description' : productDescription,
      'product_type' : productType,
      'date_updated' : productUpdatedTime
    });
  }
}
