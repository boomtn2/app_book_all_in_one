import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const.dart';
import '../../core/utils/util.dart';
import '../../data/repository/html_repository.dart';
import '../book/views/book_view.dart';
import '../youtube/detail_video/view/detail_video_youtube_view.dart';

class LoadMoreController extends GetxController {
  RxList<BookModel> list = <BookModel>[].obs;
  bool isLoadMore = true;

  final HtmlRepository _htmlRepository = HtmlRepositoryImpl();
  LoadMoreController({required List<BookModel> books}) {
    list.value = books;
    if (books.isNotEmpty) {
      index = 2;
      if (books.first.type != Const.typeRSS) {
        isLoadMore = false;
      }
    } else {
      index = 1;
      loadMore();
      isLoadMore = false;
    }
  }

  int index = 1;

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

    List<BookModel> temp = [];
    final data = await _htmlRepository.dtruyenLoadMore(
        DataRepository.instance.urlDtruyen ?? '', index);

    index += 1;
    temp.addAll(list);
    temp.addAll(data);
    list.value = temp;

    isLoading = false;

    // Thực hiện yêu cầu tải dữ liệu
    // Sau khi tải xong, đặt lại isLoading = false;
  }

  void openDetail(BookModel book, BuildContext? context) {
    if (context != null) {
      if (book.type == Const.typePlayList) {
        Util.navigateNamed(context, DetailVideoYoutubeView.name, extra: book);
      } else {
        Util.navigateNamed(context, BookView.name, extra: book);
      }
    }
  }
}
