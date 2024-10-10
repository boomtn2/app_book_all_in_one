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

  void openDetail(BookModel model, BuildContext context) {
    controller.openDetail(model, context);
  }

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
                    funtion: () {
                      controller.openLoadMoreYoutube(
                          controller.videoYoutube, context);
                    },
                  ),
                  _videos(controller.videoYoutube, context),
                  5.h,
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TitleView(
                            title: 'Kênh hay:',
                            style: boldTitleStyle,
                            funtion: () {
                              controller.openAllChannel(context);
                            },
                          ),
                          SizedBox(
                            height: 60,
                            width: MediaQuery.sizeOf(context).width,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => 10.w,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.channel.length,
                              itemBuilder: (context, index) =>
                                  channel(controller.channel[index], context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.h,
                ],
              ),
            )),
    );
  }

  Widget _videos(List<BookModel> books, BuildContext context) {
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
                              openDetail: (p0) => openDetail(p0, context),
                            ),
                            5.h,
                            ItemCardBookHoritalView(
                              book: controller.videoYoutube
                                  .getNullIndex((i * 2) + 1),
                              openDetail: (p0) => openDetail(p0, context),
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

  Widget channel(ChannelModel channel, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.openChannel(context, channel);
      },
      child: SizedBox(
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
                style: titleStyle.s14,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
