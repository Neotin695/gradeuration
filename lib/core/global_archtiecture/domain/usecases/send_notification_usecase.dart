import '../../../helper/usecase_helper.dart';
import '../repo/global_repo.dart';

class SendNotificationUsecase extends UsecaseHelper<Future<void>> {
  final GlobalRepo _globalRepo;

  SendNotificationUsecase(this._globalRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _globalRepo.sendNotification(param);
  }
}
