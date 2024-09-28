import 'package:audio_youtube/app/bindings/remote_source_bindings.dart';
import 'package:audio_youtube/app/bindings/repository_bindings.dart';
import 'package:get/get.dart';

import 'firebase_binding.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() async {
    FirebaseBinding().dependencies();
    RemoteSourceBindings().dependencies();
    RepositoryBindings().dependencies();
  }
}
