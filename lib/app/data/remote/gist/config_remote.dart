// import 'dart:convert';

// import 'package:audio_youtube/app/core/base/base_remote_source.dart';
// import 'package:dio/dio.dart';

// import '../../model/models_export.dart';

// abstract class ConfigRemoteDataSoure {
//   Future<ListWebsite> fetchDataConfig();
// }

// class ConfigRemoteDataSoureImpl extends BaseRemoteSource
//     implements ConfigRemoteDataSoure {
//   final String _path =
//       'https://gist.githubusercontent.com/boomtn2/5828a093dcd04bd887cb9d5b10047cbb/raw/';

//   @override
//   Future<ListWebsite> fetchDataConfig() {
//     var endpoint = _path;
//     var dioCall = dioClient.get(endpoint);

//     try {
//       return callApiWithErrorParser(dioCall)
//           .then((response) => _parseConfigWebsiteResponse(response));
//     } catch (e) {
//       rethrow;
//     }
//   }

//   ListWebsite _parseConfigWebsiteResponse(Response<dynamic> response) {
//     String data = response.data;
//     final json = jsonDecode(data);

//     return ListWebsite.fromJson(json);
//   }
// }
