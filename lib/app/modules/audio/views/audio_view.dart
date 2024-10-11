import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:audio_youtube/app/modules/audio/views/widgets/button_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/service/audio/model/position_data.dart';
import '../../../views/avatar_audio.dart';
import '../controllers/audio_controller.dart';

class AudioView extends GetView<AudioController> {
  const AudioView(this.instanceController, {super.key});
  final AudioController instanceController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: Theme.of(context)
              .colorScheme
              .secondaryContainer
              .withOpacity(0.72),
          appBar: AppBar(
            backgroundColor: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(0.72),
            leading: instanceController.showAppBar.value
                ? ButtonAudio(
                    icon: AppIcons.appClose,
                    title: 'Thoát',
                    callback: instanceController.closeSliup,
                  )
                : null,
            // actions: instanceController.showAppBar.value
            //     ? const [
            //         ButtonAudio(
            //           icon: AppIcons.appMenu,
            //           title: 'Menu',
            //           callback: null,
            //         ),
            //       ]
            //     : [],
          ),
          body: instanceController.initService.value
              ? Center(
                  child: Column(
                    children: [
                      const Loading(),
                      10.h,
                      const Text(
                        'Đang khởi tạo hệ thống',
                        style: titleStyle,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              10.h,
                              AvatarAudio(
                                url: instanceController.thumble.value,
                              ),
                              5.h,
                              _title(),
                              PositionBar(
                                instanceController: instanceController,
                              ),
                              5.h,
                              _playState(),
                            ],
                          ),
                        ),
                        20.h,
                        _moreFuntion(),
                        20.h,
                        _buttonAction(
                            AppIcons.audioPlaylist,
                            'Danh sách phát',
                            () =>
                                instanceController.showBottomPlayList(context)),
                      ],
                    ),
                  ),
                )),
    );
  }

  Widget _moreFuntion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ButtonAudio(
          icon: AppIcons.audioVoice,
          title: 'Giọng đọc',
          callback: () => instanceController.getVoices(),
        ),
        const ButtonAudio(
          icon: AppIcons.audioDownLoad,
          title: 'Tải về',
          callback: null,
        ),
        const ButtonAudio(
          icon: AppIcons.audioFavorite,
          title: 'Yêu thích',
          callback: null,
        ),
        const ButtonAudio(
          icon: AppIcons.audioReport,
          title: 'Báo lỗi',
          callback: null,
        ),
        const ButtonAudio(
          icon: AppIcons.donate,
          title: 'Ủng hộ',
          callback: null,
        ),
      ],
    );
  }

  Widget _playState() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonAudio(
              icon: AppIcons.audioPre,
              title: 'Bài trước',
              callback: () => instanceController.pre()),
          _stateButtonPlay(instanceController.state.value),
          ButtonAudio(
              icon: AppIcons.audioNext,
              title: 'Bài tiếp',
              callback: () => instanceController.next()),
        ],
      ),
    );
  }

  Widget _stateButtonPlay(PlayState state) {
    switch (state) {
      case PlayState.Playing:
        return Row(
          children: [
            ButtonAudio(
              icon: AppIcons.audioPause,
              title: 'Tạm dừng',
              callback: () => instanceController.pause(),
              color: Colors.green,
            ),
            10.w,
            ButtonAudio(
              icon: AppIcons.audioStop,
              title: 'Dừng',
              callback: () => instanceController.stop(),
              color: Colors.red,
            ),
          ],
        );
      case PlayState.Pause:
        return ButtonAudio(
            icon: AppIcons.audioPlay,
            title: 'Nghe',
            callback: () => instanceController.play());
      case PlayState.Stop:
        return ButtonAudio(
            icon: AppIcons.audioPlay,
            title: 'Nghe',
            callback: () => instanceController.play());
      case PlayState.Loading:
        return _loading();
    }
  }

  Widget _loading() {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Loading()),
          Text(
            'Đang tải',
            style: afaca.s10,
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        controller.title.value,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: afaca.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buttonAction(IconData icon, String title,
      [GestureTapCallback? callback]) {
    return InkWell(
      onTap: callback,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            5.w,
            Text(
              title,
              style: afaca.s14,
            )
          ],
        ),
      ),
    );
  }
}

class PositionBar extends StatelessWidget {
  const PositionBar({super.key, required this.instanceController});
  final AudioController instanceController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: StreamBuilder<PositionData>(
          stream: instanceController.position,
          builder: (context, snapshot) {
            final position = snapshot.data;
            return ProgressBar(
              thumbRadius: 6,
              barHeight: 2,
              progressBarColor: Colors.black,
              bufferedBarColor: Colors.grey.shade400,
              thumbColor: Colors.black,
              baseBarColor: Colors.grey.shade200,
              progress: position?.position ?? Duration.zero,
              buffered: position?.bufferedPosition ?? Duration.zero,
              total: position?.duration ?? Duration.zero,
              onSeek: (duration) {
                instanceController.onSeek(duration);
              },
            );
          }),
    );
  }
}
