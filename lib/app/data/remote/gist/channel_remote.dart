import 'dart:convert';

import 'package:audio_youtube/app/core/base/base_remote_source.dart';
import 'package:audio_youtube/app/data/model/channel_model.dart';
import 'package:dio/dio.dart';

abstract class ChannelRemoteDataSoure {
  Future<List<dynamic>> fetchDataChannel();
}

class ChannelRemoteDataSoureImpl extends BaseRemoteSource
    implements ChannelRemoteDataSoure {
  final String _path =
      "https://gist.githubusercontent.com/boomtn2/5ce8bb73a6d6cbb7eb41c972ce13e6bd/raw/";
  @override
  Future<List> fetchDataChannel() async {
    var endpoint = _path;
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseChannel(response));
    } catch (e) {
      rethrow;
    }
  }

  List<dynamic> _parseChannel(Response<dynamic> response) {
    var json = jsonDecode(response.data);
    List<ChannelModel> list = [];
    for (var item in json['channel']) {
      list.add(ChannelModel.json(item));
    }

    return list;
  }
}
