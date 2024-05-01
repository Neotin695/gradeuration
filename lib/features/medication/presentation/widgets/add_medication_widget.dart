import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/config/appconstnace/media.dart';
import 'package:gradeuration/core/constance/logic_const.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/auth/presentation/pages/auth_signup_page.dart';
import 'package:gradeuration/features/medication/presentation/widgets/counter_widget.dart';
import 'package:sizer/sizer.dart';

import '../bloc/medication_bloc.dart';
import 'add_schedule_widget.dart';

class AddMedicationWidget extends StatefulWidget {
  const AddMedicationWidget({super.key, required this.bloc});
  final MedicationBloc bloc;

  @override
  State<AddMedicationWidget> createState() => _AddMedicationWidgetState();
}

class _AddMedicationWidgetState extends State<AddMedicationWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicationBloc, MedicationState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is MedicationLoading) {
          BotToast.showLoading();
        }
        if (state is MedicationFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.message);
        }
        if (state is MedicationSuccess) {
          BotToast.closeAllLoading();
          BotToast.showWidget(toastBuilder: (f) {
            return _buildCustomDailog(context);
          });
        }
      },
      child: Scaffold(
        appBar: leadingAppBar(context, () {
          context.pop();
        }),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SvgPicture.asset(
              Media.pill.path,
              width: 35.w,
            ),
            const Spacer(),
            Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              color: const Color.fromARGB(255, 57, 57, 57),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    vSpace(3),
                    TxtField(cn: widget.bloc.title, label: t.title),
                    vSpace(2),
                    TxtField(cn: widget.bloc.description, label: t.description),
                    vSpace(2),
                    TxtField(cn: widget.bloc.cause, label: t.cause),
                    vSpace(1),
                    Text(
                      t.timeAndDate,
                      style: txtTheme(context).bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 111, 111, 111)),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 7.h,
                          width: 85.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.bloc.schedules.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: colorsSchedule[
                                      Random().nextInt(colorsSchedule.length)],
                                ),
                                child: Center(
                                  child: Text(
                                    widget.bloc.schedules[index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return AddSchedule(
                                  bloc: widget.bloc,
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    vSpace(1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _builddropDownPicker(
                          Amount.values.map((e) => e).toList(),
                          (value) {
                            widget.bloc.amount = value!;
                            setState(() {});
                          },
                          widget.bloc.amount.name,
                          context,
                        ),
                        CounterWidget(
                          pillCount: widget.bloc.amountValue,
                          title: widget.bloc.amount == Amount.dose
                              ? t.doseText
                              : t.pillText,
                          onDecreas: () {
                            widget.bloc.add(
                                ChangeAmountValue(--widget.bloc.amountValue));
                            setState(() {});
                          },
                          onIncrease: () {
                            widget.bloc.add(
                                ChangeAmountValue(++widget.bloc.amountValue));
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          t.duration,
                          style: txtTheme(context).bodyLarge!.copyWith(
                              color: const Color.fromARGB(255, 111, 111, 111)),
                        ),
                        _builddropDownPicker(
                          DurationMedication.values.map((e) => e).toList(),
                          (value) {
                            widget.bloc.duration = value!.count;
                            setState(() {});
                          },
                          widget.bloc.duration,
                          context,
                        ),
                        Text(
                          t.frequency,
                          style: txtTheme(context).bodyLarge!.copyWith(
                              color: const Color.fromARGB(255, 111, 111, 111)),
                        ),
                        _builddropDownPicker<Frequency>(
                          Frequency.values.map((e) => e).toList(),
                          (value) {
                            widget.bloc.frequency = value!.name;
                            setState(() {});
                          },
                          widget.bloc.frequency,
                          context,
                        )
                      ],
                    ),
                    vSpace(3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: () {}, child: Text(t.cancel)),
                        ElevatedButton(
                            onPressed: () {
                              widget.bloc.add(AddMedicationEvent());
                            },
                            child: Text(t.addReminder)),
                      ],
                    ),
                    vSpace(2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildCustomDailog(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Media.doneState.path),
              Text(
                'Congratulation!',
                style: txtTheme(context)
                    .headlineMedium!
                    .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              vSpace(3),
              const Text('Your Remainder has been scheduled successfully.'),
              vSpace(3),
              ElevatedButton(
                onPressed: () {
                  BotToast.removeAll();
                },
                child: Text(t.continueTxt),
              )
            ],
          ),
        ),
      ),
    );
  }

  _builddropDownPicker<T extends Enum>(
      List<T> list, Function(T?) onChange, value, context) {
    return DropdownButton(
      hint: Text(
        value.toString(),
        style: txtTheme(context).bodyLarge!.copyWith(color: Colors.blue),
      ),
      items: list
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                e.name,
              ),
            ),
          )
          .toList(),
      onChanged: onChange,
    );
  }
}
