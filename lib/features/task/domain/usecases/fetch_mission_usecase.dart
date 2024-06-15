import '../../../../core/helper/usecase_helper.dart';
import '../entities/mission_entity.dart';
import '../repositories/task_repo.dart';

class FetchMissionUsecase extends UsecaseHelper<Future<List<MissionEntity>>> {
  final TaskRepo _taskRepo;

  FetchMissionUsecase(this._taskRepo);

  @override
  Future<List<MissionEntity>> call(Map<String, dynamic> param) {
    return _taskRepo.fetchMissions(param['missionsIds']);
  }
}
