import 'package:audio_youtube/app/views/views/item_card_book_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class NewsView extends StatelessWidget {
  NewsView({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            // mainAxisExtent: 160.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ItemCardBookView(
                book: controller.newsListBook[index],
                callback: (book) {
                  controller.openPlayListPostCard(context, book);
                },
              );
            },
            childCount: controller.newsListBook.length, // Number of grid items
          ),
        ),
      ),
    );
  }
}
