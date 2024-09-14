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
}

class ConfigWebsite {
  final String type;
  final String website;
  final Listbookhtml listbookhtml;
  final Chapterhtml chapterhtml;
  final Jsleak jsleak;

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
}

class Jsleak {
  final String jsIndexing;
  final String jsListChapter;
  final String jsActionNext;
  final String jsDescription;
  final String jsCategory;
  final String jsOther;

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
}

class Listbookhtml {
  final String querryList;
  final String queryText;
  final String queryScr;
  final String queryAuthor;
  final String queryview;
  final String queryHref;

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
}
