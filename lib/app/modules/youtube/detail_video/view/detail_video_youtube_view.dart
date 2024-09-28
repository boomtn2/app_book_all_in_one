import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/views/avatar_audio.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/detail_video_youtube_controller.dart';

class DetailVideoYoutubeView extends GetView<DetailVideoYoutubeController> {
  const DetailVideoYoutubeView(this.instanceController, {super.key});
  static const String name = 'detail-video-youtube';
  final DetailVideoYoutubeController instanceController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(140),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 120,
                              width: 120,
                              child: CacheImage(
                                url: instanceController.bookModel?.img,
                                height: 120,
                                width: 120,
                                borderRadius: BorderRadius.circular(10),
                              )),
                          5.w,
                          Expanded(
                            child: Text(
                              instanceController.bookModel?.title ?? '',
                              maxLines: 2,
                              style: titleStyle,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        instanceController.bookModel?.detail ?? '',
                        style: afaca,
                      )
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
                onPressed: () {
                  instanceController.init();
                },
                child: Text('FetchData')),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              width: MediaQuery.sizeOf(context).width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _textButton('Danh sách phát', 0),
                  _textButton('Video trên kênh', 1),
                  _textButton('Video liên quan', 2),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 650,
            child: PageView(
              children: [
                _pageVideoPlaylist(),
                _pageVideoChannelUpload(),
                _pageVideoRelated()
              ],
            ),
          )),
          SliverToBoxAdapter(
            child: 120.h,
          )
        ],
      ),
    );
  }

  Widget _pageVideoPlaylist() {
    return Obx(
      () => Container(
        height: 600,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: instanceController.videosPlaylist.map(
            (element) {
              return _item(element);
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _textButton(String title, int index) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Text(
          title,
          style: titleStyle,
        ),
      ),
    );
  }

  Widget _pageVideoChannelUpload() {
    return Obx(
      () => SizedBox(
        height: 600,
        child: ListView(
          children: instanceController.videoChannelUpload.map(
            (element) {
              return _item(element);
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _pageVideoRelated() {
    return Obx(
      () => SizedBox(
        height: 600,
        child: ListView(
          children: instanceController.getVideosRelated.map(
            (element) {
              return _item(element);
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _item(BookModel book) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
              height: 60,
              width: 60,
              child: CacheImage(
                url: book.img,
                height: 60,
                width: 60,
                borderRadius: BorderRadius.circular(60),
              )),
          10.w,
          Expanded(
            child: Column(
              children: [
                Text(
                  book.title,
                  style: titleStyle.s16,
                  maxLines: 2,
                ),
                Text(
                  book.type,
                  style: afaca.s12,
                  maxLines: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
