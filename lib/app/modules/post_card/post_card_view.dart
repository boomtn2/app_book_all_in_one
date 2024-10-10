import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/modules/post_card/post_card_controller.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCardView extends StatelessWidget {
  const PostCardView({super.key, required this.controller});
  final PostCardController controller;
  static const String name = 'postcardviewvnepress';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.introPostCard.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Center(
                  child: CacheImage(
                    url: controller.introPostCard.img,
                    height: 160,
                    width: 200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                5.h,
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Row(
                children: [
                  _buttonTextAroud(
                      'Nghe danh sách', AppIcons.audioPlaylist, () {}),
                ],
              ),
            ),
          ),
          Obx(
            () => SliverList.builder(
              itemCount: controller.playList.length,
              itemBuilder: (context, index) {
                final book = controller.playList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: [
                          CacheImage(
                            url: book.img,
                            height: 100,
                            width: 100,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          10.w,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: afaca.s14
                                        .copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      book.detail ?? 'Nội dung',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: afaca.s12
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(AppIcons.audioPlay),
                          5.w,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Xem thêm",
                      style: titleStyle,
                    ))),
          ),
          SliverToBoxAdapter(
            child: 130.h,
          )
        ],
      ),
    );
  }

  Widget _buttonTextAroud(String tile, IconData icon, Function callBack) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black54, width: 1, strokeAlign: 1)),
      child: Row(
        children: [
          Icon(icon),
          5.w,
          Text(
            tile,
            style: afaca,
          ),
        ],
      ),
    );
  }
}
