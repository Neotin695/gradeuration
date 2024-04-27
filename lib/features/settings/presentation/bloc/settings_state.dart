part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {}
class SettingsFinish extends SettingsState {}

class SettingsFailure extends SettingsState {
  final String message;

  const SettingsFailure(this.message);
}
