part of 'update_bloc.dart';

abstract class TableEvent extends Equatable {}

class TableUpdateRequested extends TableEvent {
  final String tableId;
  final String newName;
  final String newCapacity;

  TableUpdateRequested(this.tableId, this.newName, this.newCapacity);

  @override
  List<Object?> get props => [tableId, newName, newCapacity];
}
