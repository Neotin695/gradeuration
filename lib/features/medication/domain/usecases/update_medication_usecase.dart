import '../../../../core/helper/usecase_helper.dart';
import '../repositories/medication_repo.dart';

class UpdateMedicationUsecase implements UsecaseHelper<Future<void>> {
  final MedicationRepo _medicationRepo;

  UpdateMedicationUsecase(this._medicationRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _medicationRepo.updateMedication(param);
  }
}
