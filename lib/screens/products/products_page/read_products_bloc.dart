import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../model/product.dart';

part 'read_products_event.dart';
part 'read_products_state.dart';

class ReadProductsBloc extends Bloc<ReadProductsEvent, ReadProductsState> {
  ReadProductsBloc() : super(ReadProductsInitial()) {
    on<ReadInitialEvent>((event, emit) async {
      try {
        if (event.isFirst) {
          emit(ReadDataLoadingState());
        } else {
          emit(ReadDataLoadingState());
          await Future.delayed(const Duration(seconds: 1));
        }

        List allCat = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("products").get().then((value) => {
              value.docs.forEach((element) {
                allCat.add(ProductModel.fromFirestore(element));
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
