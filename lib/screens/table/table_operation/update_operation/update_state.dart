part of 'update_bloc.dart';

abstract class TableState extends Equatable {}

class TableInitialState extends TableState {
  @override
  List<Object?> get props => [];
}

class TableUpdatingState extends TableState {
  @override
  List<Object?> get props => [];
}

class TableUpdatedState extends TableState {
  @override
  List<Object?> get props => [];
}
