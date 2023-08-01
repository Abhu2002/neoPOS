part of 'table_bloc.dart';

/*abstract class TableState extends Equatable {
  const TableState();
}

class InitialState extends TableState {
  @override
  List<Object?> get props => [];
}

class TableAdding extends TableState {
  @override
  List<Object?> get props => [];
}

class TableAdded extends TableState {
  @override
  List<Object?> get props => [];
}

class TableError extends TableState {
  final String error;

  const TableError(this.error);

  @override
  List<Object?> get props => [error];
}

class TableReadLoading extends TableState {
  @override
  List<Object?> get props => [];
}

class TableReadLoaded extends TableState {
  final List<TableModel> mytables;

  const TableReadLoaded({required this.mytables});

  @override
  List<Object> get props => [mytables];
}
*/

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}

class TableLoadingState extends TableState {}

class TableLoadedState extends TableState {
  final List all;
  const TableLoadedState(this.all);
  List<Object> get props => [all];
}

class ErrorState extends TableState {
  final String errormessage;
  const ErrorState(this.errormessage);
}