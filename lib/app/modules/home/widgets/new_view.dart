import 'package:audio_youtube/app/core/extension/list_extention.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/model/channel_model.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/home/widgets/sli_expend.dart';
import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:audio_youtube/app/views/views/cache_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/values/app_values.dart';

import '../../../views/views/item_card_book_horital_view.dart';

class NewView extends GetView<HomeController> {
  const NewView({super.key});

  final Color color = Colors.black;
  final double sizeMax = 1800;

  void openDetail(BookModel model) {}

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.videoYoutube.isEmpty
          ? const SliverExpandedView(height: 0)
          : SliverToBoxAdapter(
              child: Container(
              margin: const EdgeInsets.only(
                  left: AppValues.paddingLeft, right: AppValues.paddingRight),
              child: Column(
                children: [
                  TitleView(
                    title: 'Đề xuất',
                    funtion: () {},
                  ),
                  Skeletonizer(
                      enabled: controller.isHotLoading.value,
                      child: controller.isHotLoading.value
                          ? _videos(controller.dataFake())
                          : _videos(controller.videoYoutube)),
                  5.h,
                  TitleView(
                    title: 'Kênh hay:',
                    style: boldTitleStyle,
                    funtion: () {},
                  ),
                  Skeletonizer(
                    enabled: false,
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => 10.w,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.channel.length,
                        itemBuilder: (context, index) =>
                            channel(controller.channel[index]),
                      ),
                    ),
                  ),
                  20.h,
                ],
              ),
            )),
    );
  }

  Widget _videos(List<BookModel> books) {
    return SizedBox(
        width: sizeMax,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              child: Row(
                children: [
                  for (int i = 0; i < books.length / 2; ++i)
                    Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ItemCardBookHoritalView(
                              book: books.getNullIndex(i * 2),
                              openDetail: openDetail,
                            ),
                            5.h,
                            ItemCardBookHoritalView(
                              book: controller.videoYoutube
                                  .getNullIndex((i * 2) + 1),
                              openDetail: openDetail,
                            ),
                          ],
                        ),
                        10.w,
                      ],
                    ),
                ],
              ),
            )));
  }

  Widget channel(ChannelModel channel) {
    return SizedBox(
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            maxRadius: 28,
            child: CacheImage(
              width: 50,
              height: 50,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              url: channel.thumbail,
            ),
          ),
          5.w,
          Expanded(
            child: Text(
              channel.name,
              style: titleStyle,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
