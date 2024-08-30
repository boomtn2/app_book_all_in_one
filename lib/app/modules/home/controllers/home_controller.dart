import 'package:audio_youtube/app/data/api/gist/rss_remote.dart';
import 'package:audio_youtube/app/data/api/youtube/youtube_remote.dart';
import 'package:audio_youtube/app/data/model/rss_model.dart';
import 'package:get/get.dart';

import '../../../data/model/book_model.dart';
import '../../../data/repository/youtube_search_response.dart';

class HomeController extends GetxController {
  RxList<BookModel> videoYoutube = <BookModel>[].obs;
  YoutubeSearchResponse? responseYoutube;
  PodcastList? podcastList;
  RxMap<String, bool> titleTabPrenium = {
    'Đề xuất': false,
    'Chọn lọc': false,
  }.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {
    videoYoutube.clear();
    super.onClose();
  }

  Future _loadHotSearchYoutube() async {
    responseYoutube =
        await YoutubeRemoteDataSoureImpl().searchYoutubeVideo('Thập niên');

    responseYoutube?.items.forEach((element) {
      final book = BookModel(
          title: element.snippet.title,
          author: element.snippet.channelTitle,
          img: element.snippet.thumbnails.thumbnailsDefault.url,
          id: element.id.videoId,  
          type: element.id.kind,
          snippet: element.snippet,
          detail: element.snippet.description);
      videoYoutube.add(book);
    });
  }

  Future _loadRSS() async {
    podcastList = await RSSRemoteDataSoureImpl().fetchDataRSS();
  }

  void init()async{
   await _loadHotSearchYoutube();
   titleTabPrenium.listen(
    (p0) {
      
    },
   );
   if(responseYoutube != null && responseYoutube?.items.isNotEmpty == true)
   {
      titleTabPrenium['Đề xuất'] = true;
   }else{
      titleTabPrenium['Chọn lọc'] = true;
   }
  await  _loadRSS();
  }
}
