part of 'create_table_bloc.dart';

class CreateTableState extends Equatable {
  const CreateTableState();

  @override
  List<Object> get props => [];
}

class CreateTableInitial extends CreateTableState {}

class TableNameNotAvailableState extends CreateTableState {}
class TableCreatedState extends CreateTableState {
  bool isCreated;
  TableCreatedState(this.isCreated);
  @override
  List<Object> get props => [isCreated];
}
