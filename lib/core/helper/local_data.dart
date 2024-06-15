import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradeuration/core/helper/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_value/shared_value.dart';

import '../../features/auth/data/models/user_profile_model.dart';
import '../../features/auth/domain/entities/user_profile_entity.dart';

final SharedValue<String> userData = SharedValue(key: 'currentUser', value: '');

void saveUser(UserProfileModel user) {
  userData.$ = jsonEncode(user.toJson());
}

Future updateUser() async {
  await updateToken(FirebaseAuth.instance.currentUser!.uid);
  final data = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  if (data.exists) {
    final user = UserProfileModel.fromJson(data.data() as Map<String, dynamic>);

    saveUser(user);
  }
}

Future<void> updateToken(String userId) async {
  final String token = (await FirebaseMessagingService.instance.generateToken)!;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({'token': token});
}

Future<UserProfileEntity> getUserById(id) async {
  final data =
      await FirebaseFirestore.instance.collection('users').doc(id).get();

  final user = UserProfileModel.fromJson(data.data() as Map<String, dynamic>);
  return user;
}

UserProfileEntity get currentUser =>
    UserProfileModel.fromJson(jsonDecode(userData.$));

late final SharedPreferences prefs;
