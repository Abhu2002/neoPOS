part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}
// this is the event that's triggered when the user
// wants to change pages
class NavigateTo extends DashboardEvent {
  final NavItem destination;
  const NavigateTo(this.destination);

  @override
  List<Object> get props => [];
}
