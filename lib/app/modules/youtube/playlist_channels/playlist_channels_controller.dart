import 'package:get/get.dart';

import '../../../data/model/models_export.dart';
import '../../../data/remote/youtube/param_models/youtube_search_param_model.dart';
import '../../../data/repository/youtube_repository.dart';

class PlaylistChannelsController extends GetxController {
  List<ChannelModel> listChannel = [];

  RxList<PlayListChannelModelView> listData = <PlayListChannelModelView>[].obs;

  final YoutubeRepository _ytbRepository =
      Get.find(tag: (YoutubeRepository).toString());
  PlaylistChannelsController({required List<ChannelModel> channels}) {
    listChannel = channels;
  }

  @override
  void onReady() {
    fetchData();
    super.onReady();
  }

  void fetchData() async {
    List<PlayListChannelModelView> tempData = [];
    for (var item in listChannel) {
      final data = await _ytbRepository.searchIDChannel(item.id);
      final tempParam = await _ytbRepository.getParamSearchModel();
      tempData.add(PlayListChannelModelView(
          channel: item, playlist: data, param: tempParam));
    }
    listData.value = tempData;
  }
}

class PlayListChannelModelView {
  final ChannelModel channel;
  List<BookModel> playlist;
  YoutubeSearchParamModel? param;
  PlayListChannelModelView(
      {required this.channel, this.playlist = const [], this.param});
}
