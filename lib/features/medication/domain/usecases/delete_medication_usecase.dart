import 'package:gradeuration/core/helper/usecase_helper.dart';
import 'package:gradeuration/features/medication/domain/repositories/medication_repo.dart';

class DeleteMedicationUsecase implements UsecaseHelper<Future<void>> {
  final MedicationRepo _medicationRepo;

  DeleteMedicationUsecase(this._medicationRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _medicationRepo.deleteMedication(param['id']);
  }
}
