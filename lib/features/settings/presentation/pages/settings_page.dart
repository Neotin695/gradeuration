import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/core/tools/tools.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.accessibility,
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(Icons.near_me_outlined),
            title: Text(
              t.whereIam,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(Icons.accessibility_sharp),
            title: Text(
              t.talkBack,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
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
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(Icons.notifications),
            title: Text(
              t.notifications,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
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
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(Icons.person),
            title: Text(
              t.editProfile,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(Icons.lock),
            title: Text(
              t.changePassword,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(Icons.logout),
            title: Text(
              t.logout,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: Text(
              t.deleteAccount,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t.support,
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.go(AppRoutes.init.path);
            },
            leading: const Icon(Icons.support),
            title: Text(
              t.contactUs,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
