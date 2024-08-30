import 'package:get/get.dart';

import 'firebase_binding.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    FirebaseBinding().dependencies();
  }
}
