import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/settings/presentation/widgets/medication_reocrd_widget.dart';
import 'package:gradeuration/features/settings/presentation/widgets/personal_data_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/service/injection_container.dart';
import '../bloc/settings_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => sl(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final SettingsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsFinish) {
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.profile),
        ),
        body: SafeArea(
          child: Column(
            children: [
              vSpace(10),
              currentUser.profileImg.isEmpty
                  ? CircleAvatar(
                      radius: 40.sp,
                      child: const Icon(Icons.camera),
                    )
                  : CircleAvatar(
                      radius: 40.sp,
                      foregroundImage: NetworkImage(currentUser.profileImg),
                    ),
              headingTitle(context, currentUser.fullName),
              Text(
                currentUser.role,
                style: txtTheme(context)
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider()),
              _customListTile(
                context,
                onTap: () {
                  showBtmSheet(context, PersonalData(bloc: bloc));
                },
                title: t.personalData,
                leading: Icons.person,
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _customListTile(
                context,
                onTap: () {
                  showBtmSheet(context, const MedicationRecordWidget());
                },
                title: t.medicalRecord,
                leading: Icons.medical_information_outlined,
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _customListTile(
                context,
                onTap: () {},
                title: t.emergency,
                leading: Icons.emergency,
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider()),
              _customListTile(
                context,
                onTap: () {},
                title: t.help,
                leading: Icons.help,
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
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
