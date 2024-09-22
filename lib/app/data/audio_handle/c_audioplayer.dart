// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class CAudioPlayerHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  // ignore: close_sinks

  final _player = AudioPlayer();

  CAudioPlayerHandler() {
    _init();
  }

  Future<void> _init() async {
    // Load and broadcast the queue

    // For Android 11, record the most recent item so it can be resumed.
    // _player.currentIndexStream.listen((index) {
    //   if (index != null) mediaItem.add(queue.value[index]);
    // });
    // Propagate all events from the audio player to AudioService clients.
    _player.playbackEventStream.listen(_broadcastState);
    // In this example, the service stops when reaching the end.
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) _complate();
    });
  }

  PublishSubject streamCustomEvent = PublishSubject();
  @override
  PublishSubject get customEvent => streamCustomEvent;
  void _complate() async {}

  MediaItem? _mediaItem;
  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    await _player.stop();
    _mediaItem = mediaItem;

    setTitle(mediaItem.id, mediaItem.title);
    return super.addQueueItem(mediaItem);
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    return super.customAction(name, extras);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    await _player.stop();
    _mediaItem = mediaItems.first;

    setTitle(_mediaItem!.id, _mediaItem!.title);
    return super.addQueueItems(mediaItems);
  }

  void setTitle(String id, String title) {
    mediaItem.add(MediaItem(id: id, title: title));
  }

  @override
  Future<void> skipToNext() async {
    _player.stop();
    _complate();
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(AdapterSpeed(speedT: speed).speed);
    return super.setSpeed(speed);
  }

  @override
  Future<void> play() async {
    if (_mediaItem != null) {
      if (_player.processingState != ProcessingState.ready) {
        try {
          await _player.setUrl(_mediaItem!.id);
        } catch (e) {
          skipToNext();
        }
      }

      _player.play();
    }
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    playbackState.add(await playbackState.firstWhere(
        (state) => state.processingState == AudioProcessingState.idle));
  }

  /// Broadcasts the current state to all clients.
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

class AdapterSpeed {
  double apdapterTTS = 0.5;
  double speedT;
  AdapterSpeed({
    required this.speedT,
  });
  double get speed => speedT + apdapterTTS;
}
