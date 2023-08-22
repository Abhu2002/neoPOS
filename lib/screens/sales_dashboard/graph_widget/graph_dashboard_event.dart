part of 'graph_dashboard_bloc.dart';

abstract class GraphDashboardEvent extends Equatable {
  const GraphDashboardEvent();

  @override
  List<Object> get props => [];
}

class Graphinitevent extends GraphDashboardEvent {
  Graphinitevent([this.monthIndex]);
  int? monthIndex;

  @override
  List<Object> get props => [];
}
