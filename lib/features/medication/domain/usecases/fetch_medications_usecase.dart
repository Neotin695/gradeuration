import 'package:gradeuration/core/helper/usecase_helper.dart';
import 'package:gradeuration/features/medication/domain/repositories/medication_repo.dart';

import '../entities/medication_entity.dart';

class FetchMedicationUsecase
    implements UsecaseHelper<Stream<List<MedicationEntity>>> {
  final MedicationRepo _medicationRepo;

  FetchMedicationUsecase(this._medicationRepo);

  @override
  Stream<List<MedicationEntity>> call(Map<String, dynamic> param) {
    return _medicationRepo.fetchMedications();
  }
}
