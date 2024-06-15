import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/constance/logic_const.dart';
import '../../../../core/tools/shared/txt_field.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/medication_bloc.dart';
import 'add_schedule_widget.dart';
import 'counter_widget.dart';

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
              width: 30.w,
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
                    vSpace(2),
                    TxtField(cn: widget.bloc.title, label: t.title),
                    vSpace(1),
                    TxtField(cn: widget.bloc.description, label: t.description),
                    vSpace(1),
                    TxtField(cn: widget.bloc.cause, label: t.cause),
                    vSpace(1),
                    Text(
                      t.timeAndDate,
                      style: txtTheme(context).bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 111, 111, 111)),
                    ),
                    Visibility(
                      visible: widget.bloc.frequencyType == 'weekly',
                      child: Row(
                        children: [
                          SizedBox(
                            height: 5.h,
                            width: 85.w,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.bloc.daysOfWeek.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: colorsSchedule[Random()
                                        .nextInt(colorsSchedule.length)],
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.bloc.daysOfWeek[index],
                                      style:
                                          const TextStyle(color: Colors.white),
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
                    ),
                    vSpace(1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _builddropDownPicker(
                          Amount.values.map((e) => e).toList(),
                          (value) {
                            widget.bloc.doseType = value!;
                            setState(() {});
                          },
                          widget.bloc.doseType.name,
                          context,
                        ),
                        CounterWidget(
                          pillCount: widget.bloc.dosesPerTimes,
                          title: widget.bloc.doseType == Amount.dose
                              ? t.doseText
                              : t.pillText,
                          onDecreas: () {
                            widget.bloc.add(
                                ChangeAmountValue(--widget.bloc.dosesPerTimes));
                            setState(() {});
                          },
                          onIncrease: () {
                            widget.bloc.add(
                                ChangeAmountValue(++widget.bloc.dosesPerTimes));
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TxtField(
                          cn: widget.bloc.duration,
                          label: t.duration,
                          width: 40.w,
                          type: TextInputType.number,
                        ),
                        Text(
                          t.frequency,
                          style: txtTheme(context).bodyLarge!.copyWith(
                              color: const Color.fromARGB(255, 111, 111, 111)),
                        ),
                        _builddropDownPicker<Frequency>(
                          Frequency.values.map((e) => e).toList(),
                          (value) {
                            widget.bloc.frequencyType = value!.name;
                            setState(() {});
                          },
                          widget.bloc.frequencyType,
                          context,
                        )
                      ],
                    ),
                    vSpace(1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(t.cancel),
                        ),
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
