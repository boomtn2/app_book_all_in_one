import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/data/repository/data_repository.dart';

import 'package:audio_youtube/app/data/repository/html_repository.dart';
import 'package:audio_youtube/app/data/repository/rss_repository.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  RxInt indext = 0.obs;
  Rx<BookModel> bookModel = BookModel(
          title: 'Chưa có dữ liệu',
          author: 'Chưa có dữ liệu',
          img: '',
          type: '')
      .obs;

  List<BookModel> list = [];

  final RssRepository rss = RssRepositoryIml();
  final HtmlRepository html = HtmlRepositoryImpl();
  final DataRepository _dataRepository = DataRepository();
  final BookModel model;
  BuildContext? context;

  ChapterModel? _linkChapter;

  BookController({required this.model}) {
    _init();
  }

  void _init() async {
    if (model.type == Const.typeRSS) {
      final _list = await rss.getPlayList(model.id ?? '');
      if (_list.isNotEmpty) {
        model.detail = _list[0].detail;
        list = _list;
      }
    } else {
      final data = await html.dtruyenFetchInforBook(model.id ?? '');
      _linkChapter = data.$1;
      model.detail = data.$2.detail;
      model.view = data.$2.view;
      model.status = data.$2.status;
      model.category = data.$2.category;
    }

    bookModel.value = model;
    if (_linkChapter != null && model.type == Const.typeText) {
      _dataRepository.newDownloadText(_linkChapter!);
    }
  }

  final PageController pageController = PageController(
    initialPage: 0,
  );

  void tab(String tab) {
    if (tab.contains('Mô tả')) {
      indext.value = 1;
      pageController.jumpToPage(1);
    } else {
      indext.value = 0;
      pageController.jumpToPage(0);
    }
  }

  void playDemo() async {
    await SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.mp3);
    if (list.isNotEmpty) {
      SingletonAudiohanle.instance.audioHandler?.updateQueue([
        MediaItem(
            id: list.last.id ?? '',
            title: list.last.title,
            artUri: Uri.tryParse(list.last.img))
      ]);
    }
  }

  void dtruyenPlay() async {
    _dataRepository.startDownloadText(50, context!);
  }
}
