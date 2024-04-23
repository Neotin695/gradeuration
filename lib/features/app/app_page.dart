import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gradeuration/config/theme/app_theme.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:sizer/sizer.dart';

import '../../config/lang/l10n/l10n.dart';
import '../../core/core.dart';
import '../../core/helper/local_data.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_AppPageState>()?.restartApp();
  }

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late String code;
  @override
  void initState() {
    code = prefs.getString('lang') ?? 'en';
    super.initState();
  }

  Key key = UniqueKey();

  void restartApp() {
    code = prefs.getString('lang') ?? 'en';
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, deviceType, orientation) => MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
        locale: Locale(code),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: BotToastInit(),
        supportedLocales: L10n.languages,
      ),
    );
  }
}
