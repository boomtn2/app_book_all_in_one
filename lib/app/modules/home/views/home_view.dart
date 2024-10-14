import 'package:audio_youtube/app/core/base/base_view.dart';
import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/utils/icons.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/home/widgets/new_view.dart';
import 'package:audio_youtube/app/modules/home/widgets/sli_expend.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/text_styles.dart';
import '../widgets/category_view.dart';
import '../widgets/intro_view.dart';
import '../widgets/rss_view.dart';
import '../widgets/news_view.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});
  static const name = 'home';
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(FluentIcons.book_48_regular),
                  Text('Truyện hán việt')
                ],
              ),
              Row(
                children: [
                  Icon(FluentIcons.book_coins_24_regular),
                  Text('Truyện dịch việt')
                ],
              ),
            ],
          ),
        ),
        Obx(
          () => controller.isLoadingDataSystem.value
              ? SliverToBoxAdapter(
                  child: Column(
                    children: [
                      5.h,
                      const Loading(),
                      5.h,
                      Text(
                        'Đang tải dữ liệu truyện...',
                        style: titleStyle.s22,
                      ),
                      5.h,
                    ],
                  ),
                )
              : const SliverExpandedView(height: 0),
        ),
        const SliverExpandedView(height: 10),
        const CategoryView(),
        const NewView(),
        const RssView(),
        IntroView(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              'Post Card',
              style: bigTitleStyle.s20,
            ),
          ),
        ),
        NewsView(),
        const SliverExpandedView(height: 350)
      ],
    );
  }
}
