import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:audio_youtube/app/data/model/error_auth.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'model/position_data.dart';

class CAudioHandle extends BaseAudioHandler with QueueHandler {
  final _player = AudioPlayer();
  final PublishSubject<dynamic> _positionDataSubject =
      PublishSubject<dynamic>();
  ConcatenatingAudioSource? playlist;
  StreamSubscription<PositionData>? _positionDataSubscription;
  bool isPause = false;
  AudioSession? session;

  CAudioHandle() {
    init();
  }

  void init() {
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) stop();
    });

    _player.playbackEventStream.listen(_broadcastState,
        onError: (Object e, StackTrace st) {
      if (e is PlatformException) {
        _pushEror(
            'Lỗi ${e.details?["index"]} \n ${e.message} \n(Vui lòng chuyển tập)',
            e.code);
      } else {
        _pushEror('Lỗi không xác định \n $e (Báo với Admin!)', '[Unkown]');
      }
    });
    _player.currentIndexStream.listen(
      (event) {
        if (event != null) {
          mediaItem.add(queue.value[event]);
        }
      },
    );

    _initSession();
  }

  void _initSession() async {
    AudioSession.instance.then((s) {
      session = s;
      session?.configure(const AudioSessionConfiguration.music());

      bool wasPausedByBeginEvent = false;

      s.interruptionEventStream.listen((event) async {
        if (event.begin) {
          switch (event.type) {
            case AudioInterruptionType.duck:
              await _player.setVolume(0.5);
              break;
            case AudioInterruptionType.pause:
            case AudioInterruptionType.unknown:
              {
                wasPausedByBeginEvent = _player.playing;
                _player.pause();
                break;
              }
          }
        } else {
          switch (event.type) {
            case AudioInterruptionType.duck:
              await _player.setVolume(1.0);
              break;
            case AudioInterruptionType.pause when wasPausedByBeginEvent:
            case AudioInterruptionType.unknown when wasPausedByBeginEvent:
              await _player.play();
              wasPausedByBeginEvent = false;
              break;
            default:
              break;
          }
        }
      });

      s.becomingNoisyEventStream.listen((_) {
        _player.pause();
      });
    });
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) {
    playlist?.add(
      _adapterMedia(mediaItem),
    );
    return super.addQueueItem(mediaItem);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) {
    playlist?.addAll(
      List<AudioSource>.from(mediaItems
          .map(
            (e) => _adapterMedia(e),
          )
          .toList()),
    );

    return super.addQueueItems(mediaItems);
  }

  AudioSource _adapterMedia(MediaItem mediaItem) {
    return AudioSource.uri(Uri.parse(mediaItem.id));
  }

  void _listen() {
    _positionDataSubscription = _positionDataStream.listen(
      (positionData) {
        _positionDataSubject.add(positionData);
      },
    );
  }

  @override
  Future<void> play() async {
    session?.setActive(true);
    if (playlist != null) {
      try {
        if (!isPause) {
          // After a cold restart (on Android), _player.load jumps straight from
          // the loading state to the completed state. Inserting a delay makes it
          // work. Not sure why!
          //await Future.delayed(Duration(seconds: 2)); // magic delay
          await _player.setAudioSource(playlist!,
              initialIndex: 0, initialPosition: Duration.zero);
        }

        if (_positionDataSubscription == null) {
          _listen();
        }
        await _player.play();
      } on PlayerException catch (e) {
        _pushEror(
            'Đường dẫn âm thanh bị lỗi \n ${e.message} \n (Vui lòng chuyển sang tập khác!)',
            ' [PlayerException] ${e.code}');
      } on PlayerInterruptedException catch (e) {
        _pushEror(
            'Lỗi thực hiện quá nhiều thao tác đồng thời \n ${e.message} \n (Thoát ứng dụng vào lại!)',
            '  [PlayerInterruptedException]');
      } catch (e) {
        _pushEror('Lỗi không xác định \n $e \n (Vui lòng báo lỗi với Admin!)',
            ' [Unkown]  ');
      }
    } else {
      _pushEror(
          "Danh sách phát bị trống \n (Vui lòng kiểm tra lại danh sách phát)",
          "PlayList == null");
    }
  }

  void _pushEror(String mess, String code) {
    _positionDataSubject
        .add(ErorrBase(message: mess, code: '[EROR] [AUDIO HANDLE] $code'));
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    isPause = true;
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future<void> skipToNext() async {
    _player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    _player.seekToPrevious();
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (playlist != null) {
      if (index < 0 || index >= (playlist!.children.length)) return;
      _player.seek(Duration.zero,
          index: _player.shuffleModeEnabled
              ? _player.shuffleIndices![index]
              : index);
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> onTaskRemoved() {
    stop();
    return super.onTaskRemoved();
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    await _player.stop();
    await playlist?.clear();
    playlist = ConcatenatingAudioSource(
      children: List<AudioSource>.from(newQueue
          .map(
            (e) => _adapterMedia(e),
          )
          .toList()),
    );
    return super.updateQueue(newQueue);
  }

  void dispose() async {
    await _positionDataSubscription?.cancel();
    _positionDataSubscription = null;
    await _player.stop();
    // await _player.dispose();
    await playlist?.clear();
    session?.setActive(false);
    isPause = false;
    playlist = null;
  }

  @override
  PublishSubject get customEvent => _positionDataSubject;

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) {
    switch (name) {
      case 'dispose':
        dispose();
        break;
    }
    return super.customAction(name, extras);
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;

    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }
}
