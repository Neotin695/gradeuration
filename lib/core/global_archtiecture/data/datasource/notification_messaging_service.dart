import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../constance/logic_const.dart';
part 'notification_messaging_service.g.dart';

@RestApi(baseUrl: baseUrlSendNotification)
abstract class NotificationMessagingService {
  factory NotificationMessagingService(Dio dio) = _NotificationMessagingService;

  @POST('/fcm/send')
  Future<HttpResponse> sendNotification(
    @Header('Authorization') String authorization,
    @Body() Map<String, dynamic> notification,
  );
}
