import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/rxdart.dart';

import '../../model/error_auth.dart';

class Const {
  static const String customActionSetVoice = 'voice';
  static const String customActionGetVoice = 'get-voice';
}

class CTextPlayerHandler extends BaseAudioHandler with QueueHandler {
  final Tts controllerTextToSpeech = Tts();
  AudioSession? session;
  int _index = 0;
  bool _running = false;
  final Sleeper _sleeper = Sleeper();
  final PublishSubject<dynamic> _dataSubject = PublishSubject<dynamic>();
  CTextPlayerHandler() {
    _initSession();
    _initTTS();
  }

  void _initTTS() {
    controllerTextToSpeech._flutterTts.setErrorHandler((msg) {
      _pushEror('$msg (Vui lòng đổi giọng đọc)', '');
    });
  }

  void _pushEror(String mess, String code) {
    _dataSubject
        .add(ErorrBase(message: mess, code: '[EROR] [TTS HANDLE] $code'));
  }

  List<Map<String, String>> voices = [];

  void _initSession() async {
    AudioSession.instance.then((s) {
      session = s;
      session?.configure(const AudioSessionConfiguration.music());

      bool wasPausedByBeginEvent = false;

      s.interruptionEventStream.listen((event) async {
        if (event.begin) {
          switch (event.type) {
            case AudioInterruptionType.duck:
              await controllerTextToSpeech.setVolume(0.5);
              break;
            case AudioInterruptionType.pause:
            case AudioInterruptionType.unknown:
              {
                wasPausedByBeginEvent = controllerTextToSpeech.playing;
                controllerTextToSpeech.pause();
                break;
              }
          }
        } else {
          switch (event.type) {
            case AudioInterruptionType.duck:
              await controllerTextToSpeech.setVolume(1.0);
              break;
            case AudioInterruptionType.pause when wasPausedByBeginEvent:
            case AudioInterruptionType.unknown when wasPausedByBeginEvent:
              await controllerTextToSpeech.resume();
              wasPausedByBeginEvent = false;
              break;
            default:
              break;
          }
        }
      });

      s.becomingNoisyEventStream.listen((_) {
        controllerTextToSpeech.pause();
      });
    });
  }

  @override
  PublishSubject get customEvent => _dataSubject;

  Future getVoice() async {
    //Save database
    //if(database == null)
    try {
      voices = await controllerTextToSpeech.getVoices();
    } catch (e) {
      _pushEror('Lỗi danh sách giọng đọc', '');
    }
  }

  Future<int?> setVoice(Map<String, String> voice) async {
    if (controllerTextToSpeech.playing) {
      pause();
    }
    return controllerTextToSpeech.setVoice(voice);
  }

  _uiNotifiStop() {
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.idle,
      playing: false,
    ));
  }

  _uiNotifiPause() {
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.ready,
      playing: false,
    ));
  }

  _uiNotifiPlay() {
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.pause, MediaControl.stop],
      processingState: AudioProcessingState.ready,
      playing: true,
    ));
  }

  void _run() async {
    if (queue.value.isEmpty) {
      stop();
      return;
    }

    _running = true;
    while (_running) {
      String st = '';
      try {
        st = queue.value[_index].extras!["number"];
        st = st.trim();
        mediaItem.add(queue.value[_index]);
      } catch (e) {
        _pushEror(
            'Lỗi danh sách phát \n (Vui lòng kiểm tra lại nội dung danh sách phát)',
            '');
      }

      if (controllerTextToSpeech.state == StateTTS.stop) {
        if (st.isNotEmpty) {
          AudioService.androidForceEnableMediaButtons();
          await controllerTextToSpeech.speak(st);
        }

        if ((_index + 1) < queue.value.length) {
          _index += 1;
        } else {
          stop();
        }
      } else {
        await _sleeper.sleep();
      }
    }
    _handleCompletion();
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) {
    mediaItem.add(mediaItems.first);
    reset();
    return super.addQueueItems(mediaItems);
  }

  void reset() {
    _index = 0;
    controllerTextToSpeech.initialize();
    queue.add([]);
  }

  void _handleCompletion() {
    _index = controllerTextToSpeech.state == StateTTS.pause ? _index + 1 : 0;
  }

  void handleException(Exception e, String context) {
    debugPrint('[DEBUG] [ERROR] [$context] $e');
  }

  @override
  Future<void> play() async {
    await session?.setActive(true);
    _uiNotifiPlay();
    switch (controllerTextToSpeech.state) {
      case StateTTS.stop:
        _run();
        break;
      case StateTTS.pause:
        controllerTextToSpeech.resume();
        break;
      default:
        await controllerTextToSpeech.stop();
        _run();
    }

    return super.play();
  }

  @override
  Future<void> pause() {
    if (controllerTextToSpeech.playing) {
      controllerTextToSpeech.pause();
    }
    _stopRun();
    _uiNotifiPause();
    return super.pause();
  }

  @override
  Future<void> stop() {
    dispose();
    _stopRun();
    _uiNotifiStop();
    return super.stop();
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    switch (name) {
      case Const.customActionSetVoice:
        if (extras is Map<String, String>) {
          return setVoice(extras);
        } else {
          return null;
        }

      case Const.customActionGetVoice:
        await getVoice();
        return voices;
    }
    return super.customAction(name, extras);
  }

  void _stopRun() {
    _running = false;
  }

  void dispose() {
    _sleeper.dispose();
    controllerTextToSpeech.dispose();
    session?.setActive(false);
  }
}

/// An object that performs interruptable sleep.
class Sleeper {
  Completer<void>? _blockingCompleter;

  /// Sleep for a duration. If sleep is interrupted, a [SleeperInterruptedException] will be thrown.
  Future<void> sleep([Duration? duration]) async {
    _blockingCompleter = Completer();
    if (duration != null) {
      await Future.any<void>(
          [Future.delayed(duration), _blockingCompleter!.future]);
    } else {
      await _blockingCompleter!.future;
    }
    final interrupted = _blockingCompleter!.isCompleted;
    _blockingCompleter = null;
    if (interrupted) {
      throw SleeperInterruptedException();
    }
  }

  /// Interrupt any sleep that's underway.
  void interrupt() {
    if (_blockingCompleter?.isCompleted == false) {
      _blockingCompleter!.complete();
    }
  }

  void dispose() {
    _blockingCompleter = null;
  }
}

class SleeperInterruptedException {}

enum StateTTS { playing, pause, stop }

/// A wrapper around FlutterTts that makes it easier to wait for speech to complete.
class Tts {
  final FlutterTts _flutterTts = FlutterTts();
  Completer<void>? _speechCompleter;
  bool _interruptRequested = false;
  StateTTS state = StateTTS.stop;
  String pausedText = '';

  Tts() {
    _flutterTts.awaitSpeakCompletion(true);
    initialize();
  }

  void initialize() {
    _flutterTts.setProgressHandler((text, start, end, word) {
      pausedText = text.substring(end);
    });
    _flutterTts.setCompletionHandler(() {
      _speechCompleter?.complete();
    });
    _flutterTts.setErrorHandler(
      (message) {
        debugPrint(message);
        dispose();
      },
    );
  }

  void dispose() {
    stop();
    _flutterTts.setCompletionHandler(() {});
    _flutterTts.setProgressHandler((text, start, end, word) {});
    _speechCompleter = null;
  }

  void pause() async {
    await _flutterTts.pause();
    _updateState(StateTTS.pause);
  }

  void _updateState(StateTTS newState) {
    state = newState;
  }

  Future<int?> getMaxInputLength() async {
    return _flutterTts.getMaxSpeechInputLength;
  }

  Future<int?> setVoice(Map<String, String> voice) async {
    try {
      final res = await _flutterTts.setVoice(
          {"name": voice["name"] ?? '', "locale": voice["locale"] ?? ''});

      return res;
    } catch (e) {
      return null;
    }
  }

  Future<int?> setSpeechRate(double rate) async {
    return await _flutterTts.setSpeechRate(rate);
  }

  Future<bool> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
    return true;
  }

  Future<List<Map<String, String>>> getVoices({String locale = 'vi'}) async {
    try {
      List<dynamic> voices = await _flutterTts.getVoices;
      List<Map<String, String>> filteredVoices = [];
      for (Map element in voices) {
        if (element["locale"].contains(locale) == true) {
          Map<String, String> temp = {};
          element.forEach(
            (key, value) {
              temp.addAll({'$key': '$value'});
            },
          );
          filteredVoices.add(temp);
        }
      }
      return filteredVoices.isNotEmpty
          ? filteredVoices
          : List<Map<String, String>>.from(voices);
    } catch (e) {
      throw (e.toString());
    }
  }

  bool get playing => state == StateTTS.playing;

  Future<void> speak(String text) async {
    debugPrint('Speak $text');
    _updateState(StateTTS.playing);
    if (_interruptRequested) {
      _updateState(StateTTS.stop);
      throw TtsInterruptedException();
    }
    _speechCompleter = Completer();
    await _flutterTts.speak(text);
    await _speechCompleter?.future;
    _speechCompleter = null;
    _updateState(StateTTS.stop);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    _updateState(StateTTS.stop);
    _speechCompleter?.complete();
    _speechCompleter = null;
  }

  void interrupt() {
    if (playing) {
      _interruptRequested = true;
      stop();
    }
  }

  Future<void> resume() async {
    _updateState(StateTTS.playing);
    await _flutterTts.speak(pausedText);
    _updateState(StateTTS.stop);
  }
}

class TtsInterruptedException {}

class GetVoices {
  final List<Map<String, String>> voices;
  GetVoices({required this.voices});
}

class GetMaxInput {
  final int maxInput;
  GetMaxInput({required this.maxInput});
}
