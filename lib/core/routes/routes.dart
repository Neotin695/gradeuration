import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/features/auth/presentation/pages/auth_signup_page.dart';
import 'package:gradeuration/features/auth/presentation/pages/setting_up_medication_page.dart';
import 'package:gradeuration/features/auth/presentation/pages/welcome_page.dart';
import 'package:gradeuration/features/home/pages/home_page.dart';
import 'package:gradeuration/features/medication/presentation/pages/medication_notify_page.dart';
import 'package:gradeuration/features/medication/presentation/pages/medication_page.dart';
import 'package:gradeuration/features/settings/presentation/pages/profile_page.dart';
import 'package:gradeuration/features/settings/presentation/pages/settings_page.dart';

import '../../features/task/presentation/pages/mission_page.dart';
import '../../features/task/presentation/pages/task_page.dart';

enum AppRoutes {
  signin(path: '/signin'),
  signup(path: 'signup'),
  settings(path: 'settings'),
  home(path: '/home'),
  profile(path: 'profile'),
  medication(path: 'medication'),
  medicationNotify(path: 'medication_notify'),
  settingup(path: 'settingup'),
  task(path: 'task'),
  mission(path: 'mission'),
  init(path: '/');

  const AppRoutes({required this.path});
  final String path;
}

signinRoute(path) => '/signin/$path';
taskRoute(path) => '/home/task/$path';
homeRoute(path) => '/home/$path';
settingsRoute(path) => '/home/settings/$path';

final routes = GoRouter(
  initialLocation: AppRoutes.signin.path,
  redirect: (context, state) async {
    if (state.matchedLocation == '/signin') {
      if (FirebaseAuth.instance.currentUser != null) {
        await updateUser();
        return AppRoutes.home.path;
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.signin.path,
      pageBuilder: (context, state) => const MaterialPage(child: WelcomPage()),
      routes: [
        GoRoute(
          path: AppRoutes.signup.path,
          pageBuilder: (context, state) =>
              const MaterialPage(child: AuthSignUpPage()),
        ),
        GoRoute(
          path: AppRoutes.settingup.path,
          pageBuilder: (context, state) =>
              const MaterialPage(child: SettingUpMedicationPage()),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.home.path,
      pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
      routes: [
        GoRoute(
          path: AppRoutes.settings.path,
          pageBuilder: (context, state) =>
              const MaterialPage(child: SettingsPage()),
          routes: [
            GoRoute(
              path: AppRoutes.profile.path,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ProfilePage()),
              routes: [],
            ),
          ],
        ),
        GoRoute(
            path: AppRoutes.task.path,
            pageBuilder: (context, state) =>
                const MaterialPage(child: TaskPage()),
            routes: [
              GoRoute(
                path: AppRoutes.mission.path,
                pageBuilder: (context, state) {
                  final ids = (state.extra as List<dynamic>)[0];
                  final taskId = (state.extra as List<dynamic>)[1];
                  return MaterialPage(
                      child: MissionPage(ids: ids, taskId: taskId));
                },
              ),
            ]),
        GoRoute(
          path: AppRoutes.medication.path,
          pageBuilder: (context, state) =>
              const MaterialPage(child: MedicationPage()),
        ),
        GoRoute(
          path: AppRoutes.medicationNotify.path,
          pageBuilder: (context, state) => MaterialPage(
              child: MedicationNotifyPage(id: (state.extra as String))),
        ),
      ],
    ),
  ],
);
