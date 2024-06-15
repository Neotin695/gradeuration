import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constance/logic_const.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/medication_bloc.dart';
import 'schedule_item.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key, required this.bloc});
  final MedicationBloc bloc;

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(t.cancel)),
            TextButton(
                onPressed: () {
                  widget.bloc.daysOfWeek = widget.bloc.selectedDays;

                  context.pop();
                },
                child: Text(t.save)),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: schedule.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (widget.bloc.selectedDays.contains(schedule[index])) {
                    widget.bloc.selectedDays.remove(schedule[index]);
                  } else {
                    if (widget.bloc.selectedDays.length < 3) {
                      widget.bloc.selectedDays.add(schedule[index]);
                    } else {
                      BotToast.showText(text: t.limitSchedule);
                    }
                  }

                  setState(() {});
                },
                child: Row(
                  children: [
                    ScheduleItem(title: schedule[index]),
                    Visibility(
                      visible:
                          widget.bloc.selectedDays.contains(schedule[index]),
                      child: const Icon(Icons.done),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
