part of 'read_category_bloc.dart';

abstract class ReadCategoryState extends Equatable {
  const ReadCategoryState();

  @override
  List<Object> get props => [];
}

class ReadCategoryInitial extends ReadCategoryState {}

class DataLoadingState extends ReadCategoryState {}

class DataLoadedState extends ReadCategoryState {
  final List all;
  const DataLoadedState(this.all);
  List<Object> get props => [all];
}

class ErrorState extends ReadCategoryState {
  final String errormessage;
  const ErrorState(this.errormessage);
}
