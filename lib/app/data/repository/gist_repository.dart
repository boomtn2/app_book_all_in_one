import 'package:audio_youtube/app/data/model/models_export.dart';
import 'package:audio_youtube/app/data/remote/gist/category_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/channel_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/config_website_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/rss_remote.dart';
import 'package:audio_youtube/app/data/remote/gist/search_remote.dart';
import 'package:audio_youtube/app/data/repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../local/preference/preference_manager.dart';
import '../local/preference/preference_manager_impl.dart';
import '../model/rss_model.dart';

abstract class GistRepository {
  Future<PodcastList> getRSS();
  Future downloadConfigWebsite();
  Future downloadConfigSearch();
  Future downloadCategory();
  Future<ConfigWebsite?> getConfigWebsite(String id);
  Future<ConfigWebsiteModel> getListNameConfigWebsite();
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
  final DatabaseRepository _dataBaseRepository = DataBaseRepositoryImpl();
  final PreferenceManager _dbSharePreferen = PreferenceManagerImpl();

  static const String keyStateConfigWebsite = 'ConfigWebsite';
  static const String keyStateConfigSearch = 'keyStateConfigSearch';
  static const String keyStateCategory = 'keyStateCategory';

  @override
  Future<List> getConfigSearch() async {
    return _searchRemote.fetchDataSearch();
  }

  @override
  Future downloadConfigWebsite() async {
    try {
      bool state = await isSystemConfigurationStored(keyStateConfigWebsite);
      if (state == false) {
        final data = await _configWebsiteRemote.fetchDataConfig();
        _insertDBConfigWebsiteModel(data);
      }
      await setStateSystemConfigurationStored(keyStateConfigWebsite, true);
    } catch (e) {
      debugPrint("[ERROR] [downloadConfigWebsite] $e");
    }
  }

  @override
  Future<ConfigWebsite?> getConfigWebsite(String id) async {
    try {
      ConfigWebsite? data = await _dataBaseRepository.getConfigWebsite(id);
      if (data != null) {
        return data;
      } else {
        ConfigWebsiteModel data =
            await _configWebsiteRemote.fetchDataConfigToAssets();
        for (var element in data.configWebsite) {
          if (element.id.contains(id)) {
            return element;
          }
        }

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ConfigWebsiteModel> getListNameConfigWebsite() async {
    try {
      final list = await _dataBaseRepository.getAllConfigWebsite();
      if (list.isNotEmpty) {
        return ConfigWebsiteModel(configWebsite: list);
      } else {
        return _configWebsiteRemote.fetchDataConfigToAssets();
      }
    } catch (e) {
      return _configWebsiteRemote.fetchDataConfigToAssets();
    }
  }

  void _insertDBConfigWebsiteModel(ConfigWebsiteModel data) {
    for (var element in data.configWebsite) {
      _dataBaseRepository.insertConfigWebsite(element);
    }
  }

  Future<bool> isSystemConfigurationStored(String key) async {
    return _dbSharePreferen.getBool(key);
  }

  Future<bool> setStateSystemConfigurationStored(String key, bool state) async {
    return _dbSharePreferen.setBool(key, state);
  }

  @override
  Future<PodcastList> getRSS() {
    return _rssRemote.fetchDataRSS();
  }

  @override
  Future<List> getCategorySearch() async {
    return [];
  }

  void _insertDBCategory(String json) {
    _dataBaseRepository.insertCatregory(json);
  }

  @override
  Future<List> getChannel() {
    return _channelRemote.fetchDataChannel();
  }

  @override
  Future downloadCategory() async {
    try {
      bool state = await isSystemConfigurationStored(keyStateCategory);
      if (state == false) {
        final data = await _categoryRemote.fetchDataToJson();

        _insertDBCategory(data);
      }
      await setStateSystemConfigurationStored(keyStateCategory, true);
    } catch (e) {
      final st = await _categoryRemote.jsonAssets();
      _insertDBCategory(st);
      debugPrint("[ERROR] [downloadConfigWebsite] $e");
    }
  }

  @override
  Future downloadConfigSearch() async {
    try {
      bool state = await isSystemConfigurationStored(keyStateConfigSearch);
      if (state == false) {
        final data = await _searchRemote.fetchDataSearch();
        ListSearchName listSearchName = data[1];
        for (var element in listSearchName.listSearchName) {
          _dataBaseRepository.insertSearchName(element);
        }

        ListSearchTag listSearchTag = data[0];
        for (var element in listSearchTag.listSearchTag) {
          _dataBaseRepository.insertSearchTag(element);
        }
      }
      await setStateSystemConfigurationStored(keyStateConfigSearch, true);
    } catch (e) {
      debugPrint("[ERROR] [downloadConfigSearch] $e");
    }
  }
}
