import '../entities/medication_entity.dart';

abstract class MedicationRepo {
  Future<List<MedicationEntity>> fetchMedications();
  Future<MedicationEntity> fetchMedication(String id);
  Future<void> addMedication(Map<String, dynamic> data);
  Future<void> deleteMedication(Map<String, dynamic> id);
  Future<void> updateMedication(Map<String, dynamic> data);
}
