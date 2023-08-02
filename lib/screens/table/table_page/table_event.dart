part of 'table_bloc.dart';

/*abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class LoadTable extends TableEvent {}

class LoadReadSuccessTable extends TableEvent {
  const LoadReadSuccessTable();
} */

abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends TableEvent {}

class InitialEvent extends TableEvent {}
