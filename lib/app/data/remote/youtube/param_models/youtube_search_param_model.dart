class YoutubeSearchParamModel {
  String part;
  String? channelId;
  String? q;
  String key;
  String type;
  String order;
  int maxResults;
  String? path;
  String? token;
  YoutubeSearchParamModel(
      {this.part = 'snippet',
      required this.q,
      this.channelId,
      this.key = 'AIzaSyCUXDfE40L7OY9OqYsKOfQP6ivLWGjc4sg',
      this.type = 'playlist',
      this.order = 'rating',
      this.maxResults = 50});
  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['part'] = part;
    if (channelId != null) {
      data['channelId'] = channelId ?? '';
    }
    if (q != null) {
      data['q'] = q;
    }

    data['key'] = key;
    data['type'] = type;
    data['order'] = order;
    data['maxResults'] = maxResults;

    return data;
  }

  Map<String, dynamic>? toJsonNextPage() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['part'] = part;
    if (channelId != null) {
      data['channelId'] = channelId ?? '';
    }
    if (q != null) {
      data['q'] = q;
    }

    data['key'] = key;
    data['type'] = type;
    data['order'] = order;
    data['maxResults'] = maxResults;
    if (token != null) {
      data["pageToken"] = token;
    }
    return data;
  }
}
