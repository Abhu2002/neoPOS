import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'read_products_event.dart';
part 'read_products_state.dart';

class ReadProductsBloc extends Bloc<ReadProductsEvent, ReadProductsState> {
  ReadProductsBloc() : super(ReadProductsInitial()) {
    on<ReadInitialEvent>((event, emit) async {
      try {
        emit(ReadDataLoadingState());
        List allCat = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("products").get().then((value) => {
              value.docs.forEach((element) {
                allCat.add({
                  "Id": element.id,
                  "product_availability": element['product_availability'],
                  "product_category": element['product_category'],
                  "product_description": element['product_description'],
                  "product_image": element['product_image'],
                  "product_name": element['product_name'],
                  "product_price": element['product_price'],
                  "product_type": element['product_type'],
                });
              })
            });
        ReadLoadedDataEvent();
        emit(ReadDataLoadedState(allCat));
      } catch (err) {
        emit(ReadErrorState("Error Occur :-$err"));
      }
    });
  }
}
