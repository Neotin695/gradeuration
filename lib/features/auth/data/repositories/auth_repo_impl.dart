import 'package:gradeuration/features/auth/data/datasources/auth_service.dart';
import 'package:gradeuration/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService _authService;

  AuthRepoImpl(this._authService);
  @override
  Future<void> forgotPassword(email) {
    return _authService.forgotPassword(email);
  }

  @override
  Future<void> signIn(email, password) {
    return _authService.signIn(email, password);
  }

  @override
  Future<void> signInWithBiometric() {
    // TODO: implement signInWithBiometric
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(Map<String, dynamic> data) {
    return _authService.signUp(data);
  }
}
