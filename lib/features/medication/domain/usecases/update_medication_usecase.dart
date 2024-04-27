import 'package:gradeuration/core/helper/usecase_helper.dart';
import 'package:gradeuration/features/medication/domain/repositories/medication_repo.dart';

class UpdateMedicationUsecase implements UsecaseHelper<Future<void>> {
  final MedicationRepo _medicationRepo;

  UpdateMedicationUsecase(this._medicationRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _medicationRepo.updateMedication(param);
  }
}
