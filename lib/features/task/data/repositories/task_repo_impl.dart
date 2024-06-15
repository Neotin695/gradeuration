
import '../../domain/entities/mission_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repo.dart';
import '../datasources/task_service.dart';

class TaskRepoImpl implements TaskRepo {
  final TaskService _taskService;

  TaskRepoImpl(this._taskService);
  @override
  Future<void> addTask(Map<String, dynamic> data) {
    return _taskService.addTask(data);
  }

  @override
  Future<void> deleteTask(String taskId) {
    return _taskService.deleteTask(taskId);
  }

  @override
  Future<void> editTask(Map<String, dynamic> data) {
    return _taskService.editTask(data);
  }

  @override
  Future<List<TaskEntity>> fetchTasks() {
    return _taskService.fetchTasks();
  }

  @override
  Future<void> addMission(Map<String, dynamic> data) {
    return _taskService.addMission(data);
  }

  @override
  Future<List<MissionEntity>> fetchMissions(List<String> missionsIds) {
    return _taskService.fetchMissions(missionsIds);
  }
}
