import 'dart:io';

import 'package:gradeuration/features/settings/data/datasources/settings_service.dart';
import 'package:gradeuration/features/settings/domain/repositories/settings_repo.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsService _service;

  SettingsRepoImpl(this._service);

  @override
  Future<void> updateUserData(Map<String, dynamic> data) {
    return _service.updateProfile(data);
  }

  @override
  Future<void> uploadImg(String path) {
    return _service.uploadImage(File(path));
  }
}
