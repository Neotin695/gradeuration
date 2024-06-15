import '../entities/mission_entity.dart';
import '../entities/task_entity.dart';

abstract class TaskRepo {
  Future<List<TaskEntity>> fetchTasks();
  Future<void> addTask(Map<String, dynamic> data);
  Future<void> deleteTask(String taskId);
  Future<void> editTask(Map<String, dynamic> data);
  Future<void> addMission(Map<String, dynamic> data);
  Future<List<MissionEntity>> fetchMissions(List<String> missionsIds);
}
