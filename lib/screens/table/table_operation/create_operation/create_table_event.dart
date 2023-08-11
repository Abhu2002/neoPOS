part of 'create_table_bloc.dart';

abstract class CreateTableEvent extends Equatable {
  const CreateTableEvent();
  @override
  List<Object> get props => [];
}

class TableNameNotAvailableEvent extends CreateTableEvent {}

class CreateTableFBEvent extends CreateTableEvent {
  final String tableName;
  final String tableCap;
  const CreateTableFBEvent(this.tableName, this.tableCap);
  @override
  List<Object> get props => [tableName, tableCap];
}
