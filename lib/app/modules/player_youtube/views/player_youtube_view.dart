import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/app_values.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';

import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../data/repository/player_youtube_repository.dart';
import '../controllers/player_youtube_controller.dart';

class PlayerYoutubeView extends StatefulWidget {
  const PlayerYoutubeView({super.key, required this.sc});
  final ScrollController sc;
  @override
  State<PlayerYoutubeView> createState() => _PlayerYoutubeViewState();
}

class _PlayerYoutubeViewState extends State<PlayerYoutubeView>
    with AutomaticKeepAliveClientMixin {
  late PlayerYoutubeController controller;

  @override
  void initState() {
    controller = PlayerYoutubeRepository.instance.viewController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        clipBehavior: Clip.none,
      ),
      body: SingleChildScrollView(
        controller: widget.sc,
        child: Column(
          children: [
            VideoPlayer(),
            _detail(),
            const Divider(),
            _playList(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _detail() {
    return Obx(
      () => Column(
        children: [
          5.h,
          Padding(
            padding: const EdgeInsets.only(
                left: AppValues.paddingLeft, right: AppValues.paddingRight),
            child: Text(
              controller.video.value?.title ?? '',
              style: titleStyle.s14,
              textAlign: TextAlign.center,
            ),
          ),
          10.h,
          Padding(
            padding: const EdgeInsets.only(
                left: AppValues.paddingLeft, right: AppValues.paddingRight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.error),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.monetization_on),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                ),
              ],
            ),
          ),
          20.h,
          Padding(
            padding: const EdgeInsets.only(
                left: AppValues.paddingLeft, right: AppValues.paddingRight),
            child: Text(
              controller.video.value?.snippet?.description ?? '',
              style: textStyle.s14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _playList() {
    return Obx(
      () => Column(
        children: [
          for (var item in controller.playList)
            Padding(
              padding: const EdgeInsets.only(
                  left: AppValues.paddingLeft, right: AppValues.paddingRight),
              child: InkWell(
                onTap: () {
                  controller.playVideo(item);
                },
                child: Card(
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                              flex: 1,
                              child: CacheImage(
                                borderRadius: BorderRadius.circular(4),
                                url: item.img,
                              )),
                          10.w,
                          Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: textButtonStyle,
                                    maxLines: 2,
                                  ),
                                  Text(
                                    item.snippet?.channelTitle ?? '',
                                    style: afaca.s10,
                                    maxLines: 1,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class VideoPlayer extends StatelessWidget {
  VideoPlayer({super.key});
  PlayerYoutubeController controller =
      PlayerYoutubeRepository.instance.viewController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !controller.hideVideoPlayer.value,
        child: PlayerYoutubeRepository.instance.playerController != null
            ? YoutubePlayer(
                controller: PlayerYoutubeRepository.instance.playerController!,
                actionsPadding: const EdgeInsets.only(left: 16.0),
                bottomActions: [
                  CurrentPosition(),
                  10.w,
                  ProgressBar(isExpanded: true),
                  10.w,
                  RemainingDuration(),
                  FullScreenButton(),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
