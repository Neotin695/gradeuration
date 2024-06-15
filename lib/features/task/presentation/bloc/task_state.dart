part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {}
class TaskAdded extends TaskState {}

class TaskFailure extends TaskState {
  final String message;

  const TaskFailure(this.message);
}
