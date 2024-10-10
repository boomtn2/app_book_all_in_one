import 'package:get/get.dart';

import '../../data/model/models_export.dart';
import '../../data/repository/news_repository.dart';

class PostCardController extends GetxController {
  final BookModel introPostCard;
  RxList<BookModel> playList = <BookModel>[].obs;

  int offset = 0;

  final NewsRepository _newsRepository = NewsRepositoryImpl();

  PostCardController({required this.introPostCard});

  @override
  void onReady() {
    fetchPlayList();
    super.onReady();
  }

  void fetchPlayList() async {
    playList.value = await _newsRepository.fetchPostCardArticleIds(
        introPostCard.id ?? '', 30, offset);
  }
}
