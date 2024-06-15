import '../../../../core/helper/usecase_helper.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repo.dart';

class FetchTasksUsecase extends UsecaseHelper<Future<List<TaskEntity>>> {
  final TaskRepo _taskRepo;

  FetchTasksUsecase(this._taskRepo);

  @override
  Future<List<TaskEntity>> call(Map<String, dynamic> param) {
    return _taskRepo.fetchTasks();
  }
}
