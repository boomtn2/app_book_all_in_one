import 'package:audio_youtube/app/core/extension/list_extention.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/home/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_values.dart';
import '../../../views/views/item_card_book_view.dart';

class RssView extends GetView<HomeController> {
  const RssView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.only(
        left: AppValues.paddingLeft,
        right: AppValues.paddingLeft,
      ),
      child: Column(
        children: [
          TitleView(
            title: 'Dịch Việt',
            style: bigTitleStyle.s20,
          ),
          5.h,
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ItemCardBookView(
                      book: controller.videoRSS.getNullIndex(0),
                    ),
                  ),
                  10.w,
                  Expanded(
                    child: ItemCardBookView(
                      book: controller.videoRSS.getNullIndex(0),
                    ),
                  ),
                  10.w,
                  Expanded(
                    child: ItemCardBookView(
                      book: controller.videoRSS.getNullIndex(0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
