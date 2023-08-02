part of 'read_user_bloc.dart';

abstract class ReadUserState extends Equatable {
  const ReadUserState();

  @override
  List<Object> get props => [];
}

class ReadUserInitial extends ReadUserState {}

class DataLoadingState extends ReadUserState {}

class DataLoadedState extends ReadUserState {
  final List all;

  const DataLoadedState(this.all);

  @override
  List<Object> get props => [all];
}

class ErrorState extends ReadUserState {
  final String errorMessage;

  const ErrorState(this.errorMessage);
}
