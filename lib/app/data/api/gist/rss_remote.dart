import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/data/model/rss_model.dart';
import 'package:dio/dio.dart';

abstract class RSSRemoteDataSoure {
  Future<PodcastList> fetchDataRSS();
}

class RSSRemoteDataSoureImpl extends BaseRemoteSource
    implements RSSRemoteDataSoure {
  final String _path =
      'https://gist.githubusercontent.com/boomtn2/f8ff9d6d8c9d3b2904dde93afdbcb395/raw';
  @override
  Future<PodcastList> fetchDataRSS() {
    var endpoint = _path;

    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseGithubProjectSearchResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  PodcastList _parseGithubProjectSearchResponse(Response<dynamic> response) {
    String data = response.data;
    final json = jsonDecode(data);

    return PodcastList.fromJson(json);
  }
}
