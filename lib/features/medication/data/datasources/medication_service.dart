import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/features/auth/data/models/user_profile_model.dart';
import 'package:gradeuration/features/medication/data/models/medication_model.dart';

import '../../../../core/helper/notification_service.dart';

class MedicationService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> addMedication(Map<String, dynamic> data) async {
    NotificationService.showScheduleNotification(
        data['title'], data['description'], '', dateConfig(data));
    data['id'] = _store.collection('medications').doc().id;
    final medicationsId = currentUser.medications;
    medicationsId.add(data['id']);
    await _store.collection('users').doc(currentUser.id).update(
        UserProfileModel.fromEntity(
                currentUser.copyWith(medications: medicationsId))
            .toJson());
    await updateUser();

    await _store.collection('medications').doc(data['id']).set(data);
  }

  Future<void> deleteMedication(String id) async {
    final medicationsId = currentUser.medications;
    medicationsId.remove(id);
    await _store
        .collection('users')
        .doc(currentUser.id)
        .update(UserProfileModel.fromEntity(
                currentUser.copyWith(medications: medicationsId))
            .toJson())
        .then(
          (value) async =>
              await _store.collection('medications').doc(id).delete(),
        );
  }

  Stream<List<MedicationModel>> fetchMedications() {
    try {
      return _store
          .collection('medications')
          .where('id', whereIn: currentUser.medications)
          .snapshots()
          .map((event) {
        return event.docs
            .map((e) => MedicationModel.fromJson(e.data()))
            .toList();
      });
    } catch (e) {
      return Stream.error(e);
    }
  }

  Future<void> updateMedication(Map<String, dynamic> data) async {
    await _store.collection('medications').doc(data['id']).update(data);
  }

  DateTime dateConfig(Map<String, dynamic> data) {
    final int count = (data['schedules'] as List<String>).length;
    final int timesPerDay = 24 ~/ count;
    var date = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().day, timesPerDay);

    if (date.isBefore(DateTime.now())) {
      if (data['frequency'] == 'daily') {
        date = date = DateTime(DateTime.now().year, DateTime.now().month,
            (date.day) + 1, DateTime.now().hour, timesPerDay);
      } else if (data['frequency'] == 'weekly') {
        date = date = DateTime(DateTime.now().year, DateTime.now().month,
            (date.day) + 7, DateTime.now().hour, timesPerDay);
      }
    }
    date = date.subtract(const Duration(minutes: 10));

    return date;
  }
}
