import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/auth/presentation/pages/auth_signup_page.dart';
import 'package:gradeuration/features/settings/presentation/bloc/settings_bloc.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key, required this.bloc});
  final SettingsBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is SettingsLoading) {
          BotToast.showLoading();
        }

        if (state is SettingsSuccess) {
          // context.pop();
          BotToast.showWidget(
            toastBuilder: (context) => const Center(
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.done),
              ),
            ),
          );
          BotToast.closeAllLoading();
        }
        if (state is SettingsFinish) {
          BotToast.removeAll();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: leadingAppBar(context, () {
            context.pop();
          }),
          body: SafeArea(
            child: Column(
              children: [
                headingTitle(context, t.personalData),
                vSpace(3),
                TxtField(cn: bloc.email, label: t.email),
                TxtField(cn: bloc.fullName, label: t.fullName),
                TxtField(cn: bloc.location, label: t.cityName),
                vSpace(3),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(UpdateProfileEvent());
                  },
                  child: Text(t.save),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
