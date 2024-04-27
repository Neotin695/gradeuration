part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentLocationEvent extends SettingsEvent {}

class RequestLocationPermissionEvent extends SettingsEvent {}

class UpdateProfileEvent extends SettingsEvent {}

class UploadImgEvent extends SettingsEvent {}
