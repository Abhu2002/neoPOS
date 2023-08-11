import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class ProductDeletionBloc
    extends Bloc<ProductDeletionEvent, ProductDeletionState> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  ProductDeletionBloc() : super(InitialProductDeletionState()) {
    on<CredentialsEnteredEvent>(_mapCredentialsEnteredEventToState);
    on<ConfirmTableDeletionEvent>(_mapConfirmTableDeletionEventToState);
  }

  void _mapCredentialsEnteredEventToState(
      CredentialsEnteredEvent event, Emitter<ProductDeletionState> emit) async {
    String username = event.username;
    String password = event.password;
    String docID = event.id;
    QuerySnapshot querySnapshot =
        await usersCollection.where('user_id', isEqualTo: username).get();

    if (querySnapshot.size != 0) {
      var userData = querySnapshot.docs[0].data();
      if (userData != null && userData is Map<String, dynamic>) {
        String role = userData['user_role'];

        if (userData['password'] == password && role == 'admin') {
          productCollection.doc(docID).delete();
          emit(ProductDeleteState());
        } else {
          emit(ErrorState('Invalid credentials or insufficient permissions.'));
        }
      }
    } else {
      emit(ErrorState('Invalid credentials or insufficient permissions.'));
    }
  }

  void _mapConfirmTableDeletionEventToState(
      ConfirmTableDeletionEvent event, Emitter<ProductDeletionState> emit) {
    emit(ConfirmationState(event.id));
  }
}
