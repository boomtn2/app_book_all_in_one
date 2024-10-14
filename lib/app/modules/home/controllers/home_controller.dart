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
import 'package:audio_youtube/app/modules/loadmore/loadmore_view.dart';
import 'package:audio_youtube/app/modules/post_card/post_card_view.dart';
import 'package:audio_youtube/app/modules/search/views/search_view.dart';
import 'package:audio_youtube/app/modules/webview/views/webview_book_view.dart';
import 'package:audio_youtube/app/modules/youtube/channel/view/channel_youtube_view.dart';
import 'package:audio_youtube/app/modules/youtube/detail_video/view/detail_video_youtube_view.dart';
import 'package:audio_youtube/app/modules/youtube/loadmore/view/channel_youtube_view.dart';
import 'package:audio_youtube/app/modules/youtube/playlist_channels/playlist_channels_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../data/model/models_export.dart';
import '../../../data/remote/youtube/param_models/youtube_search_param_model.dart';

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

  // RxBool isCategoryLoading = true.obs;
  // RxBool isHotLoading = true.obs;
  // RxBool isChannelLoading = true.obs;
  RxBool isRSSLoading = true.obs;
  // RxBool isDtruyenLoading = true.obs;

  RxBool isLoadingDataSystem = true.obs;

  YoutubeSearchParamModel? _youtubeSearchParamModel;

  @override
  void onInit() async {
    debugPrint("[onInit] [HomeController]");
    super.onInit();
    await _loadNews();
    await Future.delayed(const Duration(seconds: 1));
    await _loadDtruyen();
    await Future.delayed(const Duration(seconds: 1));
    await _loadRSS();
    await Future.delayed(const Duration(seconds: 1));
    await _loadHotSearchYoutube();
    await _getChannel();

    isLoadingDataSystem.value = false;
  }

  @override
  void onClose() {
    _ytbRepository.dispose();
    videoYoutube.clear();
    super.onClose();
  }

  Future _loadHotSearchYoutube() async {
    try {
      final response = await _ytbRepository.search('Thập niên 70');
      videoYoutube.value = response;
      _youtubeSearchParamModel = await _ytbRepository.getParamSearchModel();
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
      showErrorMessage('Tải dữ liệu chọn lọc thất bại!');
    }
  }

  Future _loadDtruyen() async {
    try {
      String path = "https://dtruyen.net/truyen-nu-cuong-hay/";
      DataRepository.instance.urlDtruyen = path;
      final list = await _htmlRepository.dtruyenFetchListBook(path);
      dtruyenListBook.value = list;
    } catch (e) {
      showErrorMessage("Tải dữ liệU truyện dịch việt thất bại!");
    }
  }

  Future _loadNews() async {
    try {
      newsListBook.value = await _newsRepository.fetchIntroPostCard();
    } catch (e) {
      showErrorMessage("Tải tin tức thất bại!");
    }
  }

  Future _getChannel() async {
    try {
      final channelResponse = await _gistRepository.getChannel();
      if (channelResponse is List<ChannelModel>) {
        channel.value = channelResponse;
      }
    } catch (e) {
      showErrorMessage("Tải dữ liệu kênh thất bại!");
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

  void openLoadMore(List<BookModel> list, BuildContext context, {String? url}) {
    DataRepository.instance.urlDtruyen =
        url ?? "https://dtruyen.net/truyen-nu-cuong-hay/";
    Util.navigateNamed(context, LoadMoreView.name, extra: list);
  }

  void openLoadMoreYoutube(List<BookModel> list, BuildContext context) {
    DataRepository.instance.youtubeSearchParamModel = _youtubeSearchParamModel;
    Util.navigateNamed(context, LoadMorePlayListYoutubeView.name, extra: list);
  }

  void openChannel(BuildContext context, ChannelModel channel) {
    Util.navigateNamed(context, ChannelYoutubeView.name, extra: channel);
  }

  void openAllChannel(BuildContext context) {
    Util.navigateNamed(context, PlaylistChannelsView.name, extra: channel);
  }

  void openPlayListPostCard(BuildContext context, BookModel book) {
    Util.navigateNamed(context, PostCardView.name, extra: book);
  }
}
