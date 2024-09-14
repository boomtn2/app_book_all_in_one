import 'package:audio_youtube/app/data/remote/youtube/youtube_remote.dart';
import 'package:get/get.dart';

class RemoteSourceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeRemoteDataSoure>(() => YoutubeRemoteDataSoureImpl(),
        tag: (YoutubeRemoteDataSoure).toString());
  }
}
