import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;



  static Future<String?> getToken() async {
    try {
      NotificationSettings settings =
      await _firebaseMessaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      } else {}
      final String? token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      return null;
    }
  }

}