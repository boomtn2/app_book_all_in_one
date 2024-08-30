import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../data/notification/firebase_api.dart';

class FirebaseBinding implements Bindings {
  @override
  void dependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseApi().initNotification();
  }
}
