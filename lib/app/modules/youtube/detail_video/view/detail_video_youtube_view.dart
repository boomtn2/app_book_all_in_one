import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/views/folder/tabbar_folder.dart';
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
    instanceController.context = context;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    instanceController.init();
                  },
                  child: const Icon(AppIcons.audioDownLoad)),
            ],
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CacheImage(
                              url: instanceController.bookModel?.img,
                              height: 80,
                              width: 80,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            5.w,
                            const Expanded(
                              child: SizedBox(
                                height: 50,
                                child: Column(
                                  children: [
                                    Icon(
                                      AppIcons.audioPlay,
                                      color: Colors.blue,
                                    ),
                                    Text('Danh sách phát')
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(
                                height: 50,
                                child: Column(
                                  children: [
                                    Icon(
                                      AppIcons.audioDownLoad,
                                      color: Colors.blue,
                                    ),
                                    Text('Tải')
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.h,
                  Text(
                    instanceController.bookModel?.title ?? '',
                    maxLines: 2,
                    style: titleStyle,
                  ),
                  Text(
                    instanceController.bookModel?.detail ?? '',
                    style: afaca,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CacheImage(
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  5.w,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          instanceController.bookModel?.snippet?.channelTitle ??
                              '',
                          style: titleStyle,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Theo dõi',
                              style: afaca,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: 20.h,
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabbarFolder(tabs: const {
              'Danh sách phát': true,
              "Video": false,
              "Liên quan": false
            }, fct: (title) {}),
          )),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                left: BorderSide(color: Colors.grey, width: 1),
                right: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
    return InkWell(
      onTap: () {
        instanceController.getMp3(book);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          child: Row(
            children: [
              SizedBox(
                  height: 60,
                  width: 60,
                  child: CacheImage(
                    url: book.img,
                    height: 60,
                    width: 60,
                    borderRadius: BorderRadius.circular(5),
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
              ),
              const SizedBox(
                width: 42,
                child: Icon(AppIcons.audioPlay),
              )
            ],
          ),
        ),
      ),
    );
  }
}
