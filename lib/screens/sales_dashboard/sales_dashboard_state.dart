part of 'sales_dashboard_bloc.dart';

abstract class SalesDashboardState extends Equatable {
  const SalesDashboardState();

  @override
  List<Object> get props => [];
}

class SalesDashboardInitial extends SalesDashboardState {}

class SalesDashBoardLoadingState extends SalesDashboardState {}

class SalesDashBoardLoadedState extends SalesDashboardState {
  final List allOrder;
  final List productList;
  final num dailyValue;
  final num weeklyValue;
  final num monthlyValue;
  final Map<String, double> piemap;
  final List<Map> topproduct;
  SalesDashBoardLoadedState(this.allOrder, this.productList, this.dailyValue,
      this.weeklyValue, this.monthlyValue, this.piemap, this.topproduct);
  @override
  List<Object> get props => [allOrder, productList, topproduct];
}

class SalesDashboardErrorState extends SalesDashboardState {
  final String errorMessage;
  const SalesDashboardErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
