part of 'read_user_bloc.dart';

abstract class ReadUserEvent extends Equatable {
  const ReadUserEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends ReadUserEvent {}

// ignore: must_be_immutable
class InitialEvent extends ReadUserEvent {
  bool isfirst;
  InitialEvent(this.isfirst);
}
