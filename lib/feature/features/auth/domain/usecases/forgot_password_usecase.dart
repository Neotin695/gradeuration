import 'package:gradeuration/core/helper/usecase_helper.dart';
import 'package:gradeuration/feature/features/auth/domain/repositories/auth_repo.dart';

class ForgotPasswordUsecase extends UsecaseHelper<Future<void>> {
  final AuthRepo _authRepo;

  ForgotPasswordUsecase(this._authRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _authRepo.forgotPassword(param['email']);
  }
}
