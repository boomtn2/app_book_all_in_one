import 'package:audio_youtube/app/core/base/base_remote_source.dart';

abstract class TTSRemoteDataSoure {}

class NetWorkTTSRemoteDataSoure extends BaseRemoteSource
    implements TTSRemoteDataSoure {}

class LocalTTSRemoteDataSoure extends BaseRemoteSource
    implements TTSRemoteDataSoure {}
