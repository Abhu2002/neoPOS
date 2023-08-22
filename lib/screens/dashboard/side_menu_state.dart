part of 'side_menu_bloc.dart';

sealed class SideMenuState extends Equatable {
  const SideMenuState();


  @override
  List<Object> get props => [];
}

final class SideMenuInitial extends SideMenuState {}



class SideMenuLoaded extends SideMenuState {
int index=0;
  SideMenuLoaded(this.index);
  @override
  List<Object> get props => [index];
}

class SideMenuErrorState extends SideMenuState {
  final String errorMessage;
  const SideMenuErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

