import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:dio/dio.dart';

import '../../repository/youtube_search_response.dart';
import 'youtube_search_param_model.dart';

abstract class YoutubeRemoteDataSoure {
  Future<YoutubeSearchResponse> searchYoutubeVideo(String search);
}

class YoutubeRemoteDataSoureImpl extends BaseRemoteSource
    implements YoutubeRemoteDataSoure {
  String path = "https://www.googleapis.com/youtube/v3";
  @override
  Future<YoutubeSearchResponse> searchYoutubeVideo(String search) {
    var endpoint = "$path/search/";
    final param = YoutubeSearchParamModel(q: search);
    print("${endpoint} : ${param.toJson()}");
    var dioCall = dioClient.get(endpoint, queryParameters: param.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseGithubProjectSearchResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  YoutubeSearchResponse _parseGithubProjectSearchResponse(
      Response<dynamic> response) {
    return YoutubeSearchResponse.fromJson(response.data);
  }
}
