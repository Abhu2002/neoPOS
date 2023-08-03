part of 'read_user_bloc.dart';

abstract class ReadUserEvent extends Equatable {
  const ReadUserEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends ReadUserEvent {}

class InitialEvent extends ReadUserEvent {}
