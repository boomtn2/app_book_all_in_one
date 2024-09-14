import 'package:audio_youtube/app/data/remote/gist/rss_remote.dart';
import 'package:get/get.dart';

import '../model/rss_model.dart';

abstract class GistRepository {
  Future<PodcastList> getRSS();
  Future<dynamic> getConfigWebsite();
  Future<dynamic> getConfigSearch();
  Future<dynamic> getTags();
}

class GistRepositoryImpl implements GistRepository {
  final RSSRemoteDataSoure _rssRemote =
      Get.find(tag: (RSSRemoteDataSoure).toString());

  @override
  Future getConfigSearch() {
    // TODO: implement getConfigSearch
    throw UnimplementedError();
  }

  @override
  Future getConfigWebsite() {
    // TODO: implement getConfigWebsite
    throw UnimplementedError();
  }

  @override
  Future<PodcastList> getRSS() {
    return _rssRemote.fetchDataRSS();
  }

  @override
  Future getTags() {
    // TODO: implement getTags
    throw UnimplementedError();
  }
}
