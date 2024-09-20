import 'package:audio_youtube/app/core/base/base_view.dart';
import 'package:audio_youtube/app/modules/home/controllers/home_controller.dart';
import 'package:audio_youtube/app/modules/home/widgets/new_view.dart';
import 'package:audio_youtube/app/modules/home/widgets/sli_expend.dart';

import 'package:flutter/material.dart';

import '../widgets/category_view.dart';
import '../widgets/intro_view.dart';
import '../widgets/rss_view.dart';
import '../widgets/sli_search_view.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});
  static const name = 'home';
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliSearchView(),
        SliverExpandedView(height: 10),
        CategoryView(),
        NewView(),
        RssView(),
        IntroView(),
        SliverExpandedView(height: 350)
      ],
    );
  }
}
