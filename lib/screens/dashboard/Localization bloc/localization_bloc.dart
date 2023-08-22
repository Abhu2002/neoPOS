import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neopos/utils/sharedpref/sharedpreference.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial()) {
    on<changelanevent>((event, emit) {
      if (event.lan == "en") {
        LocalPreference.setLang('en');
        emit(localInitial("en"));
      } else if (event.lan == "hi") {
        LocalPreference.setLang('hi');
        emit(localInitial("hi"));
      }
    });
  }
}
