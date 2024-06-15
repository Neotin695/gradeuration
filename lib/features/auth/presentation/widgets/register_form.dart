// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/tools/shared/txt_field.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/auth_bloc.dart';
import '../pages/auth_signup_page.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final AuthBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headingTitle(context, t.register),
        Text(t.createYourAccount),
        TxtField(cn: bloc.userName, label: t.username),
        vSpace(2),
        TxtField(cn: bloc.password, label: t.password),
      ],
    );
  }
}
