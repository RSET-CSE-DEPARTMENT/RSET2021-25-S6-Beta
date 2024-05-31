
import 'package:firebase_messaging/firebase_messaging.dart';

class MyFirebaseMessaging {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  

  static Future<void> initialize() async {
    // Configure Firebase Messaging settings
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }

  static Future<String?> getToken() async {
    return await messaging.getToken();
  }
}
