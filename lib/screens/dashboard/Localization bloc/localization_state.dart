part of 'localization_bloc.dart';

sealed class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object> get props => [];
}

final class LocalizationInitial extends LocalizationState {
  LocalizationInitial() {
    LocalPreference.setLang("en");
  }
}

final class localInitial extends LocalizationState {
  String lann;
  localInitial(this.lann);
  @override
  List<Object> get props => [lann];
}
