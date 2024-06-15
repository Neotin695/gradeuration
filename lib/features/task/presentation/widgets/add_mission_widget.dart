// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/tools/shared/custom_success_dailog.dart';
import '../../../../core/tools/shared/txt_field.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/task_bloc.dart';


class AddMissionWidget extends StatefulWidget {
  const AddMissionWidget({
    Key? key,
    required this.bloc,
    required this.taskId,
    required this.ids,
  }) : super(key: key);
  final TaskBloc bloc;
  final String taskId;
  final List<String> ids;

  @override
  State<AddMissionWidget> createState() => _AddMissionWidgetState();
}

class _AddMissionWidgetState extends State<AddMissionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is TaskLoading) {
          BotToast.showLoading();
        }
        if (state is TaskFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.message);
        }
        if (state is TaskAdded) {
          BotToast.closeAllLoading();
          BotToast.showWidget(toastBuilder: (context) {
            return const CustomSuccessDialog();
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(t.addedTask),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              vSpace(5),
              TxtField(cn: widget.bloc.titleMission, label: t.title),
              vSpace(2),
              TxtField(cn: widget.bloc.descMission, label: t.description),
              vSpace(2),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: t.timeAndDate,
                      hintText: widget.bloc.selectedDate != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(widget.bloc.selectedDate!)
                          : 'dd/mm/yyyy',
                      suffixIcon: IconButton(
                        onPressed: () async {
                          widget.bloc.selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 3000)));
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              vSpace(2),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: t.timeAndDate,
                      hintText: widget.bloc.selectedTime != null
                          ? widget.bloc.selectedTime!.format(context)
                          : 'hh:MM a',
                      suffixIcon: IconButton(
                        onPressed: () async {
                          widget.bloc.selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.alarm,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              vSpace(5),
              ElevatedButton(
                onPressed: () {
                  widget.bloc.add(AddMissionEvent(widget.taskId));
                  widget.bloc.add(FetchMissionEvent(widget.ids));
                },
                child: Text(t.upload),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
