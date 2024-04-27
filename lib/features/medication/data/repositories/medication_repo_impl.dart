import 'package:gradeuration/features/medication/data/datasources/medication_service.dart';
import 'package:gradeuration/features/medication/domain/entities/medication_entity.dart';
import 'package:gradeuration/features/medication/domain/repositories/medication_repo.dart';

class MedicationRepoImpl implements MedicationRepo {
  final MedicationService _medicationService;

  MedicationRepoImpl(this._medicationService);
  @override
  Future<void> addMedication(Map<String, dynamic> data) {
    return _medicationService.addMedication(data);
  }

  @override
  Future<void> deleteMedication(String id) {
    return _medicationService.deleteMedication(id);
  }

  @override
  Stream<List<MedicationEntity>> fetchMedications() {
    return _medicationService.fetchMedications();
  }

  @override
  Future<void> updateMedication(Map<String, dynamic> data) {
    return _medicationService.updateMedication(data);
  }
}
