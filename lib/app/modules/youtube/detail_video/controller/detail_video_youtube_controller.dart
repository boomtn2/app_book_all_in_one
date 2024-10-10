import 'package:audio_service/audio_service.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:audio_youtube/app/data/service/audio/custom_audio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repository/youtube_repository.dart';

class DetailVideoYoutubeController extends GetxController {
  late final BookModel? bookModel;

  DetailVideoYoutubeController({required this.bookModel}) {
    init();
  }

  final YoutubeRepository _ytbRepository =
      Get.find(tag: (YoutubeRepository).toString());

  RxList<BookModel> videosPlaylist = <BookModel>[].obs;
  RxList<BookModel> videoChannelUpload = <BookModel>[].obs;
  RxList<BookModel> getVideosRelated = <BookModel>[].obs;

  bool showGetMp3 = false;
  BuildContext? context;

  void init() async {
    final data = await _ytbRepository.getVideoPlayList(bookModel?.id ?? '');

    videosPlaylist.value = data;

    final channel = await _ytbRepository
        .getChannelUpload(bookModel?.snippet?.channelId ?? '');

    videoChannelUpload.value = channel;

    final related = await _ytbRepository.getVideosRelated(bookModel?.id ?? '');

    getVideosRelated.value = related;
  }

  void getMp3(BookModel model) async {
    debugPrint('getMp3');
    showDialogLoadMp3();
    final uri = await _ytbRepository.getUriMp3(model.id ?? '');
    debugPrint('getMp3 url$uri');
    await setMedia(uri.toString(), model.title);
    closeDialod();
    SingletonAudiohanle.instance.audioHandler?.play();
  }

  void closeDialod() {
    if (context != null && showGetMp3) {
      Navigator.of(context!).pop();
    }
  }

  void showDialogLoadMp3() {
    if (context != null) {
      showDialog(
        context: context!,
        builder: (context) => AlertDialog(
          titleTextStyle: titleStyle,
          contentTextStyle: afaca,
          title: const Text('Đang lấy dữ liệu'),
          content: SizedBox(
              height: 80,
              child: Column(
                children: [
                  const     Expanded(child:  Loading()),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red)),
                      onPressed: () {
                        Dio().close();
                      },
                      child: const Text('Huỷ'))
                ],
              )),
        ),
      );
    }
  }

  Future setMedia(String mp3, String title) async {
    await SingletonAudiohanle.instance.changeChannelAudio(KeyChangeAudio.mp3);
    await SingletonAudiohanle.instance.audioHandler?.updateQueue([
      MediaItem(id: mp3, title: title, artUri: Uri.parse(bookModel?.img ?? ''))
    ]);
  }
}
