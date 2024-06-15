import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/config/appconstnace/media.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lottie/lottie.dart';

class SettingUpMedicationPage extends StatefulWidget {
  const SettingUpMedicationPage({super.key});

  @override
  State<SettingUpMedicationPage> createState() =>
      _SettingUpMedicationPageState();
}

class _SettingUpMedicationPageState extends State<SettingUpMedicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl(),
      child: const SettingUpMedicationView(),
    );
  }
}

class SettingUpMedicationView extends StatefulWidget {
  const SettingUpMedicationView({super.key});

  @override
  State<SettingUpMedicationView> createState() =>
      _SettingUpMedicationViewState();
}

class _SettingUpMedicationViewState extends State<SettingUpMedicationView> {
  late final AuthBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc.add(FetchMedicationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            await Future.delayed(const Duration(seconds: 2), () {
              context.go(AppRoutes.home.path);
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(Media.settingup.path),
            vSpace(2),
            headingTitle(context, t.makeMagic),
          ],
        ),
      ),
    );
  }
}
