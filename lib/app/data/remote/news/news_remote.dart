import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/core/const.dart';
import 'package:dio/dio.dart';

import '../../model/book_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<BookModel>> fetchNews();
}

class NewsRemoteDataSourceImpl extends BaseRemoteSource
    implements NewsRemoteDataSource {
  String api = "https://gw.vnexpress.net/ar/get_rule_2";
  @override
  Future<List<BookModel>> fetchNews() async {
    var endpoint = api;
    var dioCall = dioClient.get(endpoint, queryParameters: {
      "category_id": "1001014",
      "limit": "10",
      "page": "1",
      "data_select":
          "article_id,article_type,privacy,title,lead,share_url,thumbnail_url,new_privacy,publish_time,original_cate,article_category,myvne_token,off_thumb,iscomment,thumb_list",
      "exclude_id": "4799843,4799827,4800141,4333519,4799846,4799846",
      "thumb_size": "490x294",
      "thumb_quality": "100",
      "thumb_dpr": "1,2",
      "thumb_fit": "crop"
    });

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
    final dataList = json["data"]["1001014"]["data"] as List;
    for (var element in dataList) {
      list.add(BookModel(
          id: element["share_url"],
          title: element["title"] ?? '',
          author: "",
          img: element["thumbnail_url"] ?? "",
          type: Const.typeText));
    }

    return list;
  }
}

class News {}
