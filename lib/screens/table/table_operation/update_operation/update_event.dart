abstract class TableEvent {}

class TableUpdateRequested extends TableEvent {
  final String tableId;
  final String newName;
  final String newCapacity;

  TableUpdateRequested(this.tableId, this.newName, this.newCapacity);
}
