import 'package:audio_youtube/app/core/base/base_controller.dart';
import 'package:audio_youtube/app/core/utils/util.dart';
import 'package:audio_youtube/app/modules/webview/views/webview_book_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../data/model/models_export.dart';
import '../../../data/repository/database_repository.dart';

class SearchBookController extends BaseController {
  final DatabaseRepository _databaseRepository =
      Get.find(tag: (DatabaseRepository).toString());
  ListSearchTag? tagSearch;
  ListSearchName? nameSearch;

  RxList<GroupTag> grTag = <GroupTag>[].obs;
  List<WebsiteTag> listWebsiteTag = [];
  RxBool isSearchName = false.obs;
  @override
  void onInit() {
    debugPrint("[onInit] [SearchController]");
    super.onInit();
    _init();
  }

  void _init() async {
    listWebsiteTag = await _databaseRepository.getAllCatregory();

    if (listWebsiteTag.isNotEmpty) {
      final tags = listWebsiteTag.first;
      List<GroupTag> temp = [tags.hotTag, ...tags.tags];
      grTag.value = temp;
    }

    final listSearchName = await _databaseRepository.getAllSearchName();

    nameSearch = ListSearchName(listSearchName: listSearchName);

    final listSearchTag = await _databaseRepository.getAllSearchTag();
    tagSearch = ListSearchTag(listSearchTag: listSearchTag);
  }

  // RxMap<String, List> tagSelected = <String, List>{}.obs;
  RxMap<String, Tag> tagSelected = <String, Tag>{}.obs;
  void selectTag(Tag tag) {
    _addTag(tag.name, tag);
  }

  void _addTag(String tag, Tag value) {
    if (tagSelected.containsKey(tag) == true) {
      tagSelected.remove(tag);
    } else {
      tagSelected[tag] = value;
    }
  }

  void search(BuildContext context) {
    String? url = tagSearch?.listSearchTag[0].getLink(_toJsonTag());

    if (url != null) {
      Util.navigateNamed(context, WebViewBookView.name, extra: url);
    } else {
      showErrorMessage('Lỗi tạo đường dẫn website');
    }
  }

  Map<String, dynamic> _toJsonTag() {
    Map<String, dynamic> querry = {};
    for (Tag tag in tagSelected.values) {
      for (IDTag id in tag.idTags) {
        if (querry.containsKey(id.tag) == true) {
          List data = [];
          data.addAll(querry[id.tag]!);
          data.add(id.id);
          querry[id.tag] = data;
        } else {
          querry.addAll({
            id.tag: [id.id]
          });
        }
      }
    }

    return querry;
  }
}
