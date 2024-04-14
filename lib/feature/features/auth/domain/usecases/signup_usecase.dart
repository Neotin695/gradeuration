import 'package:gradeuration/core/helper/usecase_helper.dart';
import 'package:gradeuration/feature/features/auth/domain/repositories/auth_repo.dart';

class SignUpUsecase extends UsecaseHelper<Future<void>> {
  final AuthRepo _authRepo;

  SignUpUsecase(this._authRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _authRepo.signUp(param);
  }
}
