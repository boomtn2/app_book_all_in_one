class YoutubePlaylistParamModel {
  String part;
  String? channelId;
  String playlistId;
  String key;
  String type;
  String order;
  int maxResults;

  YoutubePlaylistParamModel(
      {this.part = 'snippet',
      required this.playlistId,
      this.channelId,
      this.key = 'AIzaSyCUXDfE40L7OY9OqYsKOfQP6ivLWGjc4sg',
      this.type = 'video',
      this.order = 'date',
      this.maxResults = 50});
  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['part'] = part;
    if (channelId != null) {
      data['channelId'] = channelId ?? '';
    }
    data['playlistId'] = playlistId;
    data['key'] = key;
    data['type'] = type;
    data['order'] = order;
    data['maxResults'] = maxResults;

    return data;
  }
}
