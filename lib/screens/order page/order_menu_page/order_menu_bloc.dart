import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';
/// Need to import for date time format
import 'package:intl/intl.dart';
import '../model/order_products_model.dart';

part 'order_menu_event.dart';
part 'order_menu_state.dart';

class OrderContentBloc extends Bloc<OrderContentEvent, OrderContentState> {
  final CollectionReference liveCollection =
  GetIt.I.get<FirebaseFirestore>().collection('live_table');

  OrderContentBloc() : super(InitialState()) {
    on<ProductLoadingEvent>((event, emit) async {
      FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
      List<Map<String, dynamic>> allProds = [];
      List<String> allCats = [];

      await db.collection("category").get().then((value) {
        for(var element in value.docs) {
          allCats.add(element['category_name']);
        }
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

      try {
        await Future.delayed(const Duration(milliseconds: 500));
        DocumentSnapshot tableSnapshot =
        await liveCollection.doc(event.tableId).get();
        List<Map<String, dynamic>> productsData =
        List<Map<String, dynamic>>.from(tableSnapshot['products']);

        List<Product> products = productsData.map((data) {
          return Product(
            productCategory: data['productCategory'],
            productName: data['productName'],
            productPrice: data['productPrice'],
            productType: data['productType'],
            quantity: data['quantity'],
          );
        }).toList();
        emit(ProductLoadingState(allProds, allCats, products));
      } catch (error) {
        emit(ErrorState('Error loading live table data'));
      }

    });
    on<AddOrderFBEvent>((event, emit) async {
      try {
        List<dynamic> allOrders = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await db.collection("live_table").doc(event.docId).get();
        Map<String, dynamic>? data = documentSnapshot.data();

        dynamic tableName = data?['table_name'];
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
            .set({'products': allOrders, 'table_name': tableName});
      } catch (err) {
        throw Exception("Error creating product $err");
      }
    });

    on<FilterProductsEvent>((event, emit) async {
      String category = event.category;
      List<Map<String, dynamic>> filteredProds = [];
      List<Product> products = [];
      try {
        DocumentSnapshot tableSnapshot =
        await liveCollection.doc(event.tableId).get();
        List<Map<String, dynamic>> productsData =
        List<Map<String, dynamic>>.from(tableSnapshot['products']);

        products = productsData.map((data) {
          return Product(
            productCategory: data['productCategory'],
            productName: data['productName'],
            productPrice: data['productPrice'],
            productType: data['productType'],
            quantity: data['quantity'],
          );
        }).toList();
      } catch (error) {
        emit(ErrorState('Error loading live table data'));
      }

      if(event.category == "All") {
        emit(FilterProductsState(event.allProds, event.allCats, event.category, products));
        return;
      }
      filteredProds = event.allProds.where((element) {
        return (element["product_category"].toString() == category);
      }).toList();

      emit(FilterProductsState(filteredProds,event.allCats, event.category, products));
    });

    on<CheckoutOrderFBEvent>((event, emit) async {
      try {
        int allOrders = 0;
        var allProducts= [];
        var emptyProducts=[];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await db.collection("live_table").doc(event.docId).get();
        Map<String, dynamic>? data = documentSnapshot.data();
        dynamic tableName = data?['table_name'];
        await db.collection('order_history').count().get().then((value) {
          allOrders=value.count;
        }
        );
        if (data != null && data.containsKey('products')) {
          allProducts = data['products'];
        }
        //Now you have the list of maps

        String orderId = (allOrders + 1).toString();
        db
            .collection('order_history')
            .doc(orderId)
            .set({
          'products': allProducts,
          'amount': event.totalPrice,
          'customer_mobile_no': event.customerMbNo,
          'customer_name': event.customerName,
          'payment_mode': event.paymentMode,
          'order_date':DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())

        });

        db
            .collection('live_table')
            .doc(event.docId)
            .set({'products': emptyProducts, 'table_name': tableName});
      } catch (err) {
        throw Exception("Error creating product $err");
      }
    }
    );

  }
}
