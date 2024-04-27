import 'package:gradeuration/features/medication/domain/entities/medication_entity.dart';

abstract class MedicationRepo {
  Stream<List<MedicationEntity>> fetchMedications();
  Future<void> addMedication(Map<String, dynamic> data);
  Future<void> deleteMedication(String id);
  Future<void> updateMedication(Map<String, dynamic> data);
}
