// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuerryGetListBookHTML {
  String querryList;
  String queryText;
  String queryScr;
  String queryAuthor;
  String queryview;
  String queryHref;
  String domain;
  QuerryGetListBookHTML({
    required this.querryList,
    required this.queryText,
    required this.queryScr,
    required this.queryAuthor,
    required this.queryview,
    required this.queryHref,
    required this.domain,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'querryList': querryList,
      'queryText': queryText,
      'queryScr': queryScr,
      'queryAuthor': queryAuthor,
      'queryview': queryview,
      'queryHref': queryHref,
      'domain': domain,
    };
  }

  factory QuerryGetListBookHTML.fromMap(Map<String, dynamic> map) {
    return QuerryGetListBookHTML(
      querryList: '${map['querryList']}',
      queryText: '${map['queryText']}',
      queryScr: '${map['queryScr']}',
      queryAuthor: '${map['queryAuthor']}',
      queryview: '${map['queryview']}',
      queryHref: '${map['queryHref']}',
      domain: '${map['domain']}',
    );
  }

  factory QuerryGetListBookHTML.none() {
    return QuerryGetListBookHTML(
      querryList: '',
      queryText: '',
      queryScr: '',
      queryAuthor: '',
      queryview: '',
      queryHref: '',
      domain: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuerryGetListBookHTML.fromJson(String source) =>
      QuerryGetListBookHTML.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuerryGetListBookHTML(querryList: $querryList, queryText: $queryText, queryScr: $queryScr, queryAuthor: $queryAuthor, queryview: $queryview, queryHref: $queryHref, domain: $domain)';
  }
}

class QuerryGetChapterHTML {
  String querryLinkNext;
  String querryLinkPre;
  String querryTextChapter;
  String querryTitle;
  String domain;
  QuerryGetChapterHTML({
    required this.querryLinkNext,
    required this.querryLinkPre,
    required this.querryTextChapter,
    required this.querryTitle,
    required this.domain,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'querryLinkNext': querryLinkNext,
      'querryLinkPre': querryLinkPre,
      'querryTextChapter': querryTextChapter,
      'querryTitle': querryTitle,
      'domain': domain,
    };
  }

  factory QuerryGetChapterHTML.fromMap(Map<String, dynamic> map) {
    return QuerryGetChapterHTML(
      querryLinkNext: '${map['querryLinkNext']}',
      querryLinkPre: '${map['querryLinkPre']}',
      querryTextChapter: '${map['querryTextChapter']}',
      querryTitle: '${map['querryTitle']}',
      domain: '${map['domain']}',
    );
  }

  factory QuerryGetChapterHTML.none() {
    return QuerryGetChapterHTML(
      querryLinkNext: '',
      querryLinkPre: '',
      querryTextChapter: '',
      querryTitle: '',
      domain: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuerryGetChapterHTML.fromJson(String source) =>
      QuerryGetChapterHTML.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuerryGetChapterHTML(querryLinkNext: $querryLinkNext, querryLinkPre: $querryLinkPre, querryTextChapter: $querryTextChapter, querryTitle: $querryTitle, domain: $domain)';
  }
}
