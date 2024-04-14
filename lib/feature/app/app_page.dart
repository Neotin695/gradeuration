import 'package:flutter/material.dart';
import 'package:gradeuration/config/theme/app_theme.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:sizer/sizer.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, deviceType, orientation) => MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
      ),
    );
  }
}
