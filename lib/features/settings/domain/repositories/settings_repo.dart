abstract class SettingsRepo {
  Future<void> updateUserData(Map<String, dynamic> data);
  Future<void> uploadImg(String path);

}
