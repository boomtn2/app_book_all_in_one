import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/core/base/base_controller.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/model/error_auth.dart';
import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../data/service/audio/model/position_data.dart';

enum PlayState { Playing, Pause, Stop, Loading }

class AudioController extends BaseController {
  RxString title = ' '.obs;
  RxString thumble = ''.obs;
  StreamSubscription<PlaybackState>? _streamSubscription;
  Rx<PlayState> state = PlayState.Stop.obs;

  AudioHandler? get controllerAudio =>
      SingletonAudiohanle.instance.audioHandler;
  RxBool showAppBar = false.obs;
  RxBool initService = false.obs;
  final BuildContext rootContext;
  BuildContext? context;

  bool isShowDialog = false;

  AudioController(this.rootContext) {
    _init();
  }

  void _init() async {
    if (SingletonAudiohanle.instance.audioHandler == null) {
      initService.value = true;
      await SingletonAudiohanle.instance.init();
      initService.value = false;
    }

    _streamSubscription =
        SingletonAudiohanle.instance.audioHandler?.playbackState.listen(
      (event) {
        if (event.playing) {
          state.value = PlayState.Playing;
        } else {
          state.value = PlayState.Stop;
          switch (event.processingState) {
            case AudioProcessingState.loading:
              state.value = PlayState.Loading;
              break;
            case _:
              break;
          }
        }
      },
    );

    SingletonAudiohanle.instance.audioHandler?.mediaItem.listen(
      (event) {
        if (event != null) {
          title.value = event.title;
          thumble.value = event.artUri.toString();
        }
      },
    );

    state.listen(
      (p0) {
        if (p0 == PlayState.Playing) {
          DataRepository.instance.avatarPlay();
        } else {
          DataRepository.instance.avatarStop();
        }
      },
    );

    SingletonAudiohanle.instance.audioHandler?.customEvent.distinct().listen(
      (event) {
        if (event is ErorrBase) {
          DataRepository.instance.stopAllDownload();
          // if (DataRepository.instance.contextScreen?.mounted == true &&
          //     isShowDialog == false) {
          //   isShowDialog = true;
          //   showAdaptiveDialog(
          //     context: DataRepository.instance.contextScreen!,
          //     barrierDismissible: false,
          //     builder: (context) => AlertDialog(
          //       title: Row(
          //         children: [
          //           const Icon(
          //             AppIcons.error,
          //             color: Colors.red,
          //           ),
          //           10.w,
          //           const Text('Lỗi'),
          //         ],
          //       ),
          //       content: SingleChildScrollView(
          //         child: ListBody(
          //           children: <Widget>[
          //             Text(
          //               event.message,
          //               style: titleStyle,
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //       actions: <Widget>[
          //         TextButton(
          //           child: const Text('Đóng'),
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //             isShowDialog = false;
          //           },
          //         ),
          //       ],
          //     ),
          //   );
          // }
        }
      },
    );
  }

  @override
  void dispose() {
    state.close();
    title.close();
    _streamSubscription?.cancel();
    super.dispose();
  }

  void play() {
    controllerAudio?.play();
  }

  void pause() {
    controllerAudio?.pause();
  }

  void resume() {
    controllerAudio?.play();
  }

  void next() {
    controllerAudio?.skipToNext();
  }

  void pre() {
    controllerAudio?.skipToPrevious();
  }

  void onSeek(Duration duration) {
    controllerAudio?.seek(duration);
  }

  void stop() {
    controllerAudio?.stop();
  }

  Stream<PositionData>? get position =>
      SingletonAudiohanle.instance.audioHandler?.customEvent
          .where((event) => event is PositionData)
          .cast<PositionData>();

  void showBottomPlayList(BuildContext context) {
    showCupertinoModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (context) => Material(
        child: SizedBox(
          height: 450,
          child: Column(
            children: [
              const Text(
                "Danh sach phat",
                style: titleStyle,
              ),
              5.h,
              Expanded(child: _playList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _playList() {
    return StreamBuilder<List<MediaItem>>(
        stream: SingletonAudiohanle.instance.audioHandler?.queue,
        builder: (context, snapshot) {
          final list = snapshot.data;
          if (list == null) {
            return const SizedBox.shrink();
          } else {
            return ListView(
              children: [
                for (int i = 0; i < list.length; ++i) _itemPlayList(list[i], i)
              ],
            );
          }
        });
  }

  Widget _itemPlayList(MediaItem item, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Text(
          "$index",
          style: afaca,
        ),
        title: Text(
          "$index: ${item.title}",
          style: afaca,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.circle_rounded),
        subtitle: Text(
          item.extras?['number'] ?? '',
          style: afaca,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void changeAudio() {
    SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.mp3);
  }

  void changeText() {
    SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.text);
  }

  void getVoices() {
    DataRepository.instance.flowerTTS();
  }
}
