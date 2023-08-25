import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../model/user.dart';
part 'read_user_event.dart';
part 'read_user_state.dart';

class ReadUserBloc extends Bloc<ReadUserEvent, ReadUserState> {
  ReadUserBloc() : super(ReadUserInitial()) {
    on<InitialEvent>((event, emit) async {
      try {
        int counter = 1;
        if (event.isfirst) {
          emit(DataLoadingState());
        } else {
          emit(DataLoadingState());
          await Future.delayed(const Duration(seconds: 1));
        }
        List allCat = [];
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("users").get().then((value) => {
              value.docs.forEach((element) {
                allCat.add(UserModel.fromFirestore(element, counter));
                counter += 1;
              })
            });
        LoadDataEvent();
        emit(DataLoadedState(allCat));
      } catch (err) {
        emit(const ErrorState("Some Error Occur"));
      }
    });
  }
}
