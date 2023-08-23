part of 'side_menu_bloc.dart';

sealed class SideMenuEvent extends Equatable {
  const SideMenuEvent();

  @override
  List<Object> get props => [];
}

class SideMenuInitEvent extends SideMenuEvent {
  int index;
  SideMenuInitEvent(this.index);
}
