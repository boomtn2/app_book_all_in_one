//type: mp3, text, ytb, rss, webview

class HistoryModel {
  final String id;
  final String name;
  final String image;
  final String type;

  HistoryModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.type});

  static String get table => "history";
  static String get cId => "id";
  static String get cName => "name";
  static String get cImage => "image";
  static String get cType => "type";

  Map<String, Object?> getMapInsertDB() {
    return {cId: id, cName: name, cImage: image, cType: type};
  }
}

class ChapterHistoryModel {
  final String id;
  final String name;
  final String path;
  final String type;

  ChapterHistoryModel(
      {required this.id,
      required this.name,
      required this.path,
      required this.type});

  static String get table => "chapter_history";
  static String get cId => "id";
  static String get cName => "name";
  static String get cPath => "path";
  static String get cType => "type";

  Map<String, Object?> getMapInsertDB() {
    return {cId: id, cName: name, cPath: path, cType: type};
  }
}
