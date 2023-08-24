part of 'top5_bloc.dart';

sealed class Top5State extends Equatable {
  const Top5State();

  @override
  List<Object> get props => [];
}

final class Top5Initial extends Top5State {}

class LoadedState extends Top5State {
  final String state;
  final Map all;
  const LoadedState(this.all, this.state);
  @override
  List<Object> get props => [all];
}

class LoadingState extends Top5State {}
