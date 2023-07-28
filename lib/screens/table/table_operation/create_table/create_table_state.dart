part of 'create_table_bloc.dart';

class CreateTableState extends Equatable {
  const CreateTableState();

  @override
  List<Object> get props => [];
}

class CreateTableInitial extends CreateTableState {}

class TableNameunAvailableState extends CreateTableState {}

class TableNameAvailableState extends CreateTableState {}

class TableLoadingState extends CreateTableState {}

class TableErrorState extends CreateTableState {
  final String errorMessage;
  TableErrorState(this.errorMessage);
}

class TableCreatedState extends CreateTableState {}
