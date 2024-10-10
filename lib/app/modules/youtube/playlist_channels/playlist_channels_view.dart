import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'playlist_channels_controller.dart';

class PlaylistChannelsView extends StatelessWidget {
  const PlaylistChannelsView({super.key, required this.controller});
  final PlaylistChannelsController controller;

  static const String name = 'PlaylistChannelsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() => Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
              child: ListView.builder(
                itemCount: controller.listData.length,
                itemBuilder: (context, index) {
                  final item = controller.listData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: ListTile(
                          leading: CacheImage(
                            url: item.channel.thumbail,
                            borderRadius: BorderRadius.circular(5),
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            item.channel.name,
                            style: afaca,
                          ),
                        ),
                      ),
                      for (var itemPlaylist in item.playlist)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CacheImage(
                                url: itemPlaylist.img,
                                borderRadius: BorderRadius.circular(5),
                                width: 50,
                                height: 50,
                              ),
                              5.w,
                              Expanded(
                                child: Text(
                                  itemPlaylist.title,
                                  style: afaca,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            )));
  }
}
