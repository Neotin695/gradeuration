import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_value/shared_value.dart';

import 'package:gradeuration/features/app/app_page.dart';

import 'core/helper/firebase_messaging.dart';
import 'core/helper/local_data.dart';
import 'core/helper/notification_service.dart';
import 'core/service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  initializeGetIt();
  NotificationService.init();

  await FirebaseMessagingService.instance.initializeFirebaseMessaging();
  NotificationService.showNotification();
  runApp(SharedValue.wrapApp(const AppPage()));
}
