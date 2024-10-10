import 'package:audio_youtube/app/core/utils/util.dart';
import 'package:audio_youtube/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import '../../data/service/audio/custom_audio.dart';

class SlashView extends StatefulWidget {
  const SlashView({super.key});
  static const String name = 'SlashView';

  @override
  State<SlashView> createState() => _SlashViewState();
}

class _SlashViewState extends State<SlashView> {
  @override
  void didChangeDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SingletonAudiohanle.instance.init();
    if (mounted) {
      Util.navigateNamed(context, HomeView.name);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Đang khỏi động hệ thống"),
      ),
    );
  }
}
