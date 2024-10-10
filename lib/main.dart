import 'package:audio_youtube/app/my_app.dart';
import 'package:flutter/material.dart';

import 'app/data/service/audio/custom_audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SingletonAudiohanle.instance.init();
  runApp(const MyApp());
}
