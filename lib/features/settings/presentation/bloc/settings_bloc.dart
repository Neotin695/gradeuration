import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/features/auth/data/models/user_profile_model.dart';
import 'package:gradeuration/features/settings/domain/usecases/update_user_profile.dart';
import 'package:gradeuration/features/settings/domain/usecases/upload_img_usecase.dart';

import '../../../../core/tools/tools.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(1.3434, 1.3434), zoom: 14);
  late GoogleMapController mapController;
  bool isFirstTry = false;
  Set<Marker> currentLocation = {};
  String placeName = '';
  final UploadImgUsecase _uploadImgUsecase;
  final UpdateProfileUsecsae _updateProfileUsecsae;
  final TextEditingController email =
      TextEditingController(text: currentUser.email);
  final TextEditingController fullName =
      TextEditingController(text: currentUser.fullName);
  final TextEditingController location =
      TextEditingController(text: currentUser.location);
  SettingsBloc(this._uploadImgUsecase, this._updateProfileUsecsae)
      : super(SettingsInitial()) {
    on<GetCurrentLocationEvent>(_getCurrenLocation);
    on<RequestLocationPermissionEvent>(_requestPermission);
    on<UpdateProfileEvent>(_updateProfileEvent);
  }

  FutureOr<void> _updateProfileEvent(event, emit) async {
    emit(SettingsLoading());
    try {
      await _updateProfileUsecsae(
        UserProfileModel.fromEntity(
          currentUser.copyWith(
            email: email.text.isEmpty
                ? null
                : email.text == currentUser.email
                    ? null
                    : email.text,
            fullName: fullName.text.isEmpty
                ? null
                : fullName.text == currentUser.fullName
                    ? null
                    : fullName.text,
            location: location.text.isEmpty
                ? null
                : location.text == currentUser.location
                    ? null
                    : location.text,
          ),
        ).toJson(),
      );
      emit(SettingsSuccess());
      await Future.delayed(
          const Duration(
            seconds: 2,
          ), () {
        emit(SettingsFinish());
      });
    } catch (e) {
      emit(SettingsFailure(e.toString()));
    }
  }
  //Todo
  // 1=> get data from api
  // 2=> handle error
  // 3=> convert json data to dart model
  // 4=> return data

  FutureOr<void> _getCurrenLocation(event, emit) async {
    emit(SettingsLoading());
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    log(placemarks.toString());
    placeName = placemarks.first.street!;
    currentLocation.clear();
    currentLocation.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude)));
    mapController.moveCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));

    emit(SettingsSuccess());
  }

  FutureOr<void> _requestPermission(event, emit) async {
    LocationPermission permissionResult = await Geolocator.requestPermission();
    if (permissionResult == LocationPermission.denied && !isFirstTry) {
      add(RequestLocationPermissionEvent());
      emit(SettingsFailure(t.permissionError));
      isFirstTry = true;
    } else if (permissionResult == LocationPermission.denied && isFirstTry) {
      emit(SettingsFailure(t.permissionError));
      return;
    }
  }
}
