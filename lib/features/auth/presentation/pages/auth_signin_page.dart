import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

class AuthSignInPage extends StatelessWidget {
  const AuthSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl(),
      child: const AuthSignInView(),
    );
  }
}

class AuthSignInView extends StatefulWidget {
  const AuthSignInView({super.key});

  @override
  State<AuthSignInView> createState() => _AuthSignInViewState();
}

class _AuthSignInViewState extends State<AuthSignInView> {
  late final AuthBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          BotToast.showLoading();
        }
        if (state is AuthSuccess) {
          BotToast.closeAllLoading();
          if (currentUser.medications.isEmpty) {
            context.go(AppRoutes.home.path);
          } else {
            context.go(signinRoute(AppRoutes.settingup.path));
          }
        }
        if (state is AuthFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: TextField(
                    controller: bloc.email,
                    decoration: InputDecoration(
                      labelText: t.username,
                      hintText: t.username,
                    ),
                  ),
                ),
                vSpace(2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: TextField(
                    controller: bloc.password,
                    decoration: InputDecoration(
                      labelText: t.password,
                      hintText: t.password,
                    ),
                  ),
                ),
                vSpace(5),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(SignInEvent());
                  },
                  child: Text(t.login),
                ),
                vSpace(2),
                TextButton(
                  onPressed: () {},
                  child: Text(t.forgotMyPassword),
                ),
                vSpace(30),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: t.dontHaveAnAccount,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                        text: t.register,
                        style: TextStyle(color: Colors.blue[900]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(signinRoute(AppRoutes.signup.path));
                          },
                      ),
                    ],
                  ),
                ),
                vSpace(3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
