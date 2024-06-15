// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:another_stepper/another_stepper.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/service/injection_container.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/task_bloc.dart';
import '../widgets/add_mission_widget.dart';

class MissionPage extends StatelessWidget {
  const MissionPage({
    Key? key,
    required this.ids,
    required this.taskId,
  }) : super(key: key);
  final List<String> ids;
  final String taskId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => sl(),
      child: MissionView(ids: ids, taskId: taskId),
    );
  }
}

class MissionView extends StatefulWidget {
  const MissionView({
    Key? key,
    required this.ids,
    required this.taskId,
  }) : super(key: key);
  final List<String> ids;
  final String taskId;
  @override
  State<MissionView> createState() => _TaskViewState();
}

class _TaskViewState extends State<MissionView> {
  late final TaskBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    if (widget.ids.isNotEmpty) {
      bloc.add(FetchMissionEvent(widget.ids));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 3000)),
            lastDate: DateTime.now(),
            onDateChanged: (value) {},
          ),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return loading;
              }

              if (state is TaskSuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 12.w,
                      child: AnotherStepper(
                        stepperList: bloc.missions.map((e) {
                          return StepperData(
                              title: StepperText(''),
                              subtitle: StepperText(''),
                              iconWidget: Icon(
                                !e.isCompleted
                                    ? Icons.circle_outlined
                                    : Icons.circle,
                                color:
                                    !e.isCompleted ? Colors.red : Colors.green,
                              ));
                        }).toList(),
                        stepperDirection: Axis.vertical,
                        iconWidth:
                            40, // Height that will be applied to all the stepper icons
                        iconHeight:
                            40, // Width that will be applied to all the stepper icons
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        width: 80.w,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: bloc.missions.length,
                          itemBuilder: (context, index) {
                            final mission = bloc.missions[index];
                            return Card(
                              color: !mission.isCompleted
                                  ? Colors.red
                                  : Colors.green,
                              elevation: 3,
                              margin: EdgeInsets.only(top: 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                // tileColor: Colors.white,
                                textColor: Colors.white,
                                title: Text(mission.title),
                                subtitle: Text(mission.description),
                                trailing: Text(mission.dateTime),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: bloc.missions.length,
                  itemBuilder: (context, index) {
                    final mission = bloc.missions[index];
                    return Card(
                      color: randomColor(),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(mission.title),
                        subtitle: Text(mission.description),
                        trailing: Text(mission.dateTime),
                      ),
                    );
                  },
                );
              }
              if (state is TaskFailure) {
                return Text(state.message);
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Media.empty.path,
                      width: 50.w,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBtmSheet(
            context,
            AddMissionWidget(
              bloc: bloc,
              taskId: widget.taskId,
              ids: widget.ids,
            ),
          );
        },
        child: const Icon(Icons.add_task),
      ),
    );
  }
}
