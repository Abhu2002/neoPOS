import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'read_category_event.dart';
part 'read_category_state.dart';

class ReadCategoryBloc extends Bloc<ReadCategoryEvent, ReadCategoryState> {
  void Function(String)? showMessage;
  ReadCategoryBloc() : super(ReadCategoryInitial()) {
    on<InitialEvent>((event, emit) async {
      try {
        int sr = 1;
        if (event.isfirst) {
          emit(DataLoadingState());
        } else {
          emit(DataLoadingState());
          await Future.delayed(const Duration(seconds: 1));
        }
        List allCat = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("category").get().then((value) => {
              value.docs.forEach((element) {
                allCat.add({
                  "Id": element.id,
                  "Category": element['category_name'],
                  "sr": sr.toString()
                });
                sr = sr + 1;
              })
            });
        LoadDataEvent();
        emit(DataLoadedState(allCat));
      } catch (err) {
        throw Exception("Error creating product $err");
      }
    });
  }
}
