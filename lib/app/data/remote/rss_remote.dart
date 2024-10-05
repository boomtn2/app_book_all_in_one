import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/core/const.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:dio/dio.dart';

import '../model/book_model.dart';

abstract class RssRemoteDataSoucre {
  Future<List<BookModel>> getPlayList(String url);
}

class RssRemoteIpl extends BaseRemoteSource implements RssRemoteDataSoucre {
  @override
  Future<List<BookModel>> getPlayList(String url) {
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
    List<BookModel> list = [];
    var rssFeed = RssFeed.parse(response.data);
    for (var element in rssFeed.items) {
      list.add(BookModel(
          img: element.itunes?.image?.href ?? '',
          id: element.enclosure!.url,
          author: '',
          title: element.title ?? '',
          type: Const.typeRSS,
          detail: rssFeed.description,
          snippet: null));
    }

    return list;
  }
}
