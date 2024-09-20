import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    //device token android
    final fcmToken = await _firebaseMessaging.getToken();

    debugPrint('Device token: $fcmToken');
  }

  void handleNotification() {}

  //
}
