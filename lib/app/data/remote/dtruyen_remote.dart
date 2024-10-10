import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/data/model/models_export.dart';
import 'package:audio_youtube/app/data/service/html/html.dart';
import 'package:dio/dio.dart';
import '../model/book_model.dart';

abstract class DtruyenRemoteDataSource {
  Future<List<BookModel>> fetchListBook(String url);
  Future<(ChapterModel, BookModel)> fetchInfor(String url);
  Future<ChapterModel> fetchChapter(String url);
  Future<List<BookModel>> loadMoreListBook(String url, int index);
}

class DtruyenRemoteImpl extends BaseRemoteSource
    implements DtruyenRemoteDataSource {
  @override
  Future<ChapterModel> fetchChapter(String url) {
    var endpoint = url;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseChapter(response, url));
    } catch (e) {
      rethrow;
    }
  }

  ChapterModel _parseChapter(Response<dynamic> response, String url) {
    return HTMLHelper().getChapter(
        response: response,
        querryTextChapter: "#chapter-content",
        querryLinkNext: "a[title=\"Chương Sau\"]",
        querryLinkPre: "a[title=\"Chương Trước\"]",
        querryTitle: "h2.chapter-title",
        linkChapter: url,
        domain: "https://dtruyen.com/");
  }

  @override
  Future<List<BookModel>> fetchListBook(String url) {
    var endpoint = url;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBookResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  List<BookModel> _parseBookResponse(Response<dynamic> response) {
    return HTMLHelper().getListBookHtml(
        response: response,
        querryList: "ul li.story-list",
        queryText: "h3.title",
        queryAuthor: "p[itemprop=\"author\"]",
        queryview: "",
        queryScr: "img.cover",
        queryHref: "a.thumb",
        domain: "https://dtruyen.com/");
  }

  @override
  Future<(ChapterModel, BookModel)> fetchInfor(String url) {
    var endpoint = url;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _pareInfor(response));
    } catch (e) {
      rethrow;
    }
  }

  (ChapterModel, BookModel) _pareInfor(Response<dynamic> response) {
    HTMLHelper helper = HTMLHelper();
    final book = helper.getInforHtml(
        response: response,
        queryCategory: "p.story_categories",
        queryDetail: "div.description",
        queryStatus: "#story-detail > div.col1 > div.infos > p:nth-child(9)",
        queryText: "h3.title",
        queryAuthor: "p[itemprop=\"author\"]",
        queryview: "#story-detail > div.col1 > div.infos > p:nth-child(7)",
        queryScr: "img.cover",
        queryHref: "a.thumb",
        domain: "https://dtruyen.com/");
    final chapter = helper.getChapter(
        response: response,
        domain: "https://dtruyen.com/",
        linkChapter: '',
        querryLinkNext: "li.vip-0 a",
        querryLinkPre: "",
        querryTextChapter: "",
        querryTitle: "");
    return (chapter, book);
  }

  @override
  Future<List<BookModel>> loadMoreListBook(String url, int index) {
    var endpoint = "$url/$index/";
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBookResponse(response));
    } catch (e) {
      rethrow;
    }
  }
}
