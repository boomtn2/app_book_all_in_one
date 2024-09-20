import 'package:audio_youtube/app/data/repository/gist_repository.dart';
import 'package:audio_youtube/app/data/repository/youtube_repository.dart';
import 'package:get/get.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeRepository>(
      () => YoutubeRepositoryImpl(),
      tag: (YoutubeRepository).toString(),
    );
    Get.lazyPut<GistRepository>(
      () => GistRepositoryImpl(),
      tag: (GistRepository).toString(),
    );
  }
}
