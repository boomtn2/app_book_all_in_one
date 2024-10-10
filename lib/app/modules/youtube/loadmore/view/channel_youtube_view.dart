import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/values/text_styles.dart';
import '../../../../core/widget/loading.dart';
import '../../../../views/views/item_card_book_view.dart';
import '../channel_youtuebe_controller.dart';

class LoadMorePlayListYoutubeView extends StatelessWidget {
  const LoadMorePlayListYoutubeView(
      {super.key, required this.channelYoutuebeController});
  final LoadMorePlayListController channelYoutuebeController;
  static const String name = "loadmoreplaylistytb";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: channelYoutuebeController.listener,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
            child: GridView.count(
              childAspectRatio: 0.7,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 3,
              children: [
                for (var item in channelYoutuebeController.listChannel)
                  ItemCardBookView(
                      book: item,
                      callback: (book) =>
                          channelYoutuebeController.openDetail(book, context)),
                const Center(
                  child: Column(
                    children: [
                      Loading(),
                      Text(
                        maxLines: 1,
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
