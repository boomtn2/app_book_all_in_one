//https://gist.githubusercontent.com/boomtn2/678708f2d2e45922b4bf30b4541dd8ed/raw/

import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../../../gen/assets.gen.dart';
import '../../model/category_model.dart';

abstract class CategoryRemoteDataSoure {
  Future<List<dynamic>> fetchDataSearch();
  Future<String> fetchDataToJson();
  Future<List<dynamic>> fetchAssets();
  Future<String> jsonAssets();
}

class CategoryRemoteDataSoureImpl extends BaseRemoteSource
    implements CategoryRemoteDataSoure {
  final String _path =
      "https://gist.githubusercontent.com/boomtn2/678708f2d2e45922b4bf30b4541dd8ed/raw/";
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
    List<WebsiteTag> list = [];
    for (var item in json['tags']) {
      list.add(WebsiteTag.json(item));
    }
    return list;
  }

  @override
  Future<List> fetchAssets() async {
    try {
      final String response =
          await rootBundle.loadString(Assets.jsons.defaultCategory);
      var json = jsonDecode(response);
      List<WebsiteTag> list = [];
      for (var item in json['tags']) {
        list.add(WebsiteTag.json(item));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> fetchDataToJson() {
    var endpoint = _path;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall).then((response) => response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> jsonAssets() async {
    final String response =
        await rootBundle.loadString(Assets.jsons.defaultCategory);
    return response;
  }
}
