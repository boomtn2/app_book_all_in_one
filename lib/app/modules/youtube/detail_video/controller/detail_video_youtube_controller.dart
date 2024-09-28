import 'package:audio_youtube/app/data/model/book_model.dart';
import 'package:get/get.dart';

import '../../../../data/repository/youtube_repository.dart';

class DetailVideoYoutubeController extends GetxController {
  final BookModel? bookModel;

  DetailVideoYoutubeController({required this.bookModel});

  final YoutubeRepository _ytbRepository =
      Get.find(tag: (YoutubeRepository).toString());

  RxList<BookModel> videosPlaylist = <BookModel>[].obs;
  RxList<BookModel> videoChannelUpload = <BookModel>[].obs;
  RxList<BookModel> getVideosRelated = <BookModel>[].obs;

  void init() async {
    final data = await _ytbRepository.getVideoPlayList(bookModel?.id ?? '');

    videosPlaylist.value = data;

    final channel = await _ytbRepository
        .getChannelUpload(bookModel?.snippet?.channelId ?? '');

    videoChannelUpload.value = channel;

    final related = await _ytbRepository.getVideosRelated(bookModel?.id ?? '');

    getVideosRelated.value = related;
  }
}
