import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/data/remote/news/models/news_postcard_param_model.dart';
import 'package:dio/dio.dart';
import '../../model/book_model.dart';
import '../../model/postcard_vnexpress/intro_postcard_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<BookModel>> fetchPostCard(List<String> articleIds);
  Future<List<BookModel>> fetchPostCardArticleIds(
      String url, int limit, int offset);
  Future<List<IntroPostCard>> fetchIntroPostCard();
}

class NewsRemoteDataSourceImpl extends BaseRemoteSource
    implements NewsRemoteDataSource {
  @override
  Future<List<BookModel>> fetchPostCard(List<String> articleIds) async {
    var endpoint = NewsPostCardModel.domain;
    var dioCall = dioClient.get(endpoint,
        queryParameters: NewsPostCardModel.getPostCard(articleIds));

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBookResponse(response));
    } catch (e) {
      return [];
    }
  }

  List<BookModel> _parseBookResponse(Response<dynamic> response) {
    final json = response.data;
    List<BookModel> list = [];
    final dataList = json["data"] as List;
    for (var element in dataList) {
      list.add(BookModel(
          id: element["podcast"]["path"],
          title: element["title"] ?? '',
          author: "",
          img: element["thumbnail_url"] ?? "",
          type: Const.typeMP3));
    }

    return list;
  }

  List<BookModel> _parseBookArticleIdsResponse(Response<dynamic> response) {
    final json = jsonDecode(response.data);
    List<BookModel> list = [];
    final itemJson = json["data"] as Map;
    final dataList = itemJson.entries.first.value["data"] as List;
    for (var element in dataList) {
      list.add(BookModel(
          id: "${element["article_id"]}",
          title: element["title"] ?? '',
          author: element["publish_time_format"] ?? '',
          img: element["thumbnail_url"] ?? "",
          type: Const.typePlayList,
          detail: element["lead"]));
    }

    return list;
  }

  @override
  Future<List<BookModel>> fetchPostCardArticleIds(
      String url, int limit, int offset) async {
    var endpoint = "$url/limit/$limit/offset/$offset";
    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBookArticleIdsResponse(response));
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<IntroPostCard>> fetchIntroPostCard() async {
    final list = jsonDecode(dataIntroPostCardJson) as List;
    List<IntroPostCard> listPostCard = [];
    for (var item in list) {
      listPostCard.add(IntroPostCard.json(item));
    }

    return listPostCard;
  }
}
