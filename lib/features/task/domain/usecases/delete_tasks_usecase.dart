
import '../../../../core/helper/usecase_helper.dart';
import '../repositories/task_repo.dart';

class DeleteTaskUsecase extends UsecaseHelper<Future<void>> {
  final TaskRepo _taskRepo;

  DeleteTaskUsecase(this._taskRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _taskRepo.deleteTask(param['taskId']);
  }
}
