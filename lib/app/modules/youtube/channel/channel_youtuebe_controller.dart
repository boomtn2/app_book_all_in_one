import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/model/channel_model.dart';
import 'package:audio_youtube/app/data/remote/youtube/param_models/youtube_search_param_model.dart';
import 'package:audio_youtube/app/data/repository/youtube_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const.dart';
import '../../../core/utils/util.dart';
import '../detail_video/view/detail_video_youtube_view.dart';

class ChannelYoutuebeController extends GetxController {
  YoutubeRepository youtubeRemoteDataSoure =
      Get.find(tag: (YoutubeRepository).toString());
  final ChannelModel channelModel;
  RxList<BookModel> listChannel = <BookModel>[].obs;
  YoutubeSearchParamModel? param;

  ChannelYoutuebeController({required this.channelModel});
  void fetchData() async {
    listChannel.value =
        await youtubeRemoteDataSoure.searchIDChannel(channelModel.id);
    param = await youtubeRemoteDataSoure.getParamSearchModel();
  }

  bool isLoadMore = true;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(_listener);
    fetchData();
    super.onInit();
  }

  void _listener() {
    if (!scrollController.hasClients) return;

    var triggerFetchMoreSize = 0.9 * scrollController.position.maxScrollExtent;

    if (scrollController.position.pixels > triggerFetchMoreSize) {
      loadMore();
    }
  }

  bool isLoading = false;

  void loadMore() async {
    if (isLoading) return;
    isLoading = true;
    if (param != null && param?.token != null) {
      List<BookModel> temp = [];
      temp.addAll(listChannel);
      final data = await youtubeRemoteDataSoure.getLoadMoreSearch(param!);
      temp.addAll(data);
      listChannel.value = temp;
      isLoading = false;
    } else {
      scrollController.removeListener(_listener);
    }
  }

  void openDetail(BookModel book, BuildContext? context) {
    if (context != null) {
      if (book.type == Const.typePlayList) {
        Util.navigateNamed(context, DetailVideoYoutubeView.name, extra: book);
      }
    }
  }
}
