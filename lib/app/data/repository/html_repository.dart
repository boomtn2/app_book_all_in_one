import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/remote/dtruyen_remote.dart';

abstract class HtmlRepository {
  Future<List<BookModel>> dtruyenFetchListBook(String url);
  Future<(ChapterModel, BookModel)> dtruyenFetchInforBook(String url);
  Future<ChapterModel> dtruyenFetchChapter(String url);
  Future<List<BookModel>> dtruyenLoadMore(String url, int index);
}

class HtmlRepositoryImpl implements HtmlRepository {
  DtruyenRemoteDataSource dtruyen = DtruyenRemoteImpl();
  @override
  Future<List<BookModel>> dtruyenFetchListBook(String url) {
    return dtruyen.fetchListBook(url);
  }

  @override
  Future<(ChapterModel, BookModel)> dtruyenFetchInforBook(String url) {
    return dtruyen.fetchInfor(url);
  }

  @override
  Future<ChapterModel> dtruyenFetchChapter(String url) {
    return dtruyen.fetchChapter(url);
  }

  @override
  Future<List<BookModel>> dtruyenLoadMore(String url, int index) {
    return dtruyen.loadMoreListBook(url, index);
  }
}
