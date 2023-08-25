import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';

part 'delete_event.dart';

part 'delete_state.dart';

class CategoryDeletionBloc
    extends Bloc<CategoryDeletionEvent, CategoryDeletionState> {
  final CollectionReference usersCollection =
      GetIt.I.get<FirebaseFirestore>().collection('users');
  final CollectionReference categoryCollection =
      GetIt.I.get<FirebaseFirestore>().collection('category');
  final CollectionReference productsCollection =
      GetIt.I.get<FirebaseFirestore>().collection('products');

  CategoryDeletionBloc() : super(InitialCategoryDeletionState()) {
    on<CredentialsEnteredEvent>(_mapCredentialsEnteredEventToState);
    on<ConfirmTableDeletionEvent>(_mapConfirmTableDeletionEventToState);
  }

  void _mapCredentialsEnteredEventToState(CredentialsEnteredEvent event,
      Emitter<CategoryDeletionState> emit) async {
    String username = event.username;
    String password = event.password;
    String docId = event.id;

    QuerySnapshot categorySnapshot = await categoryCollection
        .where("category_name", isEqualTo: event.categoryName)
        .get();
    var catData = categorySnapshot.docs[0].data();

    if (catData != null && catData is Map<String, dynamic>) {
      QuerySnapshot productSnapShot = await productsCollection
          .where("product_category", isEqualTo: catData["category_name"])
          .get();
      if (productSnapShot.size != 0) {
        emit(ErrorState("First delete this categories products"));
        return;
      }
    }

    QuerySnapshot querySnapshot =
        await usersCollection.where('user_id', isEqualTo: username).get();

    if (querySnapshot.size != 0) {
      var userData = querySnapshot.docs[0].data();
      if (userData != null && userData is Map<String, dynamic>) {
        String role = userData['user_role'];

        if (userData['password'] == password && role == 'Admin') {
          categoryCollection.doc(docId).delete();
          emit(CategoryDeleteState());
        } else {
          emit(ErrorState("Invalid Credentials"));
        }
      }
    } else {
      emit(ErrorState("Invalid Credentials"));
    }
  }

  void _mapConfirmTableDeletionEventToState(
      ConfirmTableDeletionEvent event, Emitter<CategoryDeletionState> emit) {
    emit(ConfirmationState(event.id, event.name));
  }
}
