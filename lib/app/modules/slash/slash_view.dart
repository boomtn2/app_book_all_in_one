import 'package:audio_youtube/app/core/utils/util.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/repository/database_repository.dart';
import 'package:audio_youtube/app/modules/home/views/home_view.dart';
import 'package:audio_youtube/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import '../../data/repository/gist_repository.dart';
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
  final GistRepository _gistRepository =
      Get.find(tag: (GistRepository).toString());

  final DatabaseRepository database =
      Get.find(tag: (DatabaseRepository).toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SingletonAudiohanle.instance.init();
    await DatabaseHelper().initDb();
    await _initConfigWebsite();
    await _initCategory();
    await _initSearch();
    toHome();
  }

  Future _initCategory() async {
    try {
      await _gistRepository.downloadCategory();
    } catch (e) {
      debugPrint("Tải dữ liệu thể loại thất bại!");
    }
  }

  Future _initSearch() async {
    try {
      await _gistRepository.downloadConfigSearch();
    } catch (e) {
      debugPrint("Tải dữ liệu tìm kiếm thất bại!");
    }
  }

  Future _initConfigWebsite() async {
    try {
      await _gistRepository.downloadConfigWebsite();
    } catch (e) {
      debugPrint("[ERROR] [_initConfigWebsite] $e");
    }
  }

  void onInit(Artboard artboard) async {
    //Bên cột animation
    _controller =
        StateMachineController.fromArtboard(artboard, 'State Machine');
    if (_controller != null) {
      artboard.addController(_controller!);
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

  // RiveFile? _riveAudioAssetFile;
  // Future<void> _loadRiveFile() async {
  //   // final riveFile = await RiveFile.asset(
  //   //   Assets.rives.bgrCatbot.path,
  //   // );

  //   // setState(() {
  //   //   _riveAudioAssetFile = riveFile;
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: RiveAnimation.asset(
              Assets.rives.bgrCatbot.path,
              onInit: onInit,
            ),
          ),

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
