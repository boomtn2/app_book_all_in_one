import 'dart:io';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/data/remote/youtube/youtube_playlist_param_model.dart';
import 'package:dio/dio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../model/youtube_search_response.dart';
import 'youtube_search_param_model.dart';

abstract class YoutubeRemoteDataSoure {
  Future<YoutubeSearchResponse> searchYoutubeVideo(String search);
  Future<YoutubeSearchResponse> getVideoPlayList(String idPlayList);
  Future<YoutubeSearchResponse> getPlayListChannel(String idChannel);
}

abstract class ExtraYoutubeRemoteDataSoure {
  Future<Video> getDetailVideo(String id);
  Future<ChannelUploadsList> getVideosChannelUpload(
      String id, VideoSorting? sort, VideoType? type);
  Future<Playlist> getDetailPlayList(String idPlaylist);
  Stream<Video> getVideosPlayList(String id);
  Future<Uri> getUriMp3(AudioOnlyStreamInfo info);
  Future<AudioOnlyStreamInfo> getInfoVideo(String id);
  Future<RelatedVideosList?> getRelated(String id);
  Future<bool> downloadMp3(AudioOnlyStreamInfo? streamInfo, String filePath);
  Future<VideoSearchList> searchVideo({required String search});
  Future<VideoSearchList> searchPlaylist({required String search});
  Future<VideoSearchList> searchChannel({required String search});
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

class YoutubeExplodeRemoteDataSoureImpl extends BaseRemoteSource
    implements ExtraYoutubeRemoteDataSoure {
  final YoutubeExplode youtubeExplode;

  YoutubeExplodeRemoteDataSoureImpl({required this.youtubeExplode});
  @override
  Future<Playlist> getDetailPlayList(String idPlaylist) async {
    var playlist = await youtubeExplode.playlists.get(idPlaylist);
    return playlist;
  }

  @override
  Future<Video> getDetailVideo(String id) {
    return youtubeExplode.videos.get(id);
  }

  @override
  Future<Uri> getUriMp3(AudioOnlyStreamInfo info) async {
    return info.url;
  }

  @override
  Future<ChannelUploadsList> getVideosChannelUpload(
      String id, VideoSorting? sort, VideoType? type) async {
    return youtubeExplode.channels.getUploadsFromPage(id);
  }

  @override
  Stream<Video> getVideosPlayList(String id) {
    return youtubeExplode.playlists.getVideos(id);
  }

  @override
  Future<bool> downloadMp3(
      AudioOnlyStreamInfo? streamInfo, String filePath) async {
    if (streamInfo != null) {
      // Get the actual stream
      var stream = youtubeExplode.videos.streams.get(streamInfo);

      // Open a file for writing.
      var file = File(filePath);
      var fileStream = file.openWrite();

      // Pipe all the content of the stream into the file.
      await stream.pipe(fileStream);

      // Close the file.
      await fileStream.flush();
      await fileStream.close();
    }

    return false;
  }

  @override
  Future<AudioOnlyStreamInfo> getInfoVideo(String id) async {
    var manifest = await youtubeExplode.videos.streamsClient.getManifest(id);

    var streamInfo = manifest.audioOnly.withHighestBitrate();
    return streamInfo;
  }

  @override
  Future<VideoSearchList> searchChannel({required String search}) {
    return youtubeExplode.search.search(search, filter: TypeFilters.channel);
  }

  @override
  Future<VideoSearchList> searchPlaylist({required String search}) {
    return youtubeExplode.search.search(search, filter: TypeFilters.playlist);
  }

  @override
  Future<VideoSearchList> searchVideo({required String search}) {
    return youtubeExplode.search.search(search);
  }

  @override
  Future<RelatedVideosList?> getRelated(String id) async {
    var video = await youtubeExplode.videos.get(id);
    return youtubeExplode.videos.getRelatedVideos(video);
  }
}
