part of 'localization_bloc.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class changelanevent extends LocalizationEvent {
  final String lan;
  const changelanevent(this.lan);
  @override
  List<Object> get props => [lan];
}
