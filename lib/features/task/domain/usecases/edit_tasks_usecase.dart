
import '../../../../core/helper/usecase_helper.dart';
import '../repositories/task_repo.dart';

class EditTaskUsecase extends UsecaseHelper<Future<void>> {
  final TaskRepo _taskRepo;

  EditTaskUsecase(this._taskRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _taskRepo.editTask(param);
  }
}
