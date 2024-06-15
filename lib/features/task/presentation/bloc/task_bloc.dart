import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/local_data.dart';
import '../../../../core/tools/tools.dart';
import '../../data/models/mission_model.dart';
import '../../data/models/task_model.dart';
import '../../domain/entities/mission_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/add_mission_usecase.dart';
import '../../domain/usecases/add_tasks_usecase.dart';
import '../../domain/usecases/delete_tasks_usecase.dart';
import '../../domain/usecases/edit_tasks_usecase.dart';
import '../../domain/usecases/fetch_mission_usecase.dart';
import '../../domain/usecases/fetch_tasks_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FetchTasksUsecase _fetchTasksUsecase;
  final AddTaskUsecase _addTaskUsecase;
  final EditTaskUsecase _editTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  final AddMissionUsecase _addMissionUsecase;
  final FetchMissionUsecase _fetchMissionUsecase;
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController titleMission = TextEditingController();
  final TextEditingController descMission = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<TaskEntity> tasks = [];
  List<MissionEntity> missions = [];
  String selectedPatient = '';
  TaskBloc(
      this._fetchTasksUsecase,
      this._addTaskUsecase,
      this._editTaskUsecase,
      this._deleteTaskUsecase,
      this._addMissionUsecase,
      this._fetchMissionUsecase)
      : super(TaskInitial()) {
    on<FetchTasksEvent>(_fetchTaskEvent);
    on<AddTaskEvent>(_addTaskEvent);
    on<EditTaskEvent>(_editTaskEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
    on<AddMissionEvent>(_addMissionEvent);
    on<FetchMissionEvent>(_fetchMissionEvent);
  }

  FutureOr<void> _fetchMissionEvent(event, emit) async {
    emit(TaskLoading());
    try {
      final data =
          await _fetchMissionUsecase({'missionsIds': event.missionsIds});

      missions = data;
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  FutureOr<void> _addMissionEvent(event, emit) async {
    emit(TaskLoading());
    final dateTime = DateTime(selectedDate!.year, selectedDate!.month,
        selectedDate!.day, selectedTime!.hour, selectedTime!.minute);
    try {
      await _addMissionUsecase(
        MissionModel(
                id: '',
                title: titleMission.text,
                description: descMission.text,
                dateTime: convDate(dateTime),
                taskId: event.taskId,
                isCompleted: false)
            .toJson(),
      );
      emit(TaskAdded());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  FutureOr<void> _deleteTaskEvent(event, emit) async {
    emit(TaskLoading());
    try {
      await _deleteTaskUsecase({'taskId': event.id});
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  FutureOr<void> _editTaskEvent(event, emit) async {
    emit(TaskLoading());
    try {
      await _editTaskUsecase(TaskModel.fromEntity(event.task.copyWith(
        title: title.text == event.task.title ? null : title.text,
        description: desc.text == event.task.description ? null : desc.text,
        dateTime: convDate(selectedDate!),
      )).toJson());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  FutureOr<void> _addTaskEvent(event, emit) async {
    emit(TaskLoading());
    try {
      await _addTaskUsecase(TaskModel(
        id: '',
        whoAdded: 'doctor',
        userId: selectedPatient,
        doctorId: currentUser.id,
        title: title.text,
        description: desc.text,
        status: 'pending',
        progress: 0,
        completedMissions: 0,
        missions: [],
      ).toJson());
      emit(TaskAdded());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  FutureOr<void> _fetchTaskEvent(event, emit) async {
    emit(TaskLoading());
    try {
      tasks = await _fetchTasksUsecase({});
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }
}
