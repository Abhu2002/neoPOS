import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../model/product.dart';

part 'create_product_event.dart';

part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  void Function(String)? showMessage;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadProductImage(XFile imageFile) async {
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

  CreateProductBloc() : super(CreateProductInitial()) {
    on<InitialEvent>((event, emit) async {
      try {
        List allcat = [];
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("category").get().then((value) => {
              value.docs.forEach((element) {
                allcat.add(element['category_name']);
              })
            });
        emit(CategoryLoadedState(allcat));
      } catch (err) {
        emit(ProductErrorState(err.toString()));
      }
    });
    // on<CategoryLoadingEvent>((event, emit) async {
    //   try {
    //     List allcat = [];
    //     FirebaseFirestore db = FirebaseFirestore.instance;
    //     await db.collection("category").get().then((value) => {
    //       value.docs.forEach((element) {
    //         allcat.add(element['category_name']);
    //       })
    //     });
    //     emit(CategoryLoadedState(allcat));
    //   } catch (err) {
    //     emit(const ProductErrorState("Some Error Occurred While Loading Categories"));
    //   }
    // });
    on<InputEvent>((event, emit) async {
      if (event.productName != "") {
        emit(ProductNameAvailableState());
      } else {
        emit(const ProductErrorState("Please Enter a Name"));
      }
    });
    on<CreateProductFBEvent>((event, emit) async {
      try {
        List allname = [];
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("products").get().then((value) => {
              value.docs.forEach((element) {
                allname.add(element['product_name']);
              })
            });
        if (allname.contains(event.productName)) {
          emit(const ProductErrorState("Product name already exist"));
          showMessage!("Product name already exist. Please use different name");
        } else {
          String imagePath = await uploadProductImage(event.productImage);

          final data = ProductModel(
            productName: event.productName,
            productType: event.productType,
            productDescription: event.productDescription,
            productCategory: event.productCategory,
            productImage: imagePath,
            productPrice: event.productPrice,
            productAvailability: event.productAvailability,
            dateAdded: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
            dateUpdated:
                DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
          );
          await db
              .collection("products")
              .add(data.toFirestore())
              .then((documentSnapshot) => {
                    emit(ProductCreatedState(true)),
                    showMessage!("Product Created"),
                  });
        }
      } catch (err) {
        // print(err);
        throw Exception("Error creating product $err");
      }
    });
  }
}
