// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../../core/constance/logic_const.dart';
import '../../../../core/tools/shared/custom_drop_down.dart';
import '../../../../core/tools/shared/txt_field.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/auth_bloc.dart';
import '../pages/auth_signup_page.dart';
import 'date_picker_widget.dart';

class PersonalDetailsWidget extends StatefulWidget {
  const PersonalDetailsWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final AuthBloc bloc;
  @override
  State<PersonalDetailsWidget> createState() => _PersonalDetailsWidgetState();
}

class _PersonalDetailsWidgetState extends State<PersonalDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          headingTitle(context, t.letsSetup),
          Text(
            t.aFewStepsAheads,
            style: txtTheme(context)
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(t.personalDetails),
          TxtField(cn: widget.bloc.fullName, label: t.fullName),
          vSpace(2),
          vSpace(2),
          CustomDropdown(
            list: gendar,
            onChange: (value) {
              widget.bloc.selectedGendar = value!;
              setState(() {});
            },
            value: widget.bloc.selectedGendar,
          ),
          vSpace(2),
          DatePickerWidget(
            bloc: widget.bloc,
          ),
        ],
      ),
    );
  }
}
