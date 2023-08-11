part of 'table_bloc.dart';

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}

class TableReadLoadingState extends TableState {}

class TableReadLoadedState extends TableState {
  final List all;
  const TableReadLoadedState(this.all); //it receives from bloc and store it in properties
  @override
  List<Object> get props => [all];
}

class ErrorState extends TableState {
  final String errorMessage;
  const ErrorState(this.errorMessage);
}
