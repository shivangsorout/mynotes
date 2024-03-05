import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as devtools show log;

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  devtools.log(message.data.toString());
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
