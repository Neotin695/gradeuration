import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradeuration/features/auth/presentation/pages/auth_signin_page.dart';

import '../../../../../config/appconstnace/media.dart';
import '../../../../../core/tools/tools.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> with TickerProviderStateMixin {
  late final TabController controller;
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Media.logo.path),
            headingTitle(context, t.welcomeBack),
            Text(t.chooseYourLogin),
            TabBar(
              controller: controller,
              tabs: [
                Tab(text: t.credential),
                Tab(text: t.biometric),
                Tab(text: t.caregiver),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  AuthSignInPage(),
                  AuthSignInPage(),
                  AuthSignInPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
