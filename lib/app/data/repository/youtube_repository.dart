import 'package:audio_youtube/app/core/values/app_values.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/remote/youtube/youtube_remote.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../model/youtube_search_response.dart';

abstract class YoutubeRepository {
  Future<List<BookModel>> search(String search);
  Future<List<BookModel>> searchIDPlaylist(String search);
  Future<List<BookModel>> searchIDChannel(String search);
  Future<Uri> getUriMp3(String id);
  Future<List<BookModel>> getVideosRelated(String id);
  Future<List<BookModel>> getChannelUpload(String id);
  Future<List<BookModel>> getPlayListChannel(String id);
  Future<List<BookModel>> getVideoPlayList(String id);
  Future<bool> downloadMp3(String id);
  void dispose();
}

extension FormatBookModel on BasePagedList<Video> {
  List<BookModel> getListBookModel() {
    List<BookModel> list = [];
    forEach(
      (p0) {
        list.add(BookModel(
            title: p0.title,
            author: p0.author,
            img: p0.thumbnails.mediumResUrl,
            type: '',
            snippet: Snippet(
                publishedAt: p0.publishDate,
                channelId: p0.channelId.value,
                title: p0.title,
                description: p0.description,
                thumbnails: Thumbnails(
                  thumbnailsDefault: Default(
                      url: p0.thumbnails.standardResUrl,
                      width: null,
                      height: null),
                  medium: Default(
                      url: p0.thumbnails.mediumResUrl,
                      width: null,
                      height: null),
                  high: Default(
                      url: p0.thumbnails.highResUrl, width: null, height: null),
                ),
                channelTitle: '',
                liveBroadcastContent: '',
                publishTime: p0.publishDate,
                resourceId:
                    ResourceId(kind: 'youtube#video', videoId: p0.id.value)),
            id: p0.id.value,
            detail: p0.description));
      },
    );
    return list;
  }
}

class YoutubeRepositoryImpl implements YoutubeRepository {
  YoutubeExplode youtubeExplode = YoutubeExplode();
  AudioOnlyStreamInfo? audio;

  YoutubeRemoteDataSoure remote =
      Get.find(tag: (YoutubeRemoteDataSoure).toString());
  late ExtraYoutubeRemoteDataSoure remoteExtra =
      YoutubeExplodeRemoteDataSoureImpl(youtubeExplode: youtubeExplode);

  @override
  Future<List<BookModel>> search(String search) async {
    final data = await remote.searchYoutubeVideo(search);
    return _adapterListModel(data);
  }

  List<BookModel> _adapterListModel(YoutubeSearchResponse response) {
    List<BookModel> list = [];

    for (var element in response.items) {
      list.add(BookModel(
          id: element.id?.videoId ?? element.id?.playlistId,
          title: element.snippet?.title ?? '',
          author: element.snippet?.channelTitle ?? '',
          img: element.snippet?.thumbnails?.thumbnailsDefault?.url ?? '',
          type: element.id?.kind ?? '',
          snippet: element.snippet));
    }
    return list;
  }

  @override
  Future<List<BookModel>> searchIDChannel(String search) async {
    final data = await remote.getPlayListChannel(search);
    return _adapterListModel(data);
  }

  @override
  Future<List<BookModel>> searchIDPlaylist(String search) async {
    final data = await remote.getPlayListChannel(search);
    return _adapterListModel(data);
  }

  @override
  Future<bool> downloadMp3(String id) async {
    audio ??= await remoteExtra.getInfoVideo(id);
    if (audio != null) {
      remoteExtra.downloadMp3(audio, "");
    }
    return false;
  }

  @override
  Future<Uri> getUriMp3(String id) async {
    audio = await remoteExtra.getInfoVideo(id);
    if (audio != null) {
      return remoteExtra.getUriMp3(audio!);
    } else {
      throw Error();
    }
  }

  @override
  Future<List<BookModel>> getVideosRelated(String id) async {
    final videos = await remoteExtra.getRelated(id);
    if (videos != null) {
      return videos.getListBookModel();
    } else {
      return [];
    }
  }

  @override
  void dispose() {
    youtubeExplode.close();
  }

  @override
  Future<List<BookModel>> getChannelUpload(String id) async {
    try {
      final data = await remoteExtra.getVideosChannelUpload(id, null, null);
      return data.getListBookModel();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<BookModel>> getPlayListChannel(String id) async {
    final data = await remoteExtra.getVideosChannelUpload(id, null, null);
    return data.getListBookModel();
  }

  @override
  Future<List<BookModel>> getVideoPlayList(String id) async {
    final _stream = remoteExtra.getVideosPlayList(id);
    final list = await _stream.toList();
    return _adapterListVideoToListBook(list);
  }

  List<BookModel> _adapterListVideoToListBook(List<Video> videos) {
    List<BookModel> books = [];
    for (var element in videos) {
      books.add(BookModel(
          id: element.id.value,
          title: element.title,
          author: '',
          img: element.thumbnails.lowResUrl,
          type: AppValues.typeVideoYoutube));
    }
    return books;
  }
}
