import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gradeuration/core/helper/local_data.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> forgotPassword(email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signIn(email, password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    await updateUser();
  }

  Future<void> signInWithBiometric() async {
    // TODO: implement signInWithBiometric
    throw UnimplementedError();
  }

  Future<void> signUp(Map<String, dynamic> data) async {
    // signup user
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: data['email'], password: data['password']);
      if (data['imageUrl'].isNotEmpty) {
        SettableMetadata metaData = SettableMetadata(contentType: 'image/jpeg');
        final res = await _storage
            .ref('medicalReports')
            .child(result.user!.uid)
            .child(data['imageUrl'].split('/').last + '.jpeg')
            .putFile(File(data['imageUrl']), metaData);

        if (res.state == TaskState.success) {
          data['imageUrl'] = await res.ref.getDownloadURL();
        } else {
          data['imageUrl'] = '';
        }
      }
      // upload userData to firestore
      data['id'] = result.user!.uid;
      await _firestore.collection('users').doc(data['id']).set(data);
      await updateUser();
    } catch (e) {
      throw e;
    }
  }
}
