import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';

part 'order_menu_event.dart';
part 'order_menu_state.dart';

class OrderContentBloc extends Bloc<OrderContentEvent, OrderContentState> {
  OrderContentBloc() : super(InitialState()) {
    on<ProductLoadingEvent>((event, emit) async {
      FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
      List<Map<String, dynamic>> allProds = [];
      List<String> allCats = [];

      await db.collection("category").get().then((value) {
        for(var element in value.docs) {
          allCats.add(element['category_name']);
        }
        // print(allCats);
      });

      await db
          .collection("products")
          .where("product_availability", isEqualTo: true)
          .get()
          .then((value) async {
        for (var element in value.docs) {
          Map<String, dynamic> mp = {
            "product_name": element["product_name"],
            "product_image": element["product_image"],
            "product_price": element["product_price"],
            "product_category": element["product_category"],
            "product_type": element["product_type"]
          };
          allProds.add(mp);
        }
      });

      emit(ProductLoadingState(allProds, allCats));
    });
    on<AddOrderFBEvent>((event, emit) async {
      try {
        List<dynamic> allOrders = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await db.collection("live_table").doc(event.docId).get();
        Map<String, dynamic>? data = documentSnapshot.data();

        dynamic tablename = data?['table_name'];
        if (data != null && data.containsKey('products')) {
          allOrders = data['products'];
        }
        // Now you have the list of maps

        Map<String, dynamic> myData = {
          'productName': event.productName,
          'productCategory': event.productCategory,
          'productType': event.productType,
          'productPrice': event.productPrice.toString(),
          'quantity': event.quantity
        };

        allOrders.add(myData);
        db
            .collection('live_table')
            .doc(event.docId)
            .set({'products': allOrders, 'table_name': tablename});
      } catch (err) {
        throw Exception("Error creating product $err");
      }
    });

    on<FilterProductsEvent>((event, emit) async {
      String category = event.category;
      FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
      List<Map<String,dynamic>> allProds = [];
      List<Map<String, dynamic>> filteredProds = [];

      await db
          .collection("products")
          .where("product_availability", isEqualTo: true)
          .get()
          .then((value) async {
        for (var element in value.docs) {
          Map<String, dynamic> mp = {
            "product_name": element["product_name"],
            "product_image": element["product_image"],
            "product_price": element["product_price"],
            "product_category": element["product_category"],
            "product_type": element["product_type"]
          };
          allProds.add(mp);
        }
      });

      if(event.category == "All") {
        emit(FilterProductsState(allProds, event.allCats, event.category));
        return;
      }
      filteredProds = allProds.where((element) {
        return (element["product_category"].toString() == category);
      }).toList();

      // print(filteredProds);
      emit(FilterProductsState(filteredProds,event.allCats, event.category));
    });
  }
}
