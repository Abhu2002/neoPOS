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
  List<SalesData> processedData;
   SalesDashBoardLoadedState(this.allOrder, this.productList, this.processedData);
  @override
  List<Object> get props => [allOrder, productList,processedData];
}

class SalesDashboardErrorState extends SalesDashboardState {
  final String errorMessage;
  const SalesDashboardErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
