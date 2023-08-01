part of 'table_bloc.dart';

abstract class TableState extends Equatable {
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
