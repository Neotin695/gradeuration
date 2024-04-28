import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static init() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'reminder_notification',
            channelKey: 'reminder_notification',
            channelName: 'notification blabla',
            channelDescription: 'notification blabla')
      ],
    );
  }

  static Future<void> showScheduleNotification(
      String title, String body, String payload, DateTime dateTime) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: body.hashCode,
        channelKey: 'reminder_notification',
        actionType: ActionType.Default,
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(
        timeZone: dateTime.timeZoneName,
        day: dateTime.day,
        year: dateTime.year,
        month: dateTime.month,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: dateTime.second,
      ),
    );
  }
}
