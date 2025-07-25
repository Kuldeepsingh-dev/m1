import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Initialize Firebase
    await Firebase.initializeApp(
      // options:  const FirebaseOptions(
      //   apiKey: '',
      //   appId: '',
      //   messagingSenderId: '',
      //   projectId: '',
      //   storageBucket: '',
      // )
    );

    // Request permission for iOS
    await _messaging.requestPermission();

    // Get FCM token
    final token = await _messaging.getToken();
    debugPrint('FCM Token: $token');

    // Setup local notifications
    const androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInitSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iOSInitSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Optional: Handle background messages separately
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void _handleForegroundNotification(RemoteMessage message) {
    debugPrint('Foreground message received: ${message.notification?.title}');

    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      const androidDetails = AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );
      const platformDetails = NotificationDetails(android: androidDetails);
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
      );
    }
  }

  static void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('App opened from notification: ${message.data}');
    // Navigate or handle custom logic here
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(); // Required if background isolate
    debugPrint('Background message: ${message.messageId}');
    // You can do background processing here
  }
}
