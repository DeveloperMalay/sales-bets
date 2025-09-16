import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/bet/bet_model.dart';

// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
}

class PushNotificationService {
  static final PushNotificationService _instance = PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Initialize push notifications
  Future<void> initialize() async {
    try {
      // Request permission for iOS
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('User granted permission: ${settings.authorizationStatus}');

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle notification taps
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

      // Get FCM token
      String? token = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $token');

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((token) {
        debugPrint('FCM Token refreshed: $token');
        // TODO: Send updated token to your server
      });

    } catch (e) {
      debugPrint('Error initializing push notifications: $e');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message received: ${message.notification?.title}');
    _showLocalNotification(message);
  }

  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.data}');
    // TODO: Navigate to specific screen based on notification data
  }

  void _onNotificationTap(NotificationResponse notificationResponse) {
    debugPrint('Local notification tapped: ${notificationResponse.payload}');
    // TODO: Handle local notification tap
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'sales_bets_channel',
      'Sales Bets Notifications',
      channelDescription: 'Notifications for Sales Bets app',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      message.notification?.title ?? 'Sales Bets',
      message.notification?.body ?? 'You have a new notification',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  // Send bet result notification
  Future<void> sendBetResultNotification({
    required String userId,
    required BetModel bet,
    required String eventTitle,
    required String teamName,
    required bool isWin,
  }) async {
    try {
      String title;
      String body;
      
      if (isWin) {
        final netWinnings = bet.creditsWon - bet.creditsStaked;
        title = '🎉 Congratulations! You Won!';
        body = 'Your bet on $teamName paid off! You earned $netWinnings credits profit in "$eventTitle"';
      } else {
        title = '😔 Better Luck Next Time';
        body = 'Your bet on $teamName in "$eventTitle" didn\'t win this time. Don\'t worry, your credits are safe!';
      }

      // For now, show local notification immediately
      // In a real app, you'd send this via your backend to FCM
      await _showImmediateNotification(
        title: title,
        body: body,
        data: {
          'type': 'bet_result',
          'betId': bet.id,
          'eventId': bet.eventId,
          'isWin': isWin.toString(),
        },
      );

    } catch (e) {
      debugPrint('Error sending bet result notification: $e');
    }
  }

  // Send achievement notification
  Future<void> sendAchievementNotification({
    required String userId,
    required String achievementTitle,
    required String achievementDescription,
    required int rewardCredits,
  }) async {
    try {
      await _showImmediateNotification(
        title: '🏆 Achievement Unlocked!',
        body: '$achievementTitle - $achievementDescription (+$rewardCredits credits)',
        data: {
          'type': 'achievement',
          'title': achievementTitle,
          'credits': rewardCredits.toString(),
        },
      );
    } catch (e) {
      debugPrint('Error sending achievement notification: $e');
    }
  }

  // Show immediate local notification (for testing/simulation)
  Future<void> _showImmediateNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'sales_bets_results',
      'Bet Results',
      channelDescription: 'Notifications for bet results and achievements',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      styleInformation: BigTextStyleInformation(''),
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      platformChannelSpecifics,
      payload: data?.toString(),
    );
  }

  // Get FCM token for this device
  Future<String?> getToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  // Subscribe to topic (for broadcast notifications)
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }
}