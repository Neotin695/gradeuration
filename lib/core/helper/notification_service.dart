import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:gradeuration/core/constance/logic_const.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/features/medication/data/models/medication_model.dart';
import 'package:gradeuration/features/medication/domain/entities/medication_entity.dart';

class NotificationService {
  static init() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'medication_channel',
            channelKey: 'medication_channel',
            channelName: 'notification blabla',
            channelDescription: 'notification blabla')
      ],
    );
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (action) async {
        if (action.payload!['page-name'] == AppRoutes.medicationNotify.path) {
          routes.go(homeRoute(AppRoutes.medicationNotify.path),
              extra: action.payload!['id']);
        }
      },
    );
  }

  static Future<void> showNotification() async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'medication_channel',
            title: 'test',
            payload: {
              'page-name': AppRoutes.medicationNotify.path,
              'id': 'bn6QzoCmMYY1eAnCgJtP'
            },
            body: 'test body'));
  }

  static Future<void> showScheduleNotificationDay(
      MedicationEntity medication, String payload) async {
    for (int i = 0; i < medication.timesPerDay; i++) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: i,
            channelKey: 'medication_channel',
            title: 'Medication Reminder',
            payload: {
              'id': medication.id,
              'userId': medication.userId,
              'page-name': 'medication_notify',
            },
            body:
                'It\'s time to take your medication: ${medication.title}\nand take ${medication.doseType}:${medication.dosesPerTimes}'),
        schedule: NotificationCalendar(
          hour: 8 + i * (24 ~/ medication.timesPerDay),
          minute: 0,
          second: 0,
          repeats: true,
        ),
      );
    }
  }

  static Future<void> showScheduleNotificationWeek(
      MedicationEntity medication, String payload) async {
    for (var dayOfWeek in medication.daysOfWeek) {
      int notificationDay = daysMap[dayOfWeek]!;

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationDay,
          channelKey: 'medication_channel',
          title: 'Medication Reminder',
          payload: {
            'id': medication.id,
            'userId': medication.userId,
            'page-name': 'medication_notify',
          },
          body:
              'It\'s time to take your medication: ${medication.title}\nand take ${medication.doseType}:${medication.dosesPerTimes}',
        ),
        schedule: NotificationCalendar(
          weekday: notificationDay,
          hour: 0,
          minute: 0,
          second: 0,
          repeats: true,
        ),
      );
    }
  }
}
