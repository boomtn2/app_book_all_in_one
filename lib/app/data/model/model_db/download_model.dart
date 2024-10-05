class DownloadModel {
  final String id; //linkdownload
  final String name;
  final String image;
  final String detail;
  final String category;

  DownloadModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.detail,
      required this.category});

  Map<String, Object?> getMapInsertDB() {
    return {
      cID: id,
      cName: name,
      cImage: image,
      cDetail: detail,
      cCategory: category
    };
  }

  //Name database
  static String get dbTable => "download";
  static String get cID => "id";
  static String get cName => "name";
  static String get cImage => "image";
  static String get cDetail => "detail";
  static String get cCategory => "category";
}

class ItemDownload {
  final String id; //linkdownload
  final String name;
  final int stt;
  final String path;
  final String type;
  final String text;

  ItemDownload(
      {required this.id,
      required this.name,
      required this.stt,
      required this.path,
      required this.type,
      required this.text});

  //Name database
  static String get dbTable => "item_download";
  static String get cID => "id";
  static String get cName => "chapter";
  static String get cText => "text";
  static String get cType => "type";
  static String get cSTT => "stt";
  static String get cPath => "path";

  Map<String, Object?> getMapInsertDB() {
    return {
      cID: id,
      cName: name,
      cText: text,
      cType: type,
      cSTT: stt,
      cPath: path
    };
  }
}
