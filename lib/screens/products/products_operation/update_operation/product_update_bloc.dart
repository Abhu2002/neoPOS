import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';


import '../create_operation/create_product_dialog.dart';

part 'product_update_event.dart';

part 'product_update_state.dart';

class UpdateProductBloc extends Bloc<ProductEvent, ProductState> {
  // Collection reference to the products table..

  void Function(String)? showMessage;
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  // firebase storage instance..
  final FirebaseStorage storage = FirebaseStorage.instance;

  // registered event for update product and reading Categories..
  UpdateProductBloc() : super(ProductInitial()) {
    on<UpdateProductEvent>(_mapUpdateProductEventToState);
    on<InitialCategoryEvent>(_mapCategoryEventToState);
    on<CategoryChangedEvent>(_mapCategoryChangedToState);
    on<ProductTypeUpdateEvent>(_mapProductTypeUpdateToState);
    on<ImageChangedUpdateEvent>(_mapImageChangedUpdateToState);
    on<UpdatingImageEvent>(_mapUpdatingImageToState);
  }

  void _mapImageChangedUpdateToState(
      ImageChangedUpdateEvent event, Emitter<ProductState> emit) {
    emit(ImageChangedUpdateState(event.imageFile));
  }

  void _mapUpdatingImageToState(
      UpdatingImageEvent event, Emitter<ProductState> emit) {
    emit(ProductImageUpdating());
  }

  void _mapProductTypeUpdateToState(
      ProductTypeUpdateEvent event, Emitter<ProductState> emit) {
    emit(ProductTypeUpdateState(event.type));
  }

  void _mapCategoryChangedToState(
      CategoryChangedEvent event, Emitter<ProductState> emit) {
    emit(CategoryChangedState(event.category));
  }

  // Event for Reading Categories..
  Future<void> _mapCategoryEventToState(
      InitialCategoryEvent event, Emitter<ProductState> emit) async {
    try {
      List allcat = [];
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection("category").get().then((value) => {
            value.docs.forEach((element) {
              allcat.add(element['category_name']);
            })
          });
      emit(LoadedCategoryState(allcat));
    } catch (err) {
      emit(ErrorProductState(err.toString()));
    }
  }

  // Event for updating products in Firebase FireStore products table..
  Future<void> _mapUpdateProductEventToState(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    try {
      String imagePath;
      if (event.imageFile != null) {
        imagePath = await _uploadProductImage(event.imageFile!);
      } else {
        imagePath = event.oldImage;
      }
      // getting image download url..

      await _updateProduct(
          event.productId,
          event.productName,
          event.productPrice,
          event.productDescription,
          event.productUpdatedTime,
          event.productType,
          imagePath,
          event.productCategory,
          event.productAvailability);
      emit(ProductUpdated());
      emit(ProductImageUpdated(true));
      showMessage!("Product Updated");
    } catch (e) {
      emit(ProductError("Error updating product: $e"));
    }
  }

  // storing image in firebase database..
  Future<String> _uploadProductImage(XFile imageFile) async {
    try {
      Uint8List imageData = await XFile(imageFile.path).readAsBytes();

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('product_images/$fileName.jpeg');
      TaskSnapshot snapshot = await ref.putData(imageData);
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  // updating product in firebase fireStore..
  Future<void> _updateProduct(
      String productId,
      String productName,
      double productPrice,
      String productDescription,
      String productUpdatedTime,
      String productType,
      String imagePath,
      String productCategory,
      bool productAvailability) {
    return productsCollection.doc(productId).update({
      'product_name': productName,
      'product_price': productPrice,
      'product_image': imagePath,
      'product_description': productDescription,
      'product_type': productType,
      'date_updated': productUpdatedTime,
      'product_category': productCategory,
      'product_availability': productAvailability
    });
  }
}
