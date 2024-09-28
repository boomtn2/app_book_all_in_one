import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:audio_youtube/app/modules/youtube/detail_video/controller/detail_video_youtube_controller.dart';
import 'package:get/get.dart';

class DetailVideoYoutubeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailVideoYoutubeController>(
      () => DetailVideoYoutubeController(
          bookModel: DataRepository.instance.model),
    );
  }
}
