part of 'read_category_bloc.dart';

abstract class ReadCategoryEvent extends Equatable {
  const ReadCategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends ReadCategoryEvent {}

class InitialEvent extends ReadCategoryEvent {}



