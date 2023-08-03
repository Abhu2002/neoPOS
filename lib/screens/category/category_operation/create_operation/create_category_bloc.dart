import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../model/category.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  void Function(String)? showMessage;

  CreateCategoryBloc() : super(CreateCategoryInitial()) {
    on<InputEvent>((event, emit) async {
      if (event.categoryName != "") {
        emit(CategoryNameAvailableState());
      } else {
        emit(const CategoryErrorState("Please Enter a Name"));
      }
    });
    on<CreateCategoryFBEvent>((event, emit) async {
      try {
        List allName = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("category").get().then((value) => {
              value.docs.forEach((element) {
                allName.add(element['category_name']);
              })
            });
        if (allName.contains(event.categoryName)) {
          emit(const CategoryErrorState("Please Pop"));
          showMessage!("Category Name Exist Please use Different Name");
        } else {
          final data = CategoryModel(categoryName: event.categoryName);
          await db.collection("category").add(data.toFirestore()).then(
              (documentSnapshot) => {
                    emit(CategoryCreatedState(true)),
                    showMessage!("Category Created")
                  });
          await GetIt.I.get<FirebaseFirestore>().clearPersistence();
          await GetIt.I.get<FirebaseFirestore>().terminate();
        }
      } catch (err) {
        // print(err);
      }
    });
  }
}
