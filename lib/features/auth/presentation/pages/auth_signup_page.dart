import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/tools/tools.dart';
import '../widgets/contact_details.dart';
import '../widgets/medical_history.dart';
import '../widgets/personal_details.dart';
import '../widgets/register_form.dart';
import '../widgets/success_widget.dart';

class AuthSignUpPage extends StatelessWidget {
  const AuthSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl(),
      child: const AuthSignUpView(),
    );
  }
}

class AuthSignUpView extends StatefulWidget {
  const AuthSignUpView({super.key});

  @override
  State<AuthSignUpView> createState() => _AuthSignUpViewState();
}

class _AuthSignUpViewState extends State<AuthSignUpView> {
  late final AuthBloc bloc;
  late final PageController _controller;
  int index = 0;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    _controller = PageController();
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
          _controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
        if (state is AuthFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.message);
        }
      },
      child: Scaffold(
        appBar: leadingAppBar(context, () {
          if (index == 0) {
            context.pop();
          } else {
            _controller.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          }
        }),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Media.logo.path),
                SizedBox(
                  height: 65.h,
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (newIndex) {
                      index = newIndex;
                      setState(() {});
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      RegisterFormWidget(bloc: bloc),
                      PersonalDetailsWidget(bloc: bloc),
                      ContactDetailsWidget(bloc: bloc),
                      MedicalHistoryWidget(bloc: bloc),
                      const SuccessWidget()
                    ],
                  ),
                ),
                vSpace(5),
                ElevatedButton(
                  onPressed: () {
                    if (index == 3) {
                      bloc.add(SignUpEvent());
                    } else if (index == 4) {
                      context.go(AppRoutes.home.path);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(index == 3
                      ? index == 4
                          ? t.continueTxt
                          : t.register
                      : index == 4
                          ? t.continueTxt
                          : t.next),
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
