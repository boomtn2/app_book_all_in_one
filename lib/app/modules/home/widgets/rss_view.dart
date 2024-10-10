import 'package:audio_youtube/app/core/extension/list_extention.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/values/app_values.dart';
import '../../../data/model/models_export.dart';
import '../../../views/views/item_card_book_view.dart';

class RssView extends GetView<HomeController> {
  const RssView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppValues.paddingLeft,
          right: AppValues.paddingLeft,
        ),
        child: Obx(
          () => Column(
            children: [
              TitleView(
                title: 'Chọn lọc',
                style: bigTitleStyle.s20,
                funtion: () {
                  controller.openLoadMore(controller.videoRSS, context);
                },
              ),
              5.h,
              Skeletonizer(
                enabled: controller.isRSSLoading.value,
                child: controller.isRSSLoading.value
                    ? _body(size, controller.dataFake(), 6, context)
                    : _body(
                        size,
                        controller.videoRSS,
                        controller.count(2, controller.videoRSS.length),
                        context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(
      Size size, List<BookModel> books, int lenght, BuildContext context) {
    return SizedBox(
      height: 180,
      width: size.width - 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < lenght; i++)
            SizedBox(
              height: 180,
              width: size.width - 40,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ItemCardBookView(
                      callback: (book) {
                        controller.openDetail(book, context);
                      },
                      book: books.getNullIndex(i * 3),
                    ),
                  ),
                  10.w,
                  Expanded(
                    child: ItemCardBookView(
                      callback: (book) {
                        controller.openDetail(book, context);
                      },
                      book: books.getNullIndex((i * 3) + 1),
                    ),
                  ),
                  10.w,
                  Expanded(
                    child: ItemCardBookView(
                      callback: (book) {
                        controller.openDetail(book, context);
                      },
                      book: books.getNullIndex((i * 3) + 2),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
