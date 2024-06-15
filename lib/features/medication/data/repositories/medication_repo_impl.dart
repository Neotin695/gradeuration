import '../../domain/entities/medication_entity.dart';
import '../../domain/repositories/medication_repo.dart';
import '../datasources/medication_service.dart';

class MedicationRepoImpl implements MedicationRepo {
  final MedicationService _medicationService;

  MedicationRepoImpl(this._medicationService);
  @override
  Future<void> addMedication(Map<String, dynamic> data) {
    return _medicationService.addMedication(data);
  }

  @override
  Future<void> deleteMedication(Map<String, dynamic> id) {
    return _medicationService.deleteMedication(id);
  }

  @override
  Future<List<MedicationEntity>> fetchMedications() {
    return _medicationService.fetchMedications();
  }

  @override
  Future<void> updateMedication(Map<String, dynamic> data) {
    return _medicationService.updateMedication(data);
  }

  @override
  Future<MedicationEntity> fetchMedication(String id) {
    return _medicationService.fetchMedication(id);
  }
}
