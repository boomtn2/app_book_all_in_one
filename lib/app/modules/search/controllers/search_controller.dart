import 'package:audio_youtube/app/core/base/base_controller.dart';
import 'package:audio_youtube/app/core/utils/util.dart';

import 'package:audio_youtube/app/data/repository/data_repository.dart';
import 'package:audio_youtube/app/modules/webview/views/webview_book_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../data/model/models_export.dart';

class SearchBookController extends BaseController {
  DataRepository get _dataRepository => DataRepository.instance;
  ListSearchTag? get tagSearch => _dataRepository.tagSearch;
  ListSearchName? get nameSearch => _dataRepository.nameSearch;

  RxList<GroupTag> grTag = <GroupTag>[].obs;
  RxBool isSearchName = false.obs;
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (_dataRepository.tagWebsite != null) {
      grTag.value = _dataRepository.tagWebsite![0].tags;
    }
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
      Util.pushNamed(context, WebViewBookView.name, extra: url);
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
