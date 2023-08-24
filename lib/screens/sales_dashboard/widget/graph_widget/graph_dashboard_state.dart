part of 'graph_dashboard_bloc.dart';

abstract class GraphDashboardState extends Equatable {
  const GraphDashboardState();


  @override
  List<Object> get props => [];
}
class GraphFilterLoadingState extends GraphDashboardState {}
class GraphFilterState extends GraphDashboardState {

  List<SalesData> processedData;

  GraphFilterState( this.processedData,);
  @override
  List<Object> get props => [processedData];
}
class GraphFilterErrorState extends GraphDashboardState {
  final String errorMessage;
  const GraphFilterErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
