
import '../../../../core/helper/usecase_helper.dart';
import '../repositories/task_repo.dart';

class AddTaskUsecase extends UsecaseHelper<Future<void>> {
  final TaskRepo _taskRepo;

  AddTaskUsecase(this._taskRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _taskRepo.addTask(param);
  }
}
