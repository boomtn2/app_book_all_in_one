class FavoriteModel {
  final String id;
  final String name;
  final String image;
  final String type;
  int isFavorite;

  FavoriteModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.type,
      required this.isFavorite}); // 0 false , 1 true

  //Database
  static String get table => "favorite";
  static String get cId => "id";
  static String get cName => "name";
  static String get cImage => "image";
  static String get cType => "type";
  static String get cFavorite => "is_favorite";

  Map<String, Object?> getMapInsertDB() {
    return {
      cId: id,
      cName: name,
      cImage: image,
      cType: type,
      cFavorite: isFavorite
    };
  }

  bool get isFollow => isFavorite == 1;

  void follow() {
    isFavorite = 1;
  }

  void unFollow() {
    isFavorite = 0;
  }
}
