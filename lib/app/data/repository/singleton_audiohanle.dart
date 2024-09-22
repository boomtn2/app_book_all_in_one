import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

import '../audio_handle/c_audioplayer.dart';
import '../audio_handle/c_tts.dart';
import '../audio_handle/logger_handler.dart';

class SingletonAudiohanle {
  late AudioHandler controllerHandlerTTS;
  static final SingletonAudiohanle _singleton = SingletonAudiohanle._internal();
  static List<Map<dynamic, dynamic>> voices = [];
  static Map<dynamic, dynamic> voice = {};
  static int maxInput = 1000;

  static double speed = 0.5;

  factory SingletonAudiohanle() {
    return _singleton;
  }

  SingletonAudiohanle._internal() {
    _init();
  }
  AudioProcessingState? handleState;
  Future _init() async {
    try {
      controllerHandlerTTS = LoggingAudioHandler(MainSwitchHandler([
        CTextPlayerHandler(),
        CAudioPlayerHandler(),
      ]));
    } catch (e) {
      controllerHandlerTTS = LoggingAudioHandler(MainSwitchHandler([
        CTextPlayerHandler(),
        CAudioPlayerHandler(),
      ]));
    }

    controllerHandlerTTS.playbackState.listen((value) {
      if (value.playing) {
        voidCallUIPause();
        if (value.processingState == AudioProcessingState.completed) {
          //   voidCallbackAuto();
        }
      } else {
        switch (value.processingState) {
          case AudioProcessingState.idle:
            voidCallUIPlay();
            break;
          case AudioProcessingState.loading:
            voidCallUILoading();
            break;
          case AudioProcessingState.buffering:
            break;
          case AudioProcessingState.ready:
            voidCallUIPlay();
            break;
          case AudioProcessingState.completed:
            //  voidCallbackAuto();
            break;
          case AudioProcessingState.error:
            voidCallUIPlay();
            break;
        }
      }
    });
    controllerHandlerTTS.customEvent.listen((event) {
      try {
        if (event is GetVoices) {
          voices = event.listVoices;
          voice = voices.first;
        }
        if (event is GetMaxInput) {
          maxInput = event.maxInput;
        }
      } finally {}
    });

    getVoices();
    getMaxInput();
  }

  Function() voidCallbackAuto = () {};
  Function() voidCallUIPlay = () {};
  Function() voidCallUIPause = () {};
  Function() voidCallUILoading = () {};

  void getVoices() async {
    await controllerHandlerTTS.customAction('getVoice');
  }

  void setVoice(Map<String, dynamic> voiceData) async {
    voice = voiceData;

    await controllerHandlerTTS.customAction('setVoice', voiceData);
  }

  void getMaxInput() async {
    await controllerHandlerTTS.customAction('getMaxInput');
  }

  void setSpeed(double sp) {
    speed = sp;
    controllerHandlerTTS.setSpeed(speed);
  }
}

class MainSwitchHandler extends SwitchAudioHandler {
  final List<AudioHandler> handlers;
  @override
  BehaviorSubject<dynamic> customState =
      BehaviorSubject<dynamic>.seeded(CustomEvent(0));

  MainSwitchHandler(this.handlers) : super(handlers.first) {
    // Configure the app's audio category and attributes for speech.
    AudioSession.instance.then((session) {
      session.configure(const AudioSessionConfiguration.speech());
    });
  }

  @override
  Future<dynamic> customAction(String name,
      [Map<String, dynamic>? extras]) async {
    switch (name) {
      case 'switchToHandler':
        stop();
        final index = extras!['index'] as int;
        inner = handlers[index];
        customState.add(CustomEvent(index));
        return null;
      default:
        return super.customAction(name, extras);
    }
  }
}

class CustomEvent {
  final int handlerIndex;

  CustomEvent(this.handlerIndex);
}

extension DemoAudioHandler on AudioHandler {
  Future<void> switchToHandler(int? index) async {
    if (index == null) return;
    await SingletonAudiohanle()
        .controllerHandlerTTS
        .customAction('switchToHandler', <String, dynamic>{'index': index});
  }
}
