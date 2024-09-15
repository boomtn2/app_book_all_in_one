import 'package:audio_youtube/app/core/extension/list_extention.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/home/widgets/sli_expend.dart';
import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/values/app_borders.dart';
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
                  const TitleView(title: 'Đề xuất'),
                  Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      width: sizeMax,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < controller.videoYoutube.length / 2;
                                  ++i)
                                Row(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ItemCardBookHoritalView(
                                          book: controller.videoYoutube
                                              .getNullIndex(i * 2),
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
                        ),
                      ),
                    ),
                  ),
                  5.h,
                  const TitleView(
                    title: 'Kênh hay:',
                    style: boldTitleStyle,
                  ),
                  Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => 10.w,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => channel('$index'),
                      ),
                    ),
                  ),
                  20.h,
                ],
              ),
            )),
    );
  }

  Widget channel(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(),
        5.w,
        Text(
          title,
          style: titleStyle,
          maxLines: 1,
        ),
      ],
    );
  }
}
