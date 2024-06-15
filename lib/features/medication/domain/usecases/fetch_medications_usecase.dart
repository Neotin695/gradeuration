import '../../../../core/helper/usecase_helper.dart';
import '../entities/medication_entity.dart';
import '../repositories/medication_repo.dart';

class FetchMedicationsUsecase
    implements UsecaseHelper<Future<List<MedicationEntity>>> {
  final MedicationRepo _medicationRepo;

  FetchMedicationsUsecase(this._medicationRepo);

  @override
  Future<List<MedicationEntity>> call(Map<String, dynamic> param) {
    return _medicationRepo.fetchMedications();
  }
}
