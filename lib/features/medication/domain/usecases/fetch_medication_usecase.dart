import '../../../../core/helper/usecase_helper.dart';
import '../entities/medication_entity.dart';
import '../repositories/medication_repo.dart';

class FetchMedicationUsecase
    implements UsecaseHelper<Future<MedicationEntity>> {
  final MedicationRepo _medicationRepo;

  FetchMedicationUsecase(this._medicationRepo);

  @override
  Future<MedicationEntity> call(Map<String, dynamic> param) {
    return _medicationRepo.fetchMedication(param['id']);
  }
}
