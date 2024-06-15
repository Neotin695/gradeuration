// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/tools/shared/custom_success_dailog.dart';
import '../../../../core/tools/shared/txt_field.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/task_bloc.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final TaskBloc bloc;

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  @override
  void initState() {
    // if (currentUser.users.isNotEmpty) {
    //   widget.bloc.add(FetchPatientsEvent());
    // }
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
              TxtField(cn: widget.bloc.title, label: t.title),
              vSpace(2),
              TxtField(cn: widget.bloc.desc, label: t.description),
              vSpace(5),
              ElevatedButton(
                onPressed: () {
                  widget.bloc.add(AddTaskEvent());
                  widget.bloc.add(FetchTasksEvent());
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
