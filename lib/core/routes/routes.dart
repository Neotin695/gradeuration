import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  signin(path: '/signin'),
  signup(path: '/signup'),
  home(path: '/home'),
  init(path: '/');

  const AppRoutes({required this.path});
  final String path;
}

final routes = GoRouter(
  initialLocation: AppRoutes.init.path,
  routes: [
    GoRoute(
      path: AppRoutes.signin.path,
      pageBuilder: (context, state) => MaterialPage(child: Container()),
    ),
    GoRoute(
      path: AppRoutes.signup.path,
      pageBuilder: (context, state) => MaterialPage(child: Container()),
    ),
    GoRoute(
      path: AppRoutes.home.path,
      pageBuilder: (context, state) => MaterialPage(child: Container()),
    ),
  ],
);
