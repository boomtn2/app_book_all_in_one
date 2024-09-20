class ChannelModel {
  final String name;
  final String thumbail;
  final String id;

  ChannelModel({required this.name, required this.thumbail, required this.id});

  factory ChannelModel.json(Map<String, dynamic> json) {
    return ChannelModel(
        name: json["name"] ?? '',
        thumbail: json["thumbail"] ?? "",
        id: json["id"] ?? '');
  }
}
