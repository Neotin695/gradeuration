import 'dart:async';
import 'dart:io';

import '../../domain/repo/global_repo.dart';
import '../datasource/notification_messaging_service.dart';

class GlobalRepoImpl extends GlobalRepo {
  final NotificationMessagingService _messagingService;

  GlobalRepoImpl(this._messagingService);

  @override
  Future<void> sendNotification(Map<String, dynamic> data) async {
    try {
      final response = await _messagingService.sendNotification(
        'key=AAAA_wXrF6k:APA91bGNQuGQrO2UOAg94VY2M-wJ89PAhnN9CvSTwdH6EyTs2AJQBbDp6PdwdsvM1eu7MGWLuePTB5ckL-iIf4D1EUbBqeuQ7tfrHsKCRMe2x_VU0NI18LJGkFu7ZmkutXoFHAMvFRgQ',
        data,
      );

      if (response.response.statusCode == HttpStatus.ok) {}
    } catch (e) {
      throw e;
    }
  }
}
