import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/model/postcard_vnexpress/intro_postcard_model.dart';
import 'package:audio_youtube/app/data/remote/news/news_remote.dart';

abstract class NewsRepository {
  Future<List<BookModel>> fetchPostCardArticleIds(
      String url, int limit, int offset);
  Future<List<BookModel>> fetchPostCardMp3(List<String> articleIds);
  Future<List<BookModel>> fetchIntroPostCard();
}

class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSource newsRemote = NewsRemoteDataSourceImpl();
  @override
  Future<List<BookModel>> fetchPostCardArticleIds(
      String url, int limit, int offset) {
    return newsRemote.fetchPostCardArticleIds(url, limit, offset);
  }

  @override
  Future<List<BookModel>> fetchIntroPostCard() async {
    final list = await newsRemote.fetchIntroPostCard();
    return _adapterListBookModel(list);
  }

  List<BookModel> _adapterListBookModel(List<IntroPostCard> intros) {
    List<BookModel> books = [];
    for (var element in intros) {
      books.add(BookModel(
          title: element.tile,
          author: "",
          img: element.thumb,
          id: element.url,
          type: Const.typePlayListPostCastVnExpress));
    }
    return books;
  }

  @override
  Future<List<BookModel>> fetchPostCardMp3(List<String> articleIds) async {
    return newsRemote.fetchPostCard(articleIds);
  }
}
