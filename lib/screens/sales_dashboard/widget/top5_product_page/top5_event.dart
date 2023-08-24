part of 'top5_bloc.dart';

sealed class Top5Event extends Equatable {
  const Top5Event();

  @override
  List<Object> get props => [];
}

class LoadallData extends Top5Event {
  final List all;

  const LoadallData(this.all);
  @override
  List<Object> get props => [all];
}

class SelectKeyEvent extends Top5Event {
  final String key;
  const SelectKeyEvent(this.key);

  @override
  List<Object> get props => [key];
}
