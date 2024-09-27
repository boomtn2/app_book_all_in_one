import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../data/service/audio/model/position_data.dart';

enum PlayState { Playing, Pause, Stop, Loading }

class AudioController extends GetxController {
  RxString title = ' '.obs;
  StreamSubscription<PlaybackState>? _streamSubscription;
  Rx<PlayState> state = PlayState.Stop.obs;
  AudioHandler? get controllerAudio =>
      SingletonAudiohanle.instance.audioHandler;
  RxBool showAppBar = false.obs;
  AudioController() {
    _init();
  }

  void _init() {
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
        title.value = event?.title ?? 'Rỗng';
      },
    );
  }

  @override
  void dispose() {
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
            return Column(
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
      child: Text(item.title),
    );
  }

  void addDataTest() {
    SingletonAudiohanle.instance.audioHandler?.updateQueue(const [
      MediaItem(
          id: 'https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3',
          title: 'Datatest',
          extras: {
            'number':
                """Có tiền có nhan kiều kiều phú bà mỹ nhân X ngoài lạnh trong nóng tuấn mỹ thần y ca ca
    
    Phú bà Giang Nhan Khanh xuyên qua đến những năm 80, người mang không gian biệt thự, khai cửa hàng, mua sơn, một đường hô mưa gọi gió xây dựng chính mình thương nghiệp đế quốc.
    
    Ân nhân cứu mạng là cái tuấn mỹ vô song tiểu thiếu niên, quải về nhà dưỡng, ai ngờ dưỡng dưỡng, tiểu thiếu niên bề ngoài lạnh như băng, kỳ thật là cái bá đạo sủng tính cách, Giang Nhan Khanh chỉ có thể một bên hưởng thụ, một bên sủng trở về.
    
    Chờ đến sau lại, Phương Minh Tiêu đem tiểu kiều thê giam cầm ở chính mình trong lòng ngực, hận không thể xoa tiến trong lòng.
    
    Niên đại hiện đại ngôn tình làm ruộng trọng sinh không gian"""
          }),
      MediaItem(
          id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
          title: "A Salute To Head-Scratching Science",
          extras: {
            'number':
                """Có tiền có nhan kiều kiều phú bà mỹ nhân X ngoài lạnh trong nóng tuấn mỹ thần y ca ca
    
    Phú bà Giang Nhan Khanh xuyên qua đến những năm 80, người mang không gian biệt thự, khai cửa hàng, mua sơn, một đường hô mưa gọi gió xây dựng chính mình thương nghiệp đế quốc.
    
    Ân nhân cứu mạng là cái tuấn mỹ vô song tiểu thiếu niên, quải về nhà dưỡng, ai ngờ dưỡng dưỡng, tiểu thiếu niên bề ngoài lạnh như băng, kỳ thật là cái bá đạo sủng tính cách, Giang Nhan Khanh chỉ có thể một bên hưởng thụ, một bên sủng trở về.
    
    Chờ đến sau lại, Phương Minh Tiêu đem tiểu kiều thê giam cầm ở chính mình trong lòng ngực, hận không thể xoa tiến trong lòng.
    
    Niên đại hiện đại ngôn tình làm ruộng trọng sinh không gian"""
          }),
    ]);
  }

  void changeAudio() {
    SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.mp3);
  }

  void changeText() {
    SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.text);
  }
}
