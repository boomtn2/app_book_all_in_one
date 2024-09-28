import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/modules/audio/views/widgets/button_audio.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/text_styles.dart';
import '../../../core/widget/loading.dart';
import '../controllers/audio_controller.dart';

class MiniAudioView extends StatelessWidget {
  const MiniAudioView({super.key, required this.instanceController});
  final AudioController instanceController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.72),
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          5.w,
          SizedBox(
            height: 50,
            width: 50,
            child: CacheImage(
              url: instanceController.thumble.value,
              height: 50,
              width: 50,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Expanded(
              child: Obx(() => Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    instanceController.title.value,
                    style: afaca.copyWith(fontWeight: FontWeight.w700),
                  ))),
          _playState(),
        ],
      ),
    );
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

  Widget _playState() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Visibility(
              visible: (instanceController.state.value == PlayState.Loading),
              child: _loading()),
          Visibility(
              visible: (instanceController.state.value == PlayState.Stop ||
                  instanceController.state.value == PlayState.Pause),
              child: ButtonAudio(
                  icon: AppIcons.audioPlay,
                  title: 'Nghe',
                  callback: () => instanceController.play())),
          Visibility(
              visible: (instanceController.state.value == PlayState.Playing),
              child: ButtonAudio(
                icon: AppIcons.audioStop,
                title: 'Dừng',
                callback: () => instanceController.pause(),
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
