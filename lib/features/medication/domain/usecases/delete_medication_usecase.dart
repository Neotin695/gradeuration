import '../../../../core/helper/usecase_helper.dart';
import '../repositories/medication_repo.dart';

class DeleteMedicationUsecase implements UsecaseHelper<Future<void>> {
  final MedicationRepo _medicationRepo;

  DeleteMedicationUsecase(this._medicationRepo);

  @override
  Future<void> call(Map<String, dynamic> param) {
    return _medicationRepo.deleteMedication(param['id']);
  }
}
