part of 'create_table_bloc.dart';

class CreateTableState extends Equatable {
  const CreateTableState();

  @override
  List<Object> get props => [];
}

class CreateTableInitial extends CreateTableState {}

class TableNameAvailableState extends CreateTableState {}



class TableErrorState extends CreateTableState {
  final String errorMessage;
  const TableErrorState(this.errorMessage);
}

class TableCreatedState extends CreateTableState {
  bool isCreated;
  TableCreatedState(this.isCreated);
  @override
  List<Object> get props => [isCreated];
}
