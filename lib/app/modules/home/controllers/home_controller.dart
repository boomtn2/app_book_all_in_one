import 'dart:async';
import 'package:audio_youtube/app/core/base/base_controller.dart';
import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/core/utils/util.dart';
import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:audio_youtube/app/data/repository/gist_repository.dart';
import 'package:audio_youtube/app/data/repository/html_repository.dart';
import 'package:audio_youtube/app/data/repository/news_repository.dart';
import 'package:audio_youtube/app/data/repository/youtube_repository.dart';
import 'package:audio_youtube/app/modules/book/views/book_view.dart';
import 'package:audio_youtube/app/modules/search/views/search_view.dart';
import 'package:audio_youtube/app/modules/webview/views/webview_book_view.dart';
import 'package:audio_youtube/app/modules/youtube/detail_video/view/detail_video_youtube_view.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../data/model/models_export.dart';

class HomeController extends BaseController {
  final YoutubeRepository _ytbRepository =
      Get.find(tag: (YoutubeRepository).toString());
  final GistRepository _gistRepository =
      Get.find(tag: (GistRepository).toString());
  DataRepository get _dataRepository => DataRepository.instance;
  final HtmlRepository _htmlRepository = HtmlRepositoryImpl();
  final NewsRepository _newsRepository = NewsRepositoryImpl();

  RxList<BookModel> videoYoutube = <BookModel>[].obs;
  RxList<BookModel> videoRSS = <BookModel>[].obs;
  RxList<BookModel> dtruyenListBook = <BookModel>[].obs;
  RxList<BookModel> newsListBook = <BookModel>[].obs;
  RxList<Tag> tags = <Tag>[].obs;
  RxList<ChannelModel> channel = <ChannelModel>[].obs;

  ConfigWebsiteModel? configWebsite;
  ListSearchTag? tagSearch;
  ListSearchName? nameSearch;

  RxBool isCategoryLoading = true.obs;
  RxBool isHotLoading = true.obs;
  RxBool isChannelLoading = true.obs;
  RxBool isRSSLoading = true.obs;
  RxBool isDtruyenLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadDtruyen();

    await _loadRSS();
    await _loadHotSearchYoutube();
    await _loadNews();
    await _getChannel();
    await _loadConfigWebsite();
    await _getCategory();
    await _getSearch();
    _saveData();
  }

  @override
  void onClose() {
    _ytbRepository.dispose();
    videoYoutube.clear();
    super.onClose();
  }

  void _saveData() {
    _dataRepository.configWebsite = configWebsite;
    _dataRepository.nameSearch = nameSearch;
    _dataRepository.tagSearch = tagSearch;
  }

  Future _loadConfigWebsite() async {
    configWebsite = await _gistRepository.getConfigWebsite();
  }

  Future _loadHotSearchYoutube() async {
    try {
      isHotLoading.value = true;
      final response = await _ytbRepository.search('Thập niên 70');
      videoYoutube.value = response;
      await Future.delayed(const Duration(seconds: 1));
      isHotLoading.value = false;
    } catch (e) {
      showErrorMessage('Đề xuất bị lỗi!');
    }
  }

  Future _loadRSS() async {
    try {
      isRSSLoading.value = true;
      final response = await _gistRepository.getRSS();
      List<BookModel> list = [];
      for (var element in response.rss) {
        final book = BookModel(
            title: element.name,
            author: '',
            img: element.img,
            id: element.link,
            type: Const.typeRSS,
            price: element.price,
            detail: '');
        list.add(book);
      }
      videoRSS.value = list;
      await Future.delayed(const Duration(seconds: 1));
      isRSSLoading.value = false;
    } catch (e) {
      showErrorMessage('Tải dữ liệu Dịch việt thất bại!');
    }
  }

  Future _loadDtruyen() async {
    try {
      final list = await _htmlRepository
          .dtruyenFetchListBook("https://dtruyen.net/truyen-nu-cuong-hay/");
      dtruyenListBook.value = list;
    } catch (e) {}
  }

  Future _getSearch() async {
    final list = await _gistRepository.getConfigSearch();

    if (list[0] is ListSearchTag) {
      tagSearch = list[0];
    }

    if (list[1] is ListSearchName) {
      nameSearch = list[1];
    }
  }

  Future _loadNews() async {
    newsListBook.value = await _newsRepository.fetchNews();
  }

  Future _getCategory() async {
    final websitesTag = await _gistRepository.getCategorySearch();
    if (websitesTag.isNotEmpty) {
      _dataRepository.tagWebsite = websitesTag as List<WebsiteTag>;
    }

    List<Tag> tag = [];
    if (websitesTag[0] is WebsiteTag) {
      tag.addAll(websitesTag[0].hotTag.tags);
      for (GroupTag item in websitesTag[0].tags) {
        tag.addAll(item.tags);
      }
    }
    tags.value = tag;
  }

  Future _getChannel() async {
    final channelResponse = await _gistRepository.getChannel();
    if (channelResponse is List<ChannelModel>) {
      channel.value = channelResponse;
    }
  }

  void selectTab(String tabName) {}

  int count(int n, int length) {
    if (length == 0) {
      return 6;
    }

    if (length % n == 0) {
      return length % n;
    } else {
      return (length % n) + 1;
    }
  }

  List<BookModel> dataFake() {
    return List.filled(
        7,
        BookModel(
          author: "",
          img: '',
          title: '',
          type: '',
          detail: '',
        ));
  }

  void loadMoreCategory(BuildContext context) {
    Util.navigateNamed(context, SearchView.name);
  }

  void openDtruyen(BookModel book, BuildContext? context) {
    if (context != null) {
      Util.navigateNamed(context, BookView.name, extra: book);
    }
  }

  void openDetail(BookModel book, BuildContext? context) {
    if (context != null) {
      if (book.type == Const.typePlayList) {
        Util.navigateNamed(context, DetailVideoYoutubeView.name, extra: book);
      } else if (book.type == Const.typeRSS) {
        Util.navigateNamed(context, BookView.name, extra: book);
      } else if (book.type == Const.typeText) {
        Util.navigateNamed(context, WebViewBookView.name, extra: book.id);
      }
    }
  }
}
