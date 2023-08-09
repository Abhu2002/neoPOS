import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neopos/screens/order%20page/order_page/order_content_page/order_content_event.dart';
import 'package:neopos/screens/order%20page/order_page/order_content_page/order_content_state.dart';

class OrderContentBloc extends Bloc<OrderContentEvent, OrderContentState> {
  OrderContentBloc() : super(InitialState()) {
    on<ProductLoadingEvent>((event, emit) async {
      FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
      List<Map<String,dynamic>> allProds = [];

      await db.collection("products").where("product_availability", isEqualTo: true)
          .get()
          .then((value) async {
            for (var element in value.docs) {
              Map<String,dynamic> mp = {
                "product_name" : element["product_name"],
                "product_image":element["product_image"],
                "product_price" : element["product_price"],
                "product_category" : element["product_category"],
                "product_type": element["product_type"]
              };
              allProds.add(mp);
            }

          });

      emit(ProductLoadingState(allProds));

    });
  }
}
