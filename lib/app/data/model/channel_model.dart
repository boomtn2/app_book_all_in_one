class ChannelModel {
  final String name;
  final String thumbail;
  final String id;

  ChannelModel({required this.name, required this.thumbail, required this.id});

  //DB
  static const String table = "ChannelModel";
  static const String cName = "type";
  static const String cId = "id"; //id
  static const String cThumbail = "thumbail";

  Map<String, Object?> getMapInsertDB() {
    return {cId: id, cName: name, cThumbail: thumbail};
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT PRIMARY KEY,$cName TEXT,$cThumbail TEXT)';
  factory ChannelModel.json(Map<String, dynamic> json) {
    return ChannelModel(
        name: json["name"] ?? '',
        thumbail: json["thumbail"] ?? "",
        id: json["id"] ?? '');
  }
}
