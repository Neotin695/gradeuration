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
import 'package:sizer/sizer.dart';

import '../bloc/medication_bloc.dart';

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
        if (state is MedicationSuccess) {
          BotToast.showWidget(toastBuilder: (context) {
            return Column(
              children: [
                SvgPicture.asset(Media.doneState.path),
                Text(
                  'Congratulation!',
                  style: txtTheme(context).headlineMedium!.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const Text('Your Remainder has been scheduled successfully.'),
                ElevatedButton(
                  onPressed: () {
                    BotToast.removeAll();
                  },
                  child: Text(t.continueTxt),
                )
              ],
            );
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
            SvgPicture.asset(Media.pill.path),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  vSpace(3),
                  TxtField(cn: widget.bloc.title, label: t.title),
                  vSpace(2),
                  TxtField(cn: widget.bloc.description, label: t.description),
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
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green,
                              ),
                              child: const Center(
                                child: Text(
                                  'Before Breakfast',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView.builder(
                                itemCount: schedule.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap:(){
                                                       
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: colorsSchedule[Random()
                                            .nextInt(colorsSchedule.length)],
                                      ),
                                      child: Center(
                                        child: Text(
                                          schedule[index],
                                          style: const TextStyle(
                                              color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        t.duration,
                        style: txtTheme(context).bodyLarge!.copyWith(
                            color: const Color.fromARGB(255, 111, 111, 111)),
                      ),
                      _builddropDownPicker(
                        DurationMedication.values.map((e) => e.name).toList(),
                        (value) {
                          widget.bloc.duration = value;
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
                      _builddropDownPicker(
                        Frequency.values.map((e) => e.name).toList(),
                        (value) {
                          widget.bloc.frequency = value;
                          setState(() {});
                        },
                        widget.bloc.frequency,
                        context,
                      )
                    ],
                  ),
                  vSpace(3),
                  ElevatedButton(
                      onPressed: () {
                        widget.bloc.add(AddMedicationEvent());
                      },
                      child: Text(t.addReminder)),
                  vSpace(3),
                  TextButton(onPressed: () {}, child: Text(t.cancel)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _builddropDownPicker(List list, onChange, value, context) {
    return DropdownButton(
      hint: Text(
        value.toString(),
        style: txtTheme(context).bodyLarge!.copyWith(color: Colors.blue),
      ),
      items: list
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
              ),
            ),
          )
          .toList(),
      onChanged: onChange,
    );
  }
}
