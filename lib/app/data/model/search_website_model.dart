class NextPage {
  final String param;
  final int begin;
  final int step;
  //DB
  static const String table = "NextPage";
  static const String cId = "id"; //idWebsite
  static const String cbegin = "begin";
  static const String cParam = "param";
  static const String cstep = "step";

  Map<String, Object?> getMapInsertDB(String id) {
    return {cId: id, cParam: param, cbegin: begin, cstep: step};
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT,$cParam TEXT,$cstep INTEGER,$cbegin INTEGER )';
  NextPage({required this.param, required this.begin, required this.step});

  factory NextPage.json(Map<String, dynamic> json) {
    return NextPage(
        begin: json['begin'], param: json['param'], step: json['step']);
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'param': param,
      'begin': begin,
      'step': step,
    };
  }

  // toString method
  @override
  String toString() {
    return 'NextPage(param: $param, begin: $begin, step: $step)';
  }
}

class Fill {
  final String name;
  final String param;
  final List<Map<String, dynamic>> values;

  //DB
  static const String table = "Fill";
  static const String cId = "id"; //idWebsite
  static const String cName = "name";
  static const String cParam = "param";
  static const String cValues = "cValues";

  Map<String, Object?> getMapInsertDB(String id) {
    return {cId: id, cName: name, cParam: param, cValues: ""};
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT,$cName TEXT,$cParam TEXT,$cValues TEXT )';

  Fill({required this.name, required this.param, required this.values});

  factory Fill.json(Map<String, dynamic> json) {
    return Fill(
        name: json['name'] ?? '', param: json['param'] ?? '', values: []);
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'param': param,
      'values': values,
    };
  }

  // toString method
  @override
  String toString() {
    return 'Fill(name: $name, param: $param, values: $values)';
  }
}

List<Fill> getListFill(Map<String, dynamic> json) {
  if (json['fill'] != null) {
    var list = json['fill'] as List;
    List<Fill> fillList = list.map((i) => Fill.json(i)).toList();
    return fillList;
  } else {
    return [];
  }
}

class SearchTag {
  final String? type;
  final String? website;
  final String? path;
  final String? typePram;
  final List<Fill> fill;
  final Map<String, dynamic>? params;
  final NextPage? nextPage;

  //DB
  static const String table = "SearchTag";
  static const String cType = "type";
  static const String cId = "website"; //id
  static const String cPath = "path";
  static const String cTypePram = "typePram";
  static const String cParams = "params";

  Map<String, Object?> getMapInsertDB() {
    return {
      cId: website,
      cType: type,
      cPath: path,
      cTypePram: typePram,
      cParams: params.toString()
    };
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT PRIMARY KEY,$cType TEXT,$cPath TEXT,$cTypePram TEXT,$cParams TEXT)';
  SearchTag(
      {required this.type,
      required this.website,
      required this.path,
      required this.typePram,
      required this.params,
      required this.nextPage,
      required this.fill});

  factory SearchTag.json(Map<String, dynamic> json) {
    return SearchTag(
        type: json['type'],
        website: json['website'],
        path: json['path'],
        typePram: json['param-type'],
        params: json['params'],
        nextPage:
            json['nextpage'] != null ? NextPage.json(json['nextpage']) : null,
        fill: getListFill(json));
  }

  String getLink(Map<String, dynamic> json) {
    Uri link = Uri.parse(website ?? '');
    if (typePram?.contains('path') == true) {
      String path = this.path ?? '';
      json.forEach((key, value) {
        path += value.toString();
      });
      Uri linkQuerry = Uri(
          host: link.host,
          scheme: link.scheme,
          path: path,
          queryParameters: params);
      return linkQuerry.toString();
    } else {
      json.addAll(params ?? {});

      Uri linkQuerry = Uri(
          host: link.host,
          scheme: link.scheme,
          path: path,
          queryParameters: json);

      return linkQuerry.toString();
    }
  }

  String linkNextPage(int index, String link) {
    int paramIndex = 0;
    if (index == 0) {
      paramIndex = nextPage?.begin ?? 0;
    } else {
      paramIndex = (nextPage?.step ?? 0) * index;
    }

    if (typePram?.contains('path') == true) {
      return '$link/$paramIndex';
    } else {
      final uri = Uri.parse(link);
      Map<String, dynamic> map = {};
      map.addAll(uri.queryParametersAll);
      if (nextPage != null) {
        map.addAll({
          nextPage!.param: [paramIndex.toString()]
        });
      }
      return Uri(
              scheme: uri.scheme,
              host: uri.host,
              queryParameters: map,
              path: uri.path)
          .toString();
    }
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'website': website,
      'path': path,
      'type-pram': typePram,
      'params': params,
      'nextpage': nextPage?.toJson(),
      'fill': fill.map((e) => e.toJson()).toList(),
    };
  }

  // toString method
  @override
  String toString() {
    return 'SearchTag(type: $type, website: $website, path: $path, '
        'typePram: $typePram, params: $params, nextPage: $nextPage, fill: $fill)';
  }
}

class SearchName {
  final String? type;
  final String? website;
  final String? path;
  final String? typePram;
  final List<Fill> fill;
  final Map<String, dynamic>? params;
  final String? param;
  final NextPage? nextPage;

  //DB
  static const String table = "SearchName";
  static const String cType = "type";
  static const String cId = "website"; //id
  static const String cPath = "path";
  static const String cTypePram = "typePram";
  static const String cParams = "params";

  Map<String, Object?> getMapInsertDB() {
    return {
      cId: website,
      cType: type,
      cPath: path,
      cTypePram: typePram,
      cParams: params.toString()
    };
  }

  static String get querryCreateTable =>
      'CREATE TABLE $table($cId TEXT PRIMARY KEY,$cType TEXT,$cPath TEXT,$cTypePram TEXT,$cParams TEXT)';
  SearchName(
      {required this.type,
      required this.website,
      required this.path,
      required this.typePram,
      required this.params,
      required this.nextPage,
      required this.fill,
      required this.param});

  factory SearchName.json(Map<String, dynamic> json) {
    return SearchName(
        type: json['type'],
        website: json['website'],
        path: json['path'],
        typePram: json['param-type'],
        params: json['params'],
        nextPage:
            json['nextpage'] != null ? NextPage.json(json['nextpage']) : null,
        fill: getListFill(json),
        param: json['param']);
  }

  String getLink(String name) {
    Uri link = Uri.parse(website ?? '');
    if (typePram?.contains('path') == true) {
      String path = this.path ?? '';
      path += '/$name';
      Uri linkQuerry = Uri(
          host: link.host,
          scheme: link.scheme,
          path: path,
          queryParameters: params);
      return linkQuerry.toString();
    } else {
      Map<String, dynamic> param = {};
      if (this.param != null) {
        param.addAll({this.param!: name});
      }
      if (params != null) {
        param.addAll(params!);
      }

      Uri linkQuerry = Uri(
          host: link.host,
          scheme: link.scheme,
          path: path,
          queryParameters: param);

      return linkQuerry.toString();
    }
  }

  String linkNextPage(int index, String link) {
    int paramIndex = 0;
    if (index == 0) {
      paramIndex = nextPage?.begin ?? 0;
    } else {
      paramIndex = (nextPage?.step ?? 0) * index;
    }

    if (typePram?.contains('path') == true) {
      return '$link/$paramIndex';
    } else {
      final uri = Uri.parse(link);
      Map<String, dynamic> map = {};
      map.addAll(uri.queryParametersAll);
      if (nextPage != null) {
        map.addAll({
          nextPage!.param: [paramIndex.toString()]
        });
      }
      return Uri(
              scheme: uri.scheme,
              host: uri.host,
              queryParameters: map,
              path: uri.path)
          .toString();
    }
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'website': website,
      'path': path,
      'type-pram': typePram,
      'params': params,
      'nextpage': nextPage?.toJson(),
      'fill': fill.map((e) => e.toJson()).toList(),
    };
  }

  // toString method
  @override
  String toString() {
    return 'SearchTag(type: $type, website: $website, path: $path, '
        'typePram: $typePram, params: $params, nextPage: $nextPage, fill: $fill)';
  }
}

class ListSearchTag {
  final List<SearchTag> listSearchTag;

  ListSearchTag({required this.listSearchTag});

  factory ListSearchTag.json(Map<String, dynamic> json) {
    if (json['search-tag'] != null) {
      var list = json['search-tag'] as List;
      List<SearchTag> fillList = list.map((i) => SearchTag.json(i)).toList();
      return ListSearchTag(listSearchTag: fillList);
    } else {
      return ListSearchTag(listSearchTag: []);
    }
  }
}

class ListSearchName {
  final List<SearchName> listSearchName;

  ListSearchName({required this.listSearchName});

  factory ListSearchName.json(Map<String, dynamic> json) {
    if (json['search-name'] != null) {
      var list = json['search-name'] as List;
      List<SearchName> fillList = list.map((i) => SearchName.json(i)).toList();
      return ListSearchName(listSearchName: fillList);
    } else {
      return ListSearchName(listSearchName: []);
    }
  }
}
