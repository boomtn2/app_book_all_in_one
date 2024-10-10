import 'package:audio_youtube/app/modules/youtube/channel/channel_youtuebe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../views/views/item_card_book_view.dart';

class ChannelYoutubeView extends StatelessWidget {
  const ChannelYoutubeView(
      {super.key, required this.channelYoutuebeController});
  final ChannelYoutuebeController channelYoutuebeController;
  static const String name = "channelyoutube";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
          child: GridView.count(
            controller: channelYoutuebeController.scrollController,
            childAspectRatio: 0.7,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: 3,
            children: [
              for (var item in channelYoutuebeController.listChannel)
                ItemCardBookView(
                    book: item,
                    callback: (book) =>
                        channelYoutuebeController.openDetail(book, context))
            ],
          ),
        ),
      ),
    );
  }
}
