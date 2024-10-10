import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    //device token android
    final fcmToken = await _firebaseMessaging.getToken();

    debugPrint('Device token: $fcmToken');

    _firebaseMessaging.getInitialMessage().then(
      (value) {
        debugPrint("${value?.data}");
      },
    );

    FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    // debug("Handling a background message: ${message.messageId}");
    // print("Handling a background message: ${message.data}");
  }

  //
}
