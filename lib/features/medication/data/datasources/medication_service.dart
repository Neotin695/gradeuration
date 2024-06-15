import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradeuration/core/global_archtiecture/domain/usecases/send_notification_usecase.dart';
import 'package:gradeuration/core/helper/firebase_messaging.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/core/helper/notification_service.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/features/auth/data/models/user_profile_model.dart';

import '../../../../core/tools/tools.dart';
import '../../domain/entities/medication_entity.dart';
import '../models/medication_model.dart';

class MedicationService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> addMedication(Map<String, dynamic> data) async {
    MedicationModel medication = MedicationModel.fromJson(data['medication']);
    NotificationService.showNotification();
    final id = _store.collection('medications').doc().id;
    final medicationsId = currentUser.medications;
    medication = MedicationModel.fromEntity(medication.copyWith(id: id));
    medicationsId.add(id);
    await _store.collection('users').doc(currentUser.id).update(
        UserProfileModel.fromEntity(
                currentUser.copyWith(medications: medicationsId))
            .toJson());

    await _store
        .collection('medications')
        .doc(medication.id)
        .set(medication.toJson())
        .then((value) {
      if (medication.frequencyType == 'daily') {
        NotificationService.showScheduleNotificationDay(medication, '');
      } else {
        NotificationService.showScheduleNotificationWeek(medication, '');
      }
    });
  }

  Future<MedicationModel> fetchMedication(String id) async {
    return MedicationModel.fromJson(
        (await _store.collection('medications').doc(id).get()).data()!);
  }

  Future<void> deleteMedication(Map<String, dynamic> data) async {
    final user = UserProfileModel.fromJson(data['medication']);
    final medicationsId = user.medications;
    medicationsId.remove(data['id']);
    await _store
        .collection('users')
        .doc(user.id)
        .update(UserProfileModel.fromEntity(
                user.copyWith(medications: medicationsId))
            .toJson())
        .then(
          (value) async =>
              await _store.collection('medications').doc(data['id']).delete(),
        );
  }

  Future<List<MedicationEntity>> fetchMedications() async {
    try {
      return List<MedicationModel>.from((await _store
              .collection('medications')
              .where('userId', isEqualTo: currentUser.id)
              .get())
          .docs
          .map((e) => MedicationModel.fromJson(e.data())));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateMedication(Map<String, dynamic> data) async {
    final medication = MedicationModel.fromJson(data);
    await _store
        .collection('medications')
        .doc(medication.id)
        .update(data)
        .then((value) async {
      if (data['doctorId'].toString().isNotEmpty) {
        final token =
            (await _store.collection('users').doc(medication.doctorId).get())
                .data()!['token'];
        sl<SendNotificationUsecase>().call({
          'notification': {
            'title': t.updateTitle,
            'body': t.updateBody(currentUser.fullName),
          },
          'data': {
            'type': 'update-medication',
            'medicationId': medication.id,
          },
          'to': token,
        });
      }
    });
  }
}
