import 'package:gradeuration/features/settings/domain/repositories/settings_repo.dart';

import '../../../../core/helper/usecase_helper.dart';

class UploadImgUsecase implements UsecaseHelper<Future<void>> {
  final SettingsRepo _profileRepo;

  UploadImgUsecase(this._profileRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _profileRepo.uploadImg(param['img']);
  }
}
