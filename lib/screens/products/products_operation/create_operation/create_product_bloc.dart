import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../model/product.dart';

part 'create_product_event.dart';

part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  void Function(String)? showMessage;

  CreateProductBloc() : super(CreateProductInitial()) {
    on<CategoryLoadedEvent>((event, emit) async {

    });
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
          final data = ProductModel(
            productName: event.productName,
            productType: event.productType,
            productDescription: event.productDescription,
            productCategory: event.productCategory,
            productImage: event.productImage,
            productPrice: event.productPrice,
            productAvailability: event.productAvailability
          );
          await db.collection("products").add(data.toFirestore()).then(
              (documentSnapshot) => {
                    emit(ProductCreatedState(true)),
                    showMessage!("Product Created")
                  });
          await FirebaseFirestore.instance.clearPersistence();
          await FirebaseFirestore.instance.terminate();
        }
      } catch (err) {
        // print(err);
        throw Exception("Error creating product $err");
      }
    });
  }
}
