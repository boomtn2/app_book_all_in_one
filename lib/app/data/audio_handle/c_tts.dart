// ignore_for_file: public_member_api_docs, sort_constructors_first, implementation_imports
import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/src/subjects/publish_subject.dart';

class CTextPlayerHandler extends BaseAudioHandler with QueueHandler {
  final _tts = Tts();
  final _sleeper = Sleeper();
  Completer<void>? _completer;
  var _index = 0;
  bool _interrupted = false;
  var _running = false;
  GetVoices? getVoices;
  GetMaxInput? getMaxInput;

  bool get _playing => playbackState.value.playing;

  CTextPlayerHandler() {
    _init();
  }

  Future<void> _init() async {
    try {
      getVoices = GetVoices(listVoices: await _tts._getVoicesVI_EN());
      await _tts.setVoice(voice: getVoices!.listVoices.first);

      getMaxInput = GetMaxInput(maxInput: await _tts.getMax() ?? 1000);
    } finally {}

    final session = await AudioSession.instance;
    // Handle audio interruptions.
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        if (_playing) {
          pause();
          _interrupted = true;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.pause:
          case AudioInterruptionType.duck:
            if (!_playing && _interrupted) {
              play();
            }
            break;
          case AudioInterruptionType.unknown:
            break;
        }
        _interrupted = false;
      }
    });
    // Handle unplugged headphones.
    session.becomingNoisyEventStream.listen((_) {
      if (_playing) pause();
    });
  }

  Future<void> run() async {
    _running = true;
    while (_running) {
      try {
        if (_playing) {
          mediaItem.add(queue.value[_index]);
          AudioService.androidForceEnableMediaButtons();
          await _tts.speak('${mediaItem.value!.extras!["number"]}');
          if (_index + 1 < queue.value.length) {
            _index++;
          } else {
            _running = false;
          }
        } else {
          await _sleeper.sleep();
        }
      } on SleeperInterruptedException {
      } on TtsInterruptedException {}
    }

    if (isPause) {
      (_index + 1) < queue.value.length ? ++_index : _index;
    } else {
      _index = 0;
    }

    mediaItem.add(queue.value[_index]);
    playbackState.add(playbackState.value.copyWith(
      updatePosition: Duration.zero,
    ));
    if (playbackState.value.processingState != AudioProcessingState.idle) {
      debugPrint(
          'if playbackState.value.processingState != AudioProcessingState.idle');
      _complate();
    }
    try {
      _completer?.complete();
    } finally {}

    _completer = null;
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    switch (name) {
      case 'setVoice':
        if (extras != null) {
          pause();
          await _tts.setVoice(voice: extras);
        }

        break;
      case 'getVoice':
        streamCustomEvent.add(
            getVoices ?? GetVoices(listVoices: await _tts._getVoicesVI_EN()));
        break;
      case 'getMaxInput':
        streamCustomEvent.add(
            getMaxInput ?? GetMaxInput(maxInput: await _tts.getMax() ?? 1000));
      default:
        break;
    }
    return super.customAction(name, extras);
  }

  @override
  Future<void> setSpeed(double speed) async {
    pause();
    await _tts.setSpeech(speed);
    return super.setSpeed(speed);
  }

  PublishSubject streamCustomEvent = PublishSubject();
  @override
  PublishSubject get customEvent => streamCustomEvent;

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) {
    queue.value = [];
    isPause = false;
    try {
      mediaItem.add(
          MediaItem(id: mediaItems.first.title, title: mediaItems.first.title));
    } catch (e) {
      debugPrint('[TTS] Lỗi AUDIOHANDLE addQueueItems $e');
    }

    return super.addQueueItems(mediaItems);
  }

  @override
  Future<void> play() async {
    if (_playing) return;

    final session = await AudioSession.instance;
    // flutter_tts doesn't activate the session, so we do it here. This
    // allows the app to stop other apps from playing audio while we are
    // playing audio.
    if (await session.setActive(true)) {
      // If we successfully activated the session, set the state to playing
      // and resume playback.
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.pause,
          MediaControl.stop,
          MediaControl.skipToNext
        ],
        processingState: AudioProcessingState.ready,
        playing: true,
      ));
      if (isPause) {
        isPause = false;
        await _tts.resume();
      }

      if (_completer == null) {
        run();
      } else {
        _sleeper.interrupt();
      }
    }
  }

  @override
  Future<void> skipToNext() async {
    debugPrint('[TTS] skipToNext');
    _running = false;
    _tts.stop();
  }

  bool isPause = false;
  @override
  Future<void> pause() async {
    _interrupted = false;
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play, MediaControl.stop],
      processingState: AudioProcessingState.ready,
      playing: false,
    ));
    // _signal();
    isPause = true;
    _tts.pause();
  }

  void _complate() async {}

  @override
  Future<void> stop() async {
    _tts.stop();
    playbackState.add(playbackState.value.copyWith(
      controls: [],
      processingState: AudioProcessingState.idle,
      playing: false,
    ));

    _running = false;

    //_signal();
    isPause = false;
    // Wait for the speech to stop
    // await _completer?.future;
    // Shut down this task
  }
}

/// An object that performs interruptable sleep.
class Sleeper {
  Completer<void>? _blockingCompleter;

  /// Sleep for a duration. If sleep is interrupted, a
  /// [SleeperInterruptedException] will be thrown.
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
}

class SleeperInterruptedException {}

/// A wrapper around FlutterTts that makes it easier to wait for speech to
/// complete.
class Tts {
  final FlutterTts _flutterTts = FlutterTts();
  Completer<void>? _speechCompleter;
  bool _interruptRequested = false;
  bool _playing = false;
  String stPause = '';
  Tts() {
    _flutterTts.awaitSpeakCompletion(true);
    _flutterTts.setProgressHandler((text, start, end, word) {
      stPause = text.substring(end, text.length);
    });
    _flutterTts.setCompletionHandler(() {
      try {
        _speechCompleter?.complete();
      } finally {}
    });
  }

  void pause() {
    _flutterTts.pause();
  }

  Future<int?> getMax() async {
    return _flutterTts.getMaxSpeechInputLength;
  }

  Future<int?> setVoice({required Map<dynamic, dynamic> voice}) async {
    // 1 true 0 flase
    var flag = await _flutterTts
        .setVoice({"name": voice["name"], "locale": voice["locale"]});

    return flag;
  }

  Future<int?> setSpeech(double speech) async {
    final repo = await _flutterTts.setSpeechRate(speech);

    return repo;
  }

  // ignore: non_constant_identifier_names
  Future<List<Map<dynamic, dynamic>>> _getVoicesVI_EN() async {
    String locale = 'vi';
    try {
      List<dynamic> data = await _flutterTts.getVoices;
      // Assuming getVoices returns a Future<List<Map>>
      List<Map<dynamic, dynamic>> listItem = List.from(data);
      List<Map<dynamic, dynamic>> listVI =
          listItem.where((voice) => voice["locale"].contains(locale)).toList();
      if (listVI.isEmpty) {
        return listItem;
      } else {
        return listVI;
      }
    } catch (e) {
      return []; // or handle the error as needed
    }
  }

  bool get playing => _playing;

  Future<void> speak(String text) async {
    _playing = true;
    if (!_interruptRequested) {
      _speechCompleter = Completer();
      try {
        await _flutterTts.speak(text);
      } finally {
        if (_speechCompleter != null) {
          await _speechCompleter!.future;
          _speechCompleter = null;
        }
      }
    }
    _playing = false;
    if (_interruptRequested) {
      _interruptRequested = false;
      throw TtsInterruptedException();
    }
  }

  Future<void> stop() async {
    if (_playing) {
      await _flutterTts.stop();
      try {
        _speechCompleter?.complete();
      } finally {}
    }
  }

  void interrupt() {
    if (_playing) {
      _interruptRequested = true;
      stop();
    }
  }

  Future resume() async {
    await _flutterTts.speak(stPause);
  }
}

class TtsInterruptedException {}

class GetVoices {
  List<Map<dynamic, dynamic>> listVoices;
  GetVoices({
    required this.listVoices,
  });
}

class GetMaxInput {
  int maxInput;
  GetMaxInput({
    required this.maxInput,
  });
}
