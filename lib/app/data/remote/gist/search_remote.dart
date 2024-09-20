import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:dio/dio.dart';

import '../../model/search_website_model.dart';

abstract class SearchRemoteDataSoure {
  Future<List<dynamic>> fetchDataSearch();
}

class SearchRemoteDataSoureImpl extends BaseRemoteSource
    implements SearchRemoteDataSoure {
  final String _path =
      "https://gist.githubusercontent.com/boomtn2/c1e92c782aa73f3d38c020aae51eec89/raw/";
  @override
  Future<List> fetchDataSearch() async {
    var endpoint = _path;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseSearchResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  List<dynamic> _parseSearchResponse(Response<dynamic> response) {
    var json = jsonDecode(response.data);
    ListSearchTag instance = ListSearchTag.json(json);
    ListSearchName instanceName = ListSearchName.json(json);
    return [instance, instanceName];
  }
}
