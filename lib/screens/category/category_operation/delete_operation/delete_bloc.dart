import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'delete_event.dart';
import 'delete_state.dart';

class CategoryDeletionBloc
    extends Bloc<CategoryDeletionEvent, CategoryDeletionState> {
  final CollectionReference usersCollection =
      GetIt.I.get<FirebaseFirestore>().collection('users');
  final CollectionReference categoryCollection =
      GetIt.I.get<FirebaseFirestore>().collection('category');

  CategoryDeletionBloc() : super(InitialCategoryDeletionState()) {
    on<CredentialsEnteredEvent>(_mapCredentialsEnteredEventToState);
    on<ConfirmTableDeletionEvent>(_mapConfirmTableDeletionEventToState);
  }

  void _mapCredentialsEnteredEventToState(CredentialsEnteredEvent event,
      Emitter<CategoryDeletionState> emit) async {
    String username = event.username;
    String password = event.password;

    QuerySnapshot querySnapshot =
        await usersCollection.where('user_id', isEqualTo: username).get();

    if (querySnapshot.size != 0) {
      var userData = querySnapshot.docs[0].data();
      if (userData != null && userData is Map<String, dynamic>) {
        String role = userData['user_role'];

        if (userData['password'] == password && role == 'admin') {
          emit(ConfirmationState());
        } else {
          emit(ErrorState('Invalid credentials or insufficient permissions.'));
        }
      }
    } else {
      emit(ErrorState('Invalid credentials or insufficient permissions.'));
    }
  }

  void _mapConfirmTableDeletionEventToState(
      ConfirmTableDeletionEvent event, Emitter<CategoryDeletionState> emit) {
    emit(CategoryDeleteState());
  }

  void deleteCategory(String categoryId) async {
    await categoryCollection.doc(categoryId).delete();
    add(ConfirmTableDeletionEvent());
  }
}
