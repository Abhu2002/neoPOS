import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';


part 'side_menu_event.dart';
part 'side_menu_state.dart';

class SideMenuBloc extends Bloc<SideMenuEvent, SideMenuState> {
  SideMenuBloc() : super(SideMenuInitial()) {
    on<SideMenuInitEvent>((event, emit) async {
emit(SideMenuLoaded(event.index));
  });}
}
