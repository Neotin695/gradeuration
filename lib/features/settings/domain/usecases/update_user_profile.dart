import 'package:gradeuration/features/settings/domain/repositories/settings_repo.dart';

import '../../../../core/helper/usecase_helper.dart';

class UpdateProfileUsecsae extends UsecaseHelper<Future<void>> {
  final SettingsRepo _profileRepo;

  UpdateProfileUsecsae(this._profileRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _profileRepo.updateUserData(param);
  }
}
