part of 'category_update_bloc.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitialState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryUpdatingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryUpdatedState extends CategoryState {
  @override
  List<Object> get props => [];
}
