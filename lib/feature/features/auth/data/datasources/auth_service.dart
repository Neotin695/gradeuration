import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> forgotPassword(email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signIn(email, password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithBiometric() async {
    // TODO: implement signInWithBiometric
    throw UnimplementedError();
  }

  Future<void> signUp(Map<String, dynamic> data) async {
    // signup user
    final result = await _auth.createUserWithEmailAndPassword(
        email: data['email'], password: data['password']);

    // upload userData to firestore
    data['id'] = result.user!.uid;
    await _firestore.collection('users').doc(data['id']).set(data);
  }
}
