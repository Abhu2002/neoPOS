abstract class TableState {}

class TableInitialState extends TableState {}

class TableUpdatingState extends TableState {}

class TableUpdatedState extends TableState {}

class TableErrorState extends TableState {
  final String error;

  TableErrorState(this.error);
}
