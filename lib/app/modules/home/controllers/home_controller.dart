import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/data/api/gist/rss_remote.dart';
import 'package:audio_youtube/app/data/api/youtube/youtube_remote.dart';
import 'package:audio_youtube/app/data/model/rss_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../data/model/book_model.dart';
import '../../../data/repository/player_youtube_repository.dart';
import '../../../data/repository/youtube_search_response.dart';

class HomeController extends GetxController {
  RxList<BookModel> videoYoutube = <BookModel>[].obs;
  RxList<BookModel> videoRSS = <BookModel>[].obs;
  YoutubeSearchResponse? responseYoutube;
  PodcastList? podcastList;
  RxMap<String, bool> titleTabPrenium = {
    'Đề xuất': false,
    'Chọn lọc': false,
  }.obs;

  Rx<BookModel> book = BookModel(title: '', author: '', img: '', type: '').obs;

  PanelController panelController = PanelController();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    videoYoutube.clear();
    super.onClose();
  }

  Future _loadHotSearchYoutube() async {
    responseYoutube =
        await YoutubeRemoteDataSoureImpl().searchYoutubeVideo('Thập niên');

    responseYoutube?.items.forEach((element) {
      final book = BookModel(
          title: element.snippet?.title ?? '',
          author: element.snippet?.channelTitle ?? '',
          img: element.snippet?.thumbnails?.thumbnailsDefault?.url ?? '',
          id: element.id?.videoId ?? element.id?.playlistId,
          type: element.id?.kind ?? '',
          snippet: element.snippet,
          detail: element.snippet?.description);
      videoYoutube.add(book);
    });
  }

  Future _loadRSS() async {
    podcastList = await RSSRemoteDataSoureImpl().fetchDataRSS();

    podcastList?.rss.forEach((element) {
      final book = BookModel(
          title: element.name,
          author: '',
          img: element.img,
          id: element.link,
          type: Const.typeMP3,
          detail: '');
      videoRSS.add(book);
    });
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      panelController.hide();
    });
    await _loadHotSearchYoutube();
    _loadRSS();
  }

  void selectTab(String tabName) {
    switch (tabName) {
      case 'Đề xuất':
        responseYoutube?.items.forEach((element) {
          final book = BookModel(
              title: element.snippet?.title ?? '',
              author: element.snippet?.channelTitle ?? '',
              img: element.snippet?.thumbnails?.thumbnailsDefault?.url ?? '',
              id: element.id?.videoId ?? element.id?.playlistId,
              type: element.id?.kind ?? '',
              snippet: element.snippet,
              detail: element.snippet?.description);
          videoYoutube.add(book);
        });
        break;
      case 'Chọn lọc':
        break;
    }
  }

  void openDetail(BookModel model) async {
    PlayerYoutubeRepository.instance.panelController = panelController;
    await PlayerYoutubeRepository.instance.loadPlayListVideo(model);

    await panelController.show();
    await panelController.open();
  }

  void onPanelClosed() {}

  void onPanelOpened() {}

  RxBool isHideBottomNavigator = false.obs;

  void hideBottomNavigator() {
    isHideBottomNavigator.value = false;
  }

  void showBottomNavigator() {
    isHideBottomNavigator.value = true;
  }

  void closedPannel() {
    PlayerYoutubeRepository.instance.dispose();
  }
}
