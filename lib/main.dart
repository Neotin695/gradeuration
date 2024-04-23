import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_value/shared_value.dart';

import 'package:gradeuration/features/app/app_page.dart';

import 'core/helper/local_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  initializeGetIt();
  runApp(SharedValue.wrapApp(const AppPage()));
}
