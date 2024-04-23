abstract class AuthRepo {
  Future<void> signIn(email, password);
  Future<void> signInWithBiometric();
  Future<void> signUp(Map<String, dynamic> data);
  Future<void> forgotPassword(email);
}
