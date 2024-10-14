import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/models_export.dart';
import '../../data/repository/news_repository.dart';

class PostCardController extends GetxController {
  final BookModel introPostCard;
  RxList<BookModel> playList = <BookModel>[].obs;
  List<BookModel> playListMp3 = <BookModel>[];

  int offset = 0;

  final NewsRepository _newsRepository = NewsRepositoryImpl();

  PostCardController({required this.introPostCard});

  @override
  void onReady() {
    fetchPlayList();
    super.onReady();
  }

  void fetchPlayList() async {
    await SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.mp3);
    playList.value = await _newsRepository.fetchPostCardArticleIds(
        introPostCard.id ?? '', 30, offset);
    fetchMp3();
  }

  Future fetchMp3() async {
    List<String> ids = playList
        .getRange(offset, playList.length)
        .map((model) => model.id ?? '')
        .toList();

    playListMp3.addAll(await _newsRepository.fetchPostCardMp3(ids));
  }

  void addQueue(int index) {
    try {
      SingletonAudiohanle.instance.audioHandler
          ?.addQueueItem(getMediaItem(playListMp3[index]));
    } catch (e) {
      debugPrint("Debug $e");
    }
  }

  MediaItem getMediaItem(BookModel book) {
    return MediaItem(
        id: book.id ?? '',
        title: book.title,
        artUri: Uri.parse(book.img),
        extras: {
          "album": introPostCard.title,
          "path": introPostCard.id,
          "chapter": book.title,
          "type": introPostCard.type
        });
  }

  void addALLQueues() {
    List<MediaItem> items = [];
    for (var element in playListMp3) {
      items.add(getMediaItem(element));
    }
    SingletonAudiohanle.instance.audioHandler?.updateQueue(items);
  }
}
