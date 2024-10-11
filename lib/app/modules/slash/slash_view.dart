import 'package:audio_youtube/app/core/utils/util.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/modules/home/views/home_view.dart';
import 'package:audio_youtube/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../data/service/audio/custom_audio.dart';
import '../../data/service/sqlite/sqlite_helper.dart';

class SlashView extends StatefulWidget {
  const SlashView({super.key});
  static const String name = 'SlashView';

  @override
  State<SlashView> createState() => _SlashViewState();
}

class _SlashViewState extends State<SlashView> {
  StateMachineController? _controller;
  SMIBool? noInternet;
  SMIBool? chat;
  SMIBool? error;

  SMINumber? progress;
  SMITrigger? reset;

  @override
  void initState() {
    _loadRiveFile();
    init();
    super.initState();
  }

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SingletonAudiohanle.instance.init();
    await DatabaseHelper().initDb();
    await Future.delayed(const Duration(seconds: 5));
    toHome();
  }

  void onInit(Artboard artboard) async {
    //Bên cột animation
    _controller =
        StateMachineController.fromArtboard(artboard, 'State Machine');
    if (_controller != null) {
      artboard.addController(_controller!);

      //listeners
      // _controller.addEventListener(onRiveEvent);

      //là cái trigger input
      //Thay đổi giá trị đầu vào noInternet.value = true
      noInternet = _controller?.findSMI("No Internet");
      chat = _controller?.findSMI("Chat");
      error = _controller?.findSMI("Error");
      reset = _controller?.findSMI("Reset");

      progress = _controller?.findSMI("Download");
    }
  }

  void toHome() {
    Util.navigateNamed(context, HomeView.name);
  }

  void onRiveEvent(RiveEvent event) {
    // var rating = event.properties['rating'] as double;
  }

  @override
  void dispose() {
    _controller?.removeEventListener(onRiveEvent);
    _controller?.dispose();
    super.dispose();
  }

  RiveFile? _riveAudioAssetFile;
  Future<void> _loadRiveFile() async {
    final riveFile = await RiveFile.asset(
      Assets.rives.bgrCatbot.path,
    );

    setState(() {
      _riveAudioAssetFile = riveFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _riveAudioAssetFile != null
              ? Expanded(
                  child: RiveAnimation.direct(
                    _riveAudioAssetFile!,
                    onInit: onInit,
                  ),
                )
              : const SizedBox.shrink(),
          Text(
            "Đang tải tài nguyên...",
            style: afaca.copyWith(fontWeight: FontWeight.bold),
          )
          // ElevatedButton(
          //     onPressed: () {
          //       final value = noInternet?.value ?? false;
          //       noInternet?.value = !value;
          //     },
          //     child: Text("No Internet")),
          // ElevatedButton(
          //     onPressed: () {
          //       final value = error?.value ?? false;
          //       error?.value = value;
          //     },
          //     child: Text("Eror")),
          // ElevatedButton(
          //     onPressed: () {
          //       final value = chat?.value ?? false;
          //       chat?.value = value;
          //     },
          //     child: Text("Chat")),
          // ElevatedButton(
          //     onPressed: () {
          //       reset?.fire();
          //     },
          //     child: Text("Reset")),
          // Progress(
          //   voicallBack: (p0) {
          //     progress?.value = p0;
          //   },
          // )
        ],
      ),
    );
  }
}

class Progress extends StatefulWidget {
  const Progress({super.key, required this.voicallBack});
  final Function(double) voicallBack;
  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 100,
      value: progress,
      onChanged: (value) {
        widget.voicallBack(value);
        setState(() {
          progress = value;
        });
      },
    );
  }
}
