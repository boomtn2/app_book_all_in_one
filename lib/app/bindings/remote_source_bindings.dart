import 'package:audio_youtube/app/data/remote/gist/category_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/channel_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/config_website_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/search_remote.dart';
import 'package:audio_youtube/app/data/remote/youtube/youtube_remote.dart';
import 'package:get/get.dart';

import '../data/remote/gist/rss_remote.dart';

class RemoteSourceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeRemoteDataSoure>(() => YoutubeRemoteDataSoureImpl(),
        tag: (YoutubeRemoteDataSoure).toString());
    Get.lazyPut<RSSRemoteDataSoure>(
      () => RSSRemoteDataSoureImpl(),
      tag: (RSSRemoteDataSoure).toString(),
    );
    Get.lazyPut<SearchRemoteDataSoure>(
      () => SearchRemoteDataSoureImpl(),
      tag: (SearchRemoteDataSoure).toString(),
    );
    Get.lazyPut<CategoryRemoteDataSoure>(
      () => CategoryRemoteDataSoureImpl(),
      tag: (CategoryRemoteDataSoure).toString(),
    );

    Get.lazyPut<ChannelRemoteDataSoure>(
      () => ChannelRemoteDataSoureImpl(),
      tag: (ChannelRemoteDataSoure).toString(),
    );

    Get.lazyPut<ConfigWebsiteRemoteDataSoure>(
      () => ConfigWebsiteRemoteDataSoureImpl(),
      tag: (ConfigWebsiteRemoteDataSoure).toString(),
    );
  }
}
