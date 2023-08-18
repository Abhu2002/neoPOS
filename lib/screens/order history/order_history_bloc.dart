import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
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
        await db.collection("order_history").orderBy("order_date").get().then(
          (value) {
            value.docs.forEach((element) {
              AllOrderHistory.add({
                "Id": element.id,
                "amount": element['amount'],
                "order_date": element['order_date'],
                "customer_mobile_no": element['customer_mobile_no'],
                "customer_name": element['customer_name'],
                "payment_mode": element['payment_mode'],
                "products": element["products"]
              });
            });
          },
        );

        emit(OrderHistoryLoaded(AllOrderHistory, alldata));
        //gives all document of tables to State
      } catch (err) {
        emit(OrderHistoryErrorState(
            "Some Error Occur $err")); //calls state and stores message through parameter
      }
    });

    on<ShowOrderProductsEvent>((event, emit) {
      var productList = [];
      num amount = 0;
      String orderId = "";
      var allOrders = event.allOrders;
      for (var i = 0; i < allOrders.length; i++) {
        var id = int.parse(event.id);
        // print(allOrders[i]["Id"] == id);
        if (id == 0) break;
        if (int.parse(allOrders[i]["Id"]) == id) {
          amount = event.allOrders[i]["amount"];
          orderId = allOrders[i]["Id"];
          productList = (event.allOrders[i]["products"]);
          break;
        }
      }
      emit(ShowProductsState(
          event.allOrders, productList, amount, orderId, event.showORhide));
    });
  }
}
