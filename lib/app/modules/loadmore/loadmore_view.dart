import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:audio_youtube/app/modules/loadmore/loadmore_controller.dart';

import 'package:audio_youtube/app/views/views/item_card_book_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadMoreView extends StatelessWidget {
  const LoadMoreView({super.key, required this.controller});
  final LoadMoreController controller;
  static const String name = 'loadmoreview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
          child: NotificationListener<ScrollEndNotification>(
            onNotification: controller.listener,
            child: GridView.count(
              // controller: controller.scrollController,
              childAspectRatio: 0.7,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 3,
              children: [
                for (var item in controller.list)
                  ItemCardBookView(
                      book: item,
                      callback: (book) => controller.openDetail(book, context)),
                const Center(
                  child: Column(
                    children: [
                      Loading(),
                      Text(
                        'Đang tải...',
                        style: afaca,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
