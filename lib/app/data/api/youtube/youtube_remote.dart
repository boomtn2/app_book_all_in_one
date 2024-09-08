import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/data/api/youtube/youtube_playlist_param_model.dart';
import 'package:dio/dio.dart';

import '../../repository/youtube_search_response.dart';
import 'youtube_search_param_model.dart';

abstract class YoutubeRemoteDataSoure {
  Future<YoutubeSearchResponse> searchYoutubeVideo(String search);
  Future<YoutubeSearchResponse> getVideoPlayList(String idPlayList);
  Future<YoutubeSearchResponse> getPlayListChannel(String idChannel);
}

class YoutubeRemoteDataSoureImpl extends BaseRemoteSource
    implements YoutubeRemoteDataSoure {
  String path = "https://www.googleapis.com/youtube/v3";
  @override
  Future<YoutubeSearchResponse> searchYoutubeVideo(String search) {
    var endpoint = "$path/search/";
    final param = YoutubeSearchParamModel(q: search, type: 'playlist');
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

  @override
  Future<YoutubeSearchResponse> getVideoPlayList(String idPlayList) {
    var endpoint = "$path/playlistItems/";
    final param = YoutubePlaylistParamModel(playlistId: idPlayList);
    var dioCall = dioClient.get(endpoint, queryParameters: param.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseGithubProjectSearchResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<YoutubeSearchResponse> getPlayListChannel(String idChannel) {
    var endpoint = "$path/search/";
    final param = YoutubeSearchParamModel(
      q: null,
      channelId: idChannel,
    );
    var dioCall = dioClient.get(endpoint, queryParameters: param.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseGithubProjectSearchResponse(response));
    } catch (e) {
      rethrow;
    }
  }
}
