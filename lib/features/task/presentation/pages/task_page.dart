import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/service/injection_container.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/task_bloc.dart';
import '../widgets/add_task_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => sl(),
      child: const TaskView(),
    );
  }
}

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late final TaskBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc.add(FetchTasksEvent());
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
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: bloc.tasks.length,
                  itemBuilder: (context, index) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: bloc.tasks.length,
                      itemBuilder: (context, index) {
                        final task = bloc.tasks[index];
                        return Card(
                          color: randomColor(),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            onTap: () {
                              context.go(taskRoute(AppRoutes.mission.path),
                                  extra: [task.missions, task.id]);
                            },
                            leading: CircleAvatar(
                              radius: 35,
                              child: SvgPicture.asset(Media.taskIcon.path,
                                  width: 8.w),
                            ),
                            title: Text(task.title),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task.description),
                                vSpace(1),
                                Row(
                                  children: [
                                    Text(
                                        '${((task.completedMissions / task.missions.length) * 100).toDouble().toStringAsFixed(0)}%'),
                                    hSpace(2),
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: double.parse(
                                            (task.completedMissions /
                                                    task.missions.length)
                                                .toString()),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Text(task.status),
                          ),
                        );
                      },
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
                      width: 40.w,
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
          showBtmSheet(context, AddTaskWidget(bloc: bloc));
        },
        child: const Icon(Icons.add_task),
      ),
    );
  }
}
