class WebsiteTag {
  final String type;
  final GroupTag hotTag;
  final List<GroupTag> tags;

  //DB
  static const String table = "WebsiteTag";
  static const String cId = "json"; //idWebsite

  String get id => type;

  Map<String, Object?> getMapInsertDB() {
    return {
      cId: type,
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

  factory WebsiteTag.db(String nameWebsite, GroupTag hot, List<GroupTag> list) {
    return WebsiteTag(type: nameWebsite, hotTag: hot, tags: list);
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

  String get id => nameGroup;

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

  bool get isHotTag => nameGroup.contains('Hot Search');

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

  factory GroupTag.db(Map<String, dynamic> gr, List<Map<String, dynamic>> tags,
      List<Map<String, dynamic>> tagIDs) {
    List<Tag> tempTags = [];
    for (var tag in tags) {
      List<IDTag> listID = [];
      for (Map<String, dynamic> id in tagIDs) {
        listID.add(IDTag.db(id));
      }
      tempTags.add(Tag(name: tag[Tag.cName], idTags: listID));
    }
    return GroupTag(
        nameGroup: gr[cNameGroup] ?? 'Hot Search',
        tags: tempTags,
        multiselect: gr[cMultiselect] ?? false);
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
  static const String cWebsite = "website";

  Map<String, Object?> getMapInsertDB(String id, String website) {
    return {cId: id, cName: name, cWebsite: website};
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT, $cName TEXT,$cWebsite TEXT)';
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
  static const String cWebsite = "website";

  Map<String, Object?> getMapInsertDB(String idTAG, String website) {
    return {cId: idTAG, cTag: tag, cCode: id, cWebsite: website};
  }

  factory IDTag.db(Map<String, dynamic> json) {
    return IDTag(id: json[cCode], tag: json[cTag]);
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT PRIMARY KEY,$cTag TEXT ,$cWebsite TEXT)';
  IDTag({required this.id, required this.tag});

  @override
  String toString() {
    return '$id : $tag';
  }
}
