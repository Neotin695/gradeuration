import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/core/helper/notification_service.dart';
import 'package:gradeuration/features/medication/data/models/medication_model.dart';

class MedicationService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> addMedication(Map<String, dynamic> data) async {
    final int count = data['schedules'] as int;
    final int timesPerDay = 24 ~/ count;
    // final int countWeek = data['timesPerWeek'] as int;

    for (int i = 0; i < count; i++) {
      NotificationService.showScheduleNotification(
          data['title'],
          data['description'],
          '',
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, DateTime.now().day, timesPerDay * i));
    }
    final String id = _store.collection('medications').doc().id;
    data['id'] = id;
    await _store.collection('medications').doc(id).set(data);
  }

  Future<void> deleteMedication(String id) async {
    await _store.collection('medications').doc(id).delete();
  }

  Stream<List<MedicationModel>> fetchMedications() {
    if (currentUser.medications.isEmpty) {
      return const Stream.empty();
    }
    List<MedicationModel> medications = [];
    for (var id in currentUser.medications) {
      _store.collection('medications').doc(id).snapshots().map((event) {
        final medication = MedicationModel.fromJson(event.data()!);
        medications.add(medication);
      });
    }
    return Stream.value(medications);
  }

  Future<void> updateMedication(Map<String, dynamic> data) async {
    await _store.collection('medications').doc(data['id']).update(data);
  }
}
