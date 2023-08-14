import 'dart:convert';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    /* on<ProductOrderPerTableEvent>((event, emit) {
      print(event.productorderpertable);
      emit(ProductOrderPerTableLoaded(event.productorderpertable));
    });*/

    on<OrderHistoryPageInitEvent>((event, emit) async {
      try {
        if (event.isfirst) {
          emit(OrderHistoryLoading());
        } else {
          emit(OrderHistoryLoading());
          await Future.delayed(const Duration(seconds: 1));
        }
        var AllOrderHistory = [];
        List<dynamic> alldata = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("order_history").get().then(
          (value) {
            value.docs.forEach((element) {
              // print((element["customer_mobile_no"]));
              //print((element["customer_name"]));
              //print((element["payment_mode"]));
              //print((element["products"]));
              AllOrderHistory.add({
                "Id": element.id,
                "amount": element['amount'],
                "order_date": element['order_date'],
                "customer_moblie_no": element['customer_mobile_no'],
                "customer_name": element['customer_name'],
                "payment_mode": element['payment_mode'],
                "products": element["products"]
              });
            });
            // print("a::::::${AllOrderHistory}");
          },
        );
        // for (var i = 0; i < AllOrderHistory.length; i++) {
        //   if (AllOrderHistory[i]["Id"] == int.parse(event.id)) {
        //     alldata.add(AllOrderHistory[0]["products"]);
        //     // print(alldata);
        //   }
        // }

        // print(alldata);
        emit(OrderHistoryLoaded(AllOrderHistory, alldata));
        //emit(ProductOrderPerTableLoaded(event.productorderpertable));
        //gives all document of tables to State
      } catch (err) {
        emit(OrderHistoryErrorState(
            "Some Error Occur $err")); //calls state and stores message through parameter
      }
    });

    on<ShowOrderProductsEvent>((event, emit) {
      // print("Bloc id: ${event.id}");
      // print(event.allOrders);
      var productList;
      num amount = 0;
      String orderId = "";
      var allOrders = event.allOrders;
      for (var i = 0; i < allOrders.length; i++) {
        // print("all order id: ${allOrders[i]["Id"]}");
        // print(allOrders[i]["Id"].runtimeType);
        // print("event id: ${int.parse(event.id)}");

        var id = int.parse(event.id);
        // print(allOrders[i]["Id"] == id);
        if (int.parse(allOrders[i]["Id"]) == id) {
          amount = event.allOrders[i]["amount"];
          orderId = allOrders[i]["Id"];
          productList = (event.allOrders[i]["products"]);
          // print(alldata);
          break;
        }
      }
      emit(ShowProductsState(event.allOrders, productList, amount, orderId));
    });
  }
}
