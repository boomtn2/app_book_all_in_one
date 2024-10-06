class ConfigWebsiteModel {
  final List<ConfigWebsite> configWebsite;

  ConfigWebsiteModel({
    required this.configWebsite,
  });

  ConfigWebsiteModel copyWith({
    List<ConfigWebsite>? configWebsite,
  }) =>
      ConfigWebsiteModel(
        configWebsite: configWebsite ?? this.configWebsite,
      );

  factory ConfigWebsiteModel.fromJson(Map<String, dynamic> json) {
    return ConfigWebsiteModel(
      configWebsite: (json['config-website'] as List)
          .map((e) => ConfigWebsite.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'config-website': configWebsite.map((e) => e.toJson()).toList(),
      };
}

class ConfigWebsite {
  final String type;
  final String website;
  final Listbookhtml listbookhtml;
  final Chapterhtml chapterhtml;
  final Jsleak jsleak;

  //DB
  static const String table = "configwebsite";
  static const String cType = "type";
  static const String cId = "id"; //id

  String get id => website;

  Map<String, Object?> getMapInsertDB() {
    return {cId: id, cType: type};
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT PRIMARY KEY,$cType TEXT  )';

  ConfigWebsite({
    required this.type,
    required this.website,
    required this.listbookhtml,
    required this.chapterhtml,
    required this.jsleak,
  });

  ConfigWebsite copyWith({
    String? type,
    String? website,
    Listbookhtml? listbookhtml,
    Chapterhtml? chapterhtml,
    Jsleak? jsleak,
  }) =>
      ConfigWebsite(
        type: type ?? this.type,
        website: website ?? this.website,
        listbookhtml: listbookhtml ?? this.listbookhtml,
        chapterhtml: chapterhtml ?? this.chapterhtml,
        jsleak: jsleak ?? this.jsleak,
      );

  factory ConfigWebsite.fromJson(Map<String, dynamic> json) {
    return ConfigWebsite(
      type: json['type'],
      website: json['website'],
      listbookhtml: Listbookhtml.fromJson(json['listbookhtml']),
      chapterhtml: Chapterhtml.fromJson(json['chapterhtml']),
      jsleak: Jsleak.fromJson(json['jsleak']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'website': website,
        'listbookhtml': listbookhtml.toJson(),
        'chapterhtml': chapterhtml.toJson(),
        'jsleak': jsleak.toJson(),
      };
}

class Chapterhtml {
  final String querryLinkNext;
  final String querryLinkPre;
  final String querryTextChapter;
  final String querryTitle;

  Chapterhtml({
    required this.querryLinkNext,
    required this.querryLinkPre,
    required this.querryTextChapter,
    required this.querryTitle,
  });

  //DB
  static const String table = "Chapterhtml";
  static const String cID = "id";
  static const String cQuerryLinkNext = "querryLinkNext";
  static const String cQuerryLinkPre = "querryLinkPre";
  static const String cQuerryTextChapter = "querryTextChapter";
  static const String cQuerryTitle = "querryTitle";

  static String get querryCreateTable =>
      'CREATE TABLE $table($cID TEXT,$cQuerryLinkNext TEXT ,$cQuerryLinkPre TEXT,$cQuerryTextChapter TEXT,$cQuerryTitle TEXT)';

  Map<String, Object?> getMapInsertDB(String id) {
    return {
      cID: id,
      cQuerryLinkNext: querryLinkNext,
      cQuerryLinkPre: querryLinkPre,
      cQuerryTextChapter: querryTextChapter,
      cQuerryTitle: querryTitle,
    };
  }

  Chapterhtml copyWith({
    String? querryLinkNext,
    String? querryLinkPre,
    String? querryTextChapter,
    String? querryTitle,
  }) =>
      Chapterhtml(
        querryLinkNext: querryLinkNext ?? this.querryLinkNext,
        querryLinkPre: querryLinkPre ?? this.querryLinkPre,
        querryTextChapter: querryTextChapter ?? this.querryTextChapter,
        querryTitle: querryTitle ?? this.querryTitle,
      );

  factory Chapterhtml.fromJson(Map<String, dynamic> json) {
    return Chapterhtml(
      querryLinkNext: json['querryLinkNext'],
      querryLinkPre: json['querryLinkPre'],
      querryTextChapter: json['querryTextChapter'],
      querryTitle: json['querryTitle'],
    );
  }

  Map<String, dynamic> toJson() => {
        'querryLinkNext': querryLinkNext,
        'querryLinkPre': querryLinkPre,
        'querryTextChapter': querryTextChapter,
        'querryTitle': querryTitle,
      };
}

class Jsleak {
  final String jsIndexing;
  final String jsListChapter;
  final String jsActionNext;
  final String jsDescription;
  final String jsCategory;
  final String jsOther;

  //DB
  static const String table = "Jsleak";
  static const String cID = "id";
  static const String cJsIndexing = "jsIndexing";
  static const String cJsListChapter = "jsListChapter";
  static const String cJsActionNext = "jsActionNext";
  static const String cJsDescription = "jsDescription";
  static const String cJsCategory = "jsCategory";
  static const String cJsOther = "jsOther";

  static String get querryCreateTable =>
      'CREATE TABLE $table($cID TEXT,$cJsIndexing TEXT,$cJsListChapter TEXT,$cJsActionNext TEXT,$cJsDescription TEXT,$cJsCategory TEXT,$cJsOther TEXT  )';
  Map<String, Object?> getMapInsertDB(String id) {
    return {
      cID: id,
      cJsIndexing: jsIndexing,
      cJsListChapter: jsListChapter,
      cJsActionNext: jsActionNext,
      cJsDescription: jsDescription,
      cJsCategory: jsCategory,
      cJsOther: jsOther
    };
  }

  Jsleak({
    required this.jsIndexing,
    required this.jsListChapter,
    required this.jsActionNext,
    required this.jsDescription,
    required this.jsCategory,
    required this.jsOther,
  });

  Jsleak copyWith({
    String? jsIndexing,
    String? jsListChapter,
    String? jsActionNext,
    String? jsDescription,
    String? jsCategory,
    String? jsOther,
  }) =>
      Jsleak(
        jsIndexing: jsIndexing ?? this.jsIndexing,
        jsListChapter: jsListChapter ?? this.jsListChapter,
        jsActionNext: jsActionNext ?? this.jsActionNext,
        jsDescription: jsDescription ?? this.jsDescription,
        jsCategory: jsCategory ?? this.jsCategory,
        jsOther: jsOther ?? this.jsOther,
      );

  factory Jsleak.fromJson(Map<String, dynamic> json) {
    return Jsleak(
      jsIndexing: json['jsIndexing'],
      jsListChapter: json['jsListChapter'],
      jsActionNext: json['jsActionNext'],
      jsDescription: json['jsDescription'],
      jsCategory: json['jsCategory'],
      jsOther: json['jsOther'],
    );
  }

  Map<String, dynamic> toJson() => {
        'jsIndexing': jsIndexing,
        'jsListChapter': jsListChapter,
        'jsActionNext': jsActionNext,
        'jsDescription': jsDescription,
        'jsCategory': jsCategory,
        'jsOther': jsOther,
      };
}

class Listbookhtml {
  final String querryList;
  final String queryText;
  final String queryScr;
  final String queryAuthor;
  final String queryview;
  final String queryHref;

  //DB
  static const String table = "listbookhtml";
  static const String cID = "id";
  static const String cQuerryList = "querrylist";
  static const String cQueryText = "queryText";
  static const String cQueryScr = "queryScr";
  static const String cQueryAuthor = "queryAuthor";
  static const String cQueryview = "queryview";
  static const String cQueryHref = "queryHref";
  static String get querryCreateTable =>
      'CREATE TABLE $table($cID TEXT,$cQuerryList TEXT,$cQueryText TEXT,$cQueryScr TEXT,$cQueryAuthor TEXT,$cQueryview TEXT,$cQueryHref TEXT  )';
  Map<String, Object?> getMapInsertDB(String id) {
    return {
      cID: id,
      cQuerryList: querryList,
      cQueryText: queryText,
      cQueryScr: queryScr,
      cQueryAuthor: queryAuthor,
      cQueryview: queryview,
      cQueryHref: queryHref
    };
  }

  Listbookhtml({
    required this.querryList,
    required this.queryText,
    required this.queryScr,
    required this.queryAuthor,
    required this.queryview,
    required this.queryHref,
  });

  Listbookhtml copyWith({
    String? querryList,
    String? queryText,
    String? queryScr,
    String? queryAuthor,
    String? queryview,
    String? queryHref,
  }) =>
      Listbookhtml(
        querryList: querryList ?? this.querryList,
        queryText: queryText ?? this.queryText,
        queryScr: queryScr ?? this.queryScr,
        queryAuthor: queryAuthor ?? this.queryAuthor,
        queryview: queryview ?? this.queryview,
        queryHref: queryHref ?? this.queryHref,
      );

  factory Listbookhtml.fromJson(Map<String, dynamic> json) {
    return Listbookhtml(
      querryList: json['querryList'],
      queryText: json['queryText'],
      queryScr: json['queryScr'],
      queryAuthor: json['queryAuthor'],
      queryview: json['queryview'],
      queryHref: json['queryHref'],
    );
  }

  Map<String, dynamic> toJson() => {
        'querryList': querryList,
        'queryText': queryText,
        'queryScr': queryScr,
        'queryAuthor': queryAuthor,
        'queryview': queryview,
        'queryHref': queryHref,
      };
}
