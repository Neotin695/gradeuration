import 'package:gradeuration/core/helper/usecase_helper.dart';
import 'package:gradeuration/features/medication/domain/repositories/medication_repo.dart';

class AddMedicationUsecase implements UsecaseHelper<Future<void>> {
  final MedicationRepo _medicationRepo;

  AddMedicationUsecase(this._medicationRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _medicationRepo.addMedication(param);
  }
}
