import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Request Permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permissions');

      // Initialize local notifications
      const AndroidInitializationSettings androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher');
     
      final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitialize,
       
      );
      
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showLocalNotification(message);
      });

      // Background message tap handling
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationTap(message);
      });

      // Get token
      String? token = await _firebaseMessaging.getToken();
      print("Firebase Token: $token");
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Handle notification tap - navigate to specific screen
    print("Notification tapped: ${message.data}");
    // Example: Navigate to a specific page
    // Get.to(() => NotificationDetailPage(data: message.data));
  }

  // Method to get FCM Token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}