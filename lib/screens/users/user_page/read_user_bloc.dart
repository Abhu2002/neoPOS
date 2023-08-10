import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
part 'read_user_event.dart';

part 'read_user_state.dart';

class ReadUserBloc extends Bloc<ReadUserEvent, ReadUserState> {
  ReadUserBloc() : super(ReadUserInitial()) {
    on<InitialEvent>((event, emit) async {
      try {
        if (event.isfirst) {
          emit(DataLoadingState());
        } else {
          emit(DataLoadingState());
          await Future.delayed(const Duration(seconds: 1));
        }
        List allcat = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("users").get().then((value) => {
              value.docs.forEach((element) {
                allcat.add({
                  "Id": element.id,
                  "user_id": element['user_id'],
                  "first_name": element['first_name'],
                  "last_name": element['last_name'],
                  "password": element['password'],
                  "added_on": element['added_on'],
                  "updated_on": element['updated_on']
                });
              })
            });
        LoadDataEvent();
        emit(DataLoadedState(allcat));
      } catch (err) {
        emit(const ErrorState("Some Error Occur"));
      }
    });
  }
}
