import 'package:audio_youtube/app/core/const.dart';
import 'package:audio_youtube/app/data/repository/player_youtube_repository.dart';
import 'package:audio_youtube/app/data/repository/youtube_search_response.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../data/api/youtube/youtube_remote.dart';
import '../../../data/model/book_model.dart';

class PlayerYoutubeController extends GetxController {
  Rx<BookModel?> video = BookModel(
          title: 'Chưa có dữ liệu',
          author: 'Chưa có dữ liệu',
          img: '',
          type: '')
      .obs;
  RxList<BookModel> playList = <BookModel>[].obs;
  BookModel? inforPlayList;

  YoutubeSearchResponse? response;
  RxBool hideVideoPlayer = true.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    hideVideoPlayer.close();
    playList.close();
    video.close();
    super.onClose();
  }

  void _getArgument() {}

  Future getListVideo() async {
    if (inforPlayList?.type.contains(Const.typePlayList) == true) {
      response = await YoutubeRemoteDataSoureImpl()
          .getVideoPlayList(inforPlayList?.id ?? '');
      List<BookModel> list = [];
      playList.clear();
      response?.items.forEach((element) {
        final book = BookModel(
            title: element.snippet?.title ?? '',
            author: element.snippet?.channelTitle ?? '',
            img: element.snippet?.thumbnails?.thumbnailsDefault?.url ?? '',
            id: element.id?.videoId ?? element.id?.playlistId,
            type: element.id?.kind ?? '',
            snippet: element.snippet,
            detail: element.snippet?.description);
        list.add(book);
      });

      playList.value = list;
      video.value = playList.first;
    } else if (inforPlayList?.type.contains(Const.typeVideo) == true) {
      response = await YoutubeRemoteDataSoureImpl()
          .getPlayListChannel(inforPlayList?.snippet?.channelId ?? '');
      List<BookModel> list = [];
      playList.clear();
      response?.items.forEach((element) {
        final book = BookModel(
            title: element.snippet?.title ?? '',
            author: element.snippet?.channelTitle ?? '',
            img: element.snippet?.thumbnails?.thumbnailsDefault?.url ?? '',
            id: element.id?.videoId ?? element.id?.playlistId,
            type: element.id?.kind ?? '',
            snippet: element.snippet,
            detail: element.snippet?.description);
        list.add(book);
      });

      playList.value = list;
      video.value = inforPlayList;
    }
  }

  void hideViewPlayer() {
    hideVideoPlayer.value = true;
  }

  void showViewPlayer() {
    hideVideoPlayer.value = false;
  }

  void playVideo(BookModel book) {
    video.value = book;
    if (book.id == null) {
    } else {
      PlayerYoutubeRepository.instance.loadVideoID(book.id ?? '');
    }
  }
}
