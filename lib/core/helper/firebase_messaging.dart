import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_data.dart';

void _handleMessage(RemoteMessage? message) {
  log('test');
  if (message == null) return;
}

@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseMessagingService {
  FirebaseMessagingService._privateConstructor();
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._privateConstructor();
  static FirebaseMessagingService get instance => _instance;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String?> get generateToken => _messaging.getToken();
  final _androidChannel = const AndroidNotificationChannel(
    'request_book',
    'notification blabla',
    importance: Importance.defaultImportance,
  );
  final _localNotification = FlutterLocalNotificationsPlugin();
  Future initializeFirebaseMessaging() async {
    await initializeNotification();
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await initializePushNotification();

    // _onToeknRegenerate();
  }

  Future initializePushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((message) => _handleMessage(message));
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _localNotification.show(
            message.hashCode,
            message.notification!.title,
            message.notification!.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChannel.id,
                _androidChannel.name,
                importance: _androidChannel.importance,
                icon: '@drawable/ic_launcher',
              ),
            ),
            payload: jsonEncode(message.toMap()));
      }
    });
  }

  Future initializeNotification() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: _androidChannel.id,
            channelKey: _androidChannel.id,
            channelName: _androidChannel.name,
            channelDescription: _androidChannel.description)
      ],
    );
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        _handleMessage(message);
      },
    );
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
    _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future onToeknRegenerate() async {
    _messaging.onTokenRefresh.listen((fcmToken) async {
      await _firestore
          .collection('usres')
          .doc(currentUser.id)
          .update({'token': fcmToken});
    }).onError((err) {
      log('firebase messaging error: $err');
    });
  }
}
