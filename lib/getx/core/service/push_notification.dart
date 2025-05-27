import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:valet_parking_app/app/view/notification/notification_view.dart';
import 'package:valet_parking_app/shared/utils/screen_util.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Channel IDs
  static const String _highImportanceChannelId = 'high_importance_channel';

  Future<void> init() async {
    // Request Permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permissions');

      // Initialize local notifications
      const AndroidInitializationSettings androidInitialize =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: androidInitialize,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          // Handle notification response when app is in foreground
          if (response.payload != null) {
            final payloadData = _parsePayload(response.payload!);
            _processNotificationData(payloadData);
          }
        },
      );

      // Create notification channels (required for Android 8.0+)
      await _createNotificationChannel();

      // Set up handlers for different notification scenarios
      _setupNotificationHandlers();

      // Get token
      String? token = await _firebaseMessaging.getToken();
      print("Firebase Token: $token");
    }
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _highImportanceChannelId,
      'High Importance Notifications',
      importance: Importance.high,
      playSound: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void _setupNotificationHandlers() {
    // 1. Handler for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received');

      // Always show the NotificationView for foreground messages
      if (message.notification != null) {
        _showNotificationAndNavigate(message);
      }
    });

    // 2. Handler for when app is opened from a background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A background message was tapped: ${message.data}');
      _handleNotificationTap(message);
    });

    // 3. Handler for when app is completely closed (terminated state)
    // This requires the background handler to be registered in main.dart
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('App started by tapping notification: ${message.data}');
        _handleNotificationTap(message);
      }
    });
  }

  Future<void> _showNotificationAndNavigate(RemoteMessage message) async {
    // 1. Show a normal notification
    await _showRegularNotification(message);

    // 2. Immediately navigate to your NotificationView
    _navigateToNotificationView(message.data);
  }

  void _navigateToNotificationView(Map<String, dynamic> data) {
    // Use GetX to navigate to your NotificationView
    // Prevent duplicate screens if already showing
    Screen.open(NotificationView(data: data,));
  }

  Future<void> _showRegularNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      _highImportanceChannelId,
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
      payload: _createPayload(message.data),
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    print("Notification tapped: ${message.data}");



   
      _navigateToFullScreenNotification(message.data);
  
  }

  void _navigateToFullScreenNotification(Map<String, dynamic> data) {
    // Navigate to full screen notification page with the data
    Screen.open(NotificationView(data: data,));
  }

  String _createPayload(Map<String, dynamic> data) {
    // Convert the data map to a string format that can be passed as payload
    return data.toString();
  }

  Map<String, dynamic> _parsePayload(String payload) {
    // Convert the string payload back to a map
    Map<String, dynamic> result = {};

    // Simple string-to-map parsing (you could use json.encode/decode for more complex data)
    String trimmed = payload.replaceAll('{', '').replaceAll('}', '');
    List<String> pairs = trimmed.split(', ');

    for (String pair in pairs) {
      if (pair.isEmpty) continue;

      List<String> keyValue = pair.split(': ');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        result[key] = value;
      }
    }

    return result;
  }

  void _processNotificationData(Map<String, dynamic> data) {
    // Process the notification data and take appropriate action
    final bool isFullScreen = data['full_screen'] == 'true';

    if (isFullScreen) {
      _navigateToFullScreenNotification(data);
    } else {
      // Handle regular notification data
    }
  }

  // Method to get FCM Token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}

// Define this in main.dart
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This will be called when a message is received in the background
  print("Handling a background message: ${message.messageId}");
  // We don't need to show notifications here as the system will do it automatically
}
