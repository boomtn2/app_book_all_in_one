import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_handle.dart';
import 'logger_handler.dart';
import 'tts_handle.dart';

enum KeyChangeAudio { mp3, text }

class SingletonAudiohanle with WidgetsBindingObserver {
  AudioHandler? audioHandler;
  static SingletonAudiohanle? _instance;

  static SingletonAudiohanle get instance =>
      _instance ??= SingletonAudiohanle._internal();

  SingletonAudiohanle._internal() {
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  final handle = LoggingAudioHandler(MainSwitchHandler([
    CAudioHandle(),
    CTextPlayerHandler(),
  ]));

  AudioProcessingState? handleState;
  Future init() async {
    try {
      audioHandler = await AudioService.init(
          builder: () => handle,
          config: const AudioServiceConfig(
            androidNotificationChannelId: 'hit.coder.ttsaudioquanhonngontinh',
            androidNotificationChannelName: 'Audio',
            androidNotificationOngoing: true,
            // androidStopForegroundOnPause: false,
          ));
    } catch (e) {
      audioHandler = handle;
    }
  }

  Future<void> changeChannelAudio(KeyChangeAudio name) async {
    await audioHandler?.stop();
    switch (name) {
      case KeyChangeAudio.mp3:
        await audioHandler?.switchToHandler(0);
        break;
      case KeyChangeAudio.text:
        await audioHandler?.switchToHandler(1);
        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        audioHandler?.stop();
        break;
      case AppLifecycleState.paused:
        // Ứng dụng chuyển sang background
        break;
      case AppLifecycleState.resumed:
        break;
      // Ứng dụng quay trở lại foreground
      default:
        break;
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

  @override
  String toString() {
    return "handlerIndex $handlerIndex";
  }
}

extension DemoAudioHandler on AudioHandler {
  Future<void> switchToHandler(int? index) async {
    if (index == null) return;
    if (SingletonAudiohanle.instance.audioHandler != null) {
      await SingletonAudiohanle.instance.audioHandler!
          .customAction('switchToHandler', <String, dynamic>{'index': index});
    }
  }
}
