import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'order_read_event.dart';
part 'order_read_state.dart';

class OrderReadBloc extends Bloc<OrderReadEvent, OrderReadState> {
  OrderReadBloc() : super(OrderReadInitial()) {
    on<OrderReadInitialEvent>((event, emit) async {
      //t creates it Initially
      try {
        if (event.isfirst) {
          emit(
              OrderReadLoadingState()); //Creating connection with firebase and fetching table
        } else {
          emit(
              OrderReadLoadingState()); //Creating connection with firebase and fetching table
          await Future.delayed(const Duration(seconds: 1));
        }
        List allCat = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("table").get().then((value) => {
              value.docs.forEach((element) {
                allCat.add({
                  "tablecapacity": '${element['table_capacity']}',
                  "tablename": element['table_name'],
                  "docID": element.id
                });
              })
            });
        OrderReadLoadDataEvent();
        emit(OrderReadLoadedState(
            allCat)); //gives all document of tables to State
      } catch (err) {
        emit(const OrderErrorState(
            "Some Error Occur")); //calls state and stores message through parameter
      }
    });
  }
}
