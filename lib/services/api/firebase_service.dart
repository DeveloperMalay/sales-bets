import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;
  static FirebaseMessaging get messaging => FirebaseMessaging.instance;
  
  // Collection references
  static CollectionReference get usersCollection => 
      firestore.collection('users');
  static CollectionReference get teamsCollection => 
      firestore.collection('teams');
  static CollectionReference get eventsCollection => 
      firestore.collection('events');
  static CollectionReference get betsCollection => 
      firestore.collection('bets');
  static CollectionReference get streamsCollection => 
      firestore.collection('streams');

  static Future<void> initialize() async {
    await Firebase.initializeApp();
    
    // Request notification permissions
    await requestNotificationPermissions();
  }

  static Future<void> requestNotificationPermissions() async {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<String?> getFCMToken() async {
    try {
      return await messaging.getToken();
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }
}