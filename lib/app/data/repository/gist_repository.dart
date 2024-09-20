import 'package:audio_youtube/app/data/remote/gist/category_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/channel_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/config_website_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/rss_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/search_remote.dart';
import 'package:get/get.dart';

import '../model/config_website.dart';
import '../model/rss_model.dart';

abstract class GistRepository {
  Future<PodcastList> getRSS();
  Future<ConfigWebsiteModel> getConfigWebsite();
  Future<List<dynamic>> getConfigSearch();
  Future<List<dynamic>> getCategorySearch();
  Future<List<dynamic>> getChannel();
}

class GistRepositoryImpl implements GistRepository {
  final RSSRemoteDataSoure _rssRemote =
      Get.find(tag: (RSSRemoteDataSoure).toString());
  final SearchRemoteDataSoure _searchRemote =
      Get.find(tag: (SearchRemoteDataSoure).toString());

  final CategoryRemoteDataSoure _categoryRemote =
      Get.find(tag: (CategoryRemoteDataSoure).toString());

  final ChannelRemoteDataSoure _channelRemote =
      Get.find(tag: (ChannelRemoteDataSoure).toString());

  final ConfigWebsiteRemoteDataSoure _configWebsiteRemote =
      Get.find(tag: (ConfigWebsiteRemoteDataSoure).toString());

      
  @override
  Future<List> getConfigSearch() async {
    return _searchRemote.fetchDataSearch();
  }

  @override
  Future<ConfigWebsiteModel> getConfigWebsite() {
    return _configWebsiteRemote.fetchDataConfig();
  }

  @override
  Future<PodcastList> getRSS() {
    return _rssRemote.fetchDataRSS();
  }

  @override
  Future<List> getCategorySearch() {
    return _categoryRemote.fetchDataSearch();
  }

  @override
  Future<List> getChannel() {
    return _channelRemote.fetchDataChannel();
  }
}
