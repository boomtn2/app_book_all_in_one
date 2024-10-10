import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/gen/assets.gen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../model/models_export.dart';

abstract class ConfigWebsiteRemoteDataSoure {
  Future<ConfigWebsiteModel> fetchDataConfig();
}

class ConfigWebsiteRemoteDataSoureImpl extends BaseRemoteSource
    implements ConfigWebsiteRemoteDataSoure {
  final String _path =
      'https://gist.githubusercontent.com/boomtn2/51be0f26b418c4eb949c1abe12acdd55/raw/';

  @override
  Future<ConfigWebsiteModel> fetchDataConfig() async {
    var endpoint = _path;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseConfigWebsiteResponse(response));
    } catch (e) {
      final String response =
          await rootBundle.loadString(Assets.jsons.defaultConfigWebsite);
      final json = jsonDecode(response);
      return ConfigWebsiteModel.fromJson(json);
    }
  }

  ConfigWebsiteModel _parseConfigWebsiteResponse(Response<dynamic> response) {
    String data = response.data;
    final json = jsonDecode(data);

    return ConfigWebsiteModel.fromJson(json);
  }
}
