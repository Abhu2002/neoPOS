import 'dart:html';

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
        var tabledata = await db.collection('table').get();
        await db.collection("live_table").get().then((value) => {
              value.docs.forEach((element) async {
                var a = tabledata.docChanges;
                int? cap;
                a.forEach(
                  (e) {
                    if (e.doc['table_name'] == element['table_name']) {
                      cap = e.doc['table_capacity'];
                    }
                  },
                );
                allCat.add({
                  "tablename": element['table_name'],
                  "tablecapacity": cap,
                  "docID": element.id
                });
              })
            });
        OrderReadLoadDataEvent();
        emit(OrderReadLoadedState(
            allCat)); //gives all document of tables to State
      } catch (err) {
        print(err);
        emit(const OrderErrorState(
            "Some Error Occur")); //calls state and stores message through parameter
      }
    });
  }
}
