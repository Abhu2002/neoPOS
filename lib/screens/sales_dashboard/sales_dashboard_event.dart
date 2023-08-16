part of 'sales_dashboard_bloc.dart';

abstract class SalesDashboardEvent extends Equatable {
  const SalesDashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardPageinitevent extends SalesDashboardEvent {
  DashboardPageinitevent([this.monthIndex]);
  int? monthIndex;

  // @override
  // List<Object> get props => [monthIndex];
}
