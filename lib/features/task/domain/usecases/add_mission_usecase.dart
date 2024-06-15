
import '../../../../core/helper/usecase_helper.dart';
import '../repositories/task_repo.dart';

class AddMissionUsecase extends UsecaseHelper<Future<void>> {
  final TaskRepo _taskRepo;

  AddMissionUsecase(this._taskRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _taskRepo.addMission(param);
  }
}
