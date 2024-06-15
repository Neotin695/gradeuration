// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/tools/shared/txt_field.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/auth_bloc.dart';

class ContactDetailsWidget extends StatelessWidget {
  const ContactDetailsWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final AuthBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headingTitle(context, t.letsSetup),
        Text(
          t.aFewStepsAheads,
          style: txtTheme(context)
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(t.contactDetails),
        TxtField(cn: bloc.email, label: t.email),
        vSpace(2),
        TxtField(cn: bloc.city, label: t.cityName),
        vSpace(2),
        vSpace(2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              bloc.phoneNum = number.phoneNumber!;
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              useBottomSheetSafeArea: true,
            ),
            hintText: t.enterPhone,
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.always,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
          ),
        ),
      ],
    );
  }
}
