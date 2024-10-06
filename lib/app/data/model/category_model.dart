class WebsiteTag {
  final String type;
  final GroupTag hotTag;
  final List<GroupTag> tags;

  //DB
  static const String table = "WebsiteTag";
  static const String cId = "type"; //idWebsite

  Map<String, Object?> getMapInsertDB(String id) {
    return {
      cId: id,
    };
  }

  static String get querryCreateTable => 'CREATE TABLE $table($cId TEXT )';

  WebsiteTag({required this.type, required this.hotTag, required this.tags});

  factory WebsiteTag.json(Map<String, dynamic> json) {
    final data = json['tags'];
    List<GroupTag> list = [];
    for (Map<String, dynamic> item in data) {
      list.add(GroupTag.jsonTag(item));
    }
    return WebsiteTag(
        type: json['type'],
        hotTag: GroupTag.jsonTag(json['tag-hot']),
        tags: list);
  }

  @override
  String toString() {
    return "$type \nhotTag: ${hotTag.toString()} \ntags: ${tags.toString()}";
  }
}

class GroupTag {
  final String nameGroup;
  final List<Tag> tags;
  final bool multiselect;

  GroupTag(
      {required this.nameGroup, required this.tags, required this.multiselect});
  //DB
  static const String table = "GroupTag";
  static const String cId = "id"; //idWebsite
  static const String cNameGroup = "nameGroup"; //id GroupTag
  static const String cMultiselect = "multiselect";

  Map<String, Object?> getMapInsertDB(String id) {
    return {cId: id, cNameGroup: nameGroup, cMultiselect: multiselect ? 1 : 0};
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT,$cNameGroup TEXT,$cMultiselect INTEGER)';
  factory GroupTag.jsonTag(Map<String, dynamic> json) {
    final tags = json["values"];
    List<Tag> tempTags = [];
    for (var tag in tags) {
      List<IDTag> listID = [];
      for (Map<String, dynamic> id in tag["values"]) {
        MapEntry data = id.entries.first;
        listID.add(IDTag(id: data.value, tag: data.key));
      }
      tempTags.add(Tag(name: tag["name"], idTags: listID));
    }

    return GroupTag(
        nameGroup: json['group-name'] ?? 'Hot Search',
        tags: tempTags,
        multiselect: json["multiselect"] ?? false);
  }

  @override
  String toString() {
    return "$nameGroup \n${tags.toString()}";
  }
}

class Tag {
  final String name;
  final List<IDTag> idTags;

  //DB
  static const String table = "Tag";
  static const String cId = "id"; //idGRTAG
  static const String cName = "name"; //idIDTAG

  Map<String, Object?> getMapInsertDB(String id) {
    return {cId: id, cName: name};
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT, $cName TEXT)';
  Tag({required this.name, required this.idTags});

  @override
  String toString() {
    return "name: $name \n ${idTags.toString()}";
  }
}

class IDTag {
  final String id;
  final String tag;

  //DB
  static const String table = "IDTag";
  static const String cTag = "tag";
  static const String cId = "id"; //id
  static const String cCode = "code"; //id

  Map<String, Object?> getMapInsertDB(String idTAG) {
    return {
      cId: idTAG,
      cTag: tag,
      cCode: id,
    };
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT PRIMARY KEY,$cTag TEXT )';
  IDTag({required this.id, required this.tag});

  @override
  String toString() {
    return '$id : $tag';
  }
}
