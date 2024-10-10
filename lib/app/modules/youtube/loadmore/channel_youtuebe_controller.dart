import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/remote/youtube/param_models/youtube_search_param_model.dart';
import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:audio_youtube/app/data/repository/youtube_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const.dart';
import '../../../core/utils/util.dart';
import '../detail_video/view/detail_video_youtube_view.dart';

class LoadMorePlayListController extends GetxController {
  YoutubeRepository youtubeRemoteDataSoure =
      Get.find(tag: (YoutubeRepository).toString());
  RxList<BookModel> listChannel = <BookModel>[].obs;
  YoutubeSearchParamModel? param;

  LoadMorePlayListController(
      {required List<BookModel> channelModel, this.param}) {
    listChannel.value = channelModel;
    param = DataRepository.instance.youtubeSearchParamModel;
  }

  bool isLoadMore = true;

  bool listener(ScrollEndNotification notification) {
    if (isLoadMore == false) {
      final ScrollMetrics(:pixels, :maxScrollExtent) = notification.metrics;
      if (pixels >= maxScrollExtent) {
        loadMore();
      }
    }

    return true;
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
