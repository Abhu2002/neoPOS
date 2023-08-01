part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TableIdChanged extends UpdateEvent {
  TableIdChanged(this.tableId);
  final String tableId;

  @override
  List<Object> get props => [tableId];
}

class TableNameChanged extends UpdateEvent {
  TableNameChanged(this.tableName);
  final String tableName;

  @override
  List<Object> get props => [tableName];
}

class TableCapacityChanged extends UpdateEvent {
  TableCapacityChanged(this.tableCapacity);
  final int tableCapacity;

  @override
  List<Object> get props => [tableCapacity];
}

class OnUpdate extends UpdateEvent {
  @override
  List<Object> get props => [];
}