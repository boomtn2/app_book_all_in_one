import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/data/remote/gist/rss_remote.dart';

import 'package:audio_youtube/app/data/model/rss_model.dart';
import 'package:audio_youtube/app/data/repository/youtube_repository.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../data/model/book_model.dart';

class HomeController extends GetxController {
  RxList<BookModel> videoYoutube = <BookModel>[].obs;
  RxList<BookModel> videoRSS = <BookModel>[].obs;

  final YoutubeRepository _ytbRepository =
      Get.find(tag: (YoutubeRepository).toString());
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
    _loadHotSearchYoutube();
  }

  @override
  void onClose() {
    _ytbRepository.dispose();
    videoYoutube.clear();
    super.onClose();
  }

  Future _loadHotSearchYoutube() async {
    List<BookModel> list = [];
    list = await _ytbRepository.search('Thập niên 70');
    videoYoutube.value = list;
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

  void selectTab(String tabName) {}

  void openDetail(BookModel model) async {
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

  void closedPannel() {}
}
