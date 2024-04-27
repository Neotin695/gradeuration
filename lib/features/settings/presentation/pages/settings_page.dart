import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/language/presentation/view/lang_page.dart';
import 'package:gradeuration/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:gradeuration/features/settings/presentation/pages/map_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => sl(),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.accessibility,
            ),
          ),
          _customListTile(
            context,
            onTap: () {
              showBtmSheet(context, const MapPage());
            },
            title: t.whereIam,
            leading: Icons.near_me_outlined,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          _customListTile(
            context,
            onTap: () {},
            leading: Icons.accessibility_sharp,
            title: t.talkBack,
            trailing: Switch(
              onChanged: (value) {},
              value: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.notification,
            ),
          ),
          _customListTile(
            context,
            onTap: () {},
            leading: Icons.notifications,
            title: t.notifications,
            trailing: Switch(
              onChanged: (value) {},
              value: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.account,
            ),
          ),
          _customListTile(
            context,
            onTap: () {
              context.go(settingsRoute(AppRoutes.profile.path));
            },
            leading: Icons.person,
            title: t.editProfile,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          _customListTile(
            context,
            onTap: () {},
            leading: Icons.lock,
            title: t.changePassword,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          _customListTile(
            context,
            onTap: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                context.go(AppRoutes.signin.path, extra: false);
              });
            },
            leading: Icons.logout,
            title: t.logout,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          _customListTile(
            context,
            onTap: () {},
            leading: Icons.delete,
            iconColor: Colors.red,
            title: t.deleteAccount,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.language,
            ),
          ),
          _customListTile(
            context,
            onTap: () {
              showBtmSheet(context, const LangPage());
            },
            leading: Icons.language,
            title: t.language,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.support,
            ),
          ),
          _customListTile(
            context,
            onTap: () {},
            leading: Icons.support,
            title: t.contactUs,
          ),
        ],
      ),
    );
  }

  ListTile _customListTile(
    BuildContext context, {
    required VoidCallback onTap,
    required String title,
    required IconData leading,
    Color? iconColor,
    Widget? trailing,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        leading,
        color: iconColor,
      ),
      title: Text(
        title,
        style:
            txtTheme(context).bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: trailing,
    );
  }
}
