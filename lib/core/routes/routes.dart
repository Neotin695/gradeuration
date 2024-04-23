import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/features/auth/presentation/pages/auth_signup_page.dart';
import 'package:gradeuration/features/auth/presentation/pages/welcome_page.dart';
import 'package:gradeuration/features/home/pages/home_page.dart';
import 'package:gradeuration/features/settings/presentation/pages/settings_page.dart';

enum AppRoutes {
  signin(path: '/signin'),
  signup(path: 'signup'),
  settings(path: 'settings'),
  home(path: '/home'),
  init(path: '/');

  const AppRoutes({required this.path});
  final String path;
}

signinRoute(path) => '/signin/$path';

homeRoute(path) => '/home/$path';

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
        ),
      ],
    ),
  ],
);
