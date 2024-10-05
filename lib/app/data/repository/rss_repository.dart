import '../model/book_model.dart';
import '../remote/rss_remote.dart';

abstract class RssRepository {
  Future<List<BookModel>> getPlayList(String url);
}

class RssRepositoryIml implements RssRepository {
  RssRemoteDataSoucre rss = RssRemoteIpl();
  @override
  Future<List<BookModel>> getPlayList(String url) {
    return rss.getPlayList(url);
  }
}
