import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/remote/news/news_remote.dart';

abstract class NewsRepository {
  Future<List<BookModel>> fetchNews();
}

class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSource newsRepository = NewsRemoteDataSourceImpl();
  @override
  Future<List<BookModel>> fetchNews() {
    return newsRepository.fetchNews();
  }
}
