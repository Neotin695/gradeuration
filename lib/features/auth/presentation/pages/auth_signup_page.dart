import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/constance/logic_const.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/tools/tools.dart';

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
                      _registerForm(context),
                      _personalDetailsForm(context),
                      _contectDetailsForm(context),
                      _medicalHistoryForm(context),
                      _successWidget(context),
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

  Column _successWidget(BuildContext context) {
    return Column(
      children: [
        headingTitle(context, t.goodGo),
        SvgPicture.asset(Media.coverAuth.path),
        Text(t.allDone),
        headingTitle(context, t.letsWonderful),
      ],
    );
  }

  Column _medicalHistoryForm(BuildContext context) {
    return Column(
      children: [
        headingTitle(context, t.letsSetup),
        Text(
          t.aFewStepsAheads,
          style: txtTheme(context)
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(t.medicalHistory),
        vSpace(2),
        _builddropDownPicker(diagnosis, (value) {
          bloc.selectedDiagnosis = value;
          setState(() {});
        }, bloc.selectedDiagnosis),
        vSpace(2),
        _builddropDownPicker(stage, (value) {
          bloc.selectedStage = value;
          setState(() {});
        }, bloc.selectedStage),
        Text(
          t.medicalReporots,
          style: txtTheme(context)
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        bloc.docImage.isEmpty
            ? const SizedBox()
            : ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(bloc.docImage),
                  fit: BoxFit.cover,
                  width: 50.w,
                ),
              ),
        OutlinedButton(
            onPressed: () async {
              bloc.docImage = (await CunningDocumentScanner.getPictures(
                isGalleryImportAllowed:
                    true, // Allow the user to also pick an image from his gallery
              ))!
                  .first;
              setState(() {});
            },
            child: Text(t.upload))
      ],
    );
  }

  Column _contectDetailsForm(BuildContext context) {
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
        vSpace(2),
        TxtField(cn: bloc.city, label: t.cityName),
      ],
    );
  }

  Column _personalDetailsForm(BuildContext context) {
    return Column(
      children: [
        headingTitle(context, t.letsSetup),
        Text(
          t.aFewStepsAheads,
          style: txtTheme(context)
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(t.personalDetails),
        TxtField(cn: bloc.fullName, label: t.fullName),
        vSpace(2),
        _builddropDownPicker(gendar, (value) {
          bloc.selectedGendar = value;
          setState(() {});
        }, bloc.selectedGendar),
        _buildDatePicker(context)
      ],
    );
  }

  Column _registerForm(BuildContext context) {
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

  _builddropDownPicker(List list, onChange, value) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10),
        child: DropdownButton(
          hint: Text(value),
          isExpanded: true,
          items: list
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e['id'],
                  child: Text(
                    e['value'],
                  ),
                ),
              )
              .toList(),
          onChanged: onChange,
        ),
      ),
    );
  }

  _buildDatePicker(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: t.dateOfBirth,
            hintText: bloc.selectedDate != null
                ? DateFormat('dd/MM/yyyy').format(bloc.selectedDate!)
                : 'dd/mm/yyyy',
            suffixIcon: IconButton(
              onPressed: () async {
                bloc.selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2007));
                setState(() {});
              },
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    required this.cn,
    required this.label,
  });
  final TextEditingController cn;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: TextField(
          controller: cn,
          decoration: InputDecoration(
            labelText: label,
            hintText: label,
          ),
        ),
      ),
    );
  }
}
