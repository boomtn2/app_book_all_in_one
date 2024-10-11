class NewsPostCardModel {
  static const String domain = "https://gw.vnexpress.net/ar/get_basic";

  static Map<String, dynamic> getPostCard(List<String> articleIds) {
    Map<String, dynamic> param = {
      "data_select":
          "podcast,article_type,title,lead,thumbnail_url,thumbnail_url2,share_url,publish_time",
      "thumb_size": "100x100",
      "thumb_quality": "100",
      "thumb_dpr": "1,2",
      "thumb_fit": "crop"
    };

    String article_id = '';

    for (var element in articleIds) {
      article_id += '$element,';
    }

    param["article_id"] = article_id;
    return param;
  }
}
