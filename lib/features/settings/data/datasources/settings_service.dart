import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/helper/local_data.dart';
import '../../../auth/data/models/user_profile_model.dart';

class SettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImage(File imgPath) async {
    try {
      final ref = await _storage
          .ref('profiles')
          .child(currentUser.id)
          .child('person.jpeg')
          .putFile(imgPath, SettableMetadata(contentType: 'images/jpeg'));
      if (ref.state == TaskState.success) {
        await _firestore.collection('users').doc(currentUser.id).update({
          'profileImg': (await ref.ref.getDownloadURL()),
        });
      }
      final user =
          await _firestore.collection('users').doc(currentUser.id).get();
      saveUser(UserProfileModel.fromJson(user.data()!));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      if (data.isNotEmpty) {
        await _firestore.collection('users').doc(currentUser.id).update(data);
      }
      await updateUser();
    } catch (e) {
      throw e;
    }
  }
}
