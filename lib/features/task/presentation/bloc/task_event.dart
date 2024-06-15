part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class FetchTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {}

class AddMissionEvent extends TaskEvent {
  final String taskId;

  const AddMissionEvent(this.taskId);
}

class EditTaskEvent extends TaskEvent {
  final TaskEntity task;

  const EditTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);
}

class FetchPatientsEvent extends TaskEvent {}

class FetchMissionEvent extends TaskEvent {
  final List<String> missionsIds;

  const FetchMissionEvent(this.missionsIds);
}
