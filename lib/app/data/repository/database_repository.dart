import 'dart:convert';
import 'package:audio_youtube/app/data/model/models_export.dart';
import 'package:flutter/material.dart';
import '../service/sqlite/sqlite_helper.dart';

abstract class DatabaseRepository {
  Future<bool> insertConfigWebsite(ConfigWebsite configWebsite);
  Future<ConfigWebsite?> getConfigWebsite(String id);
  Future<List<ConfigWebsite>> getAllConfigWebsite();
  Future<bool> deleteConfigWebsite(String id);
  Future<bool> isRecordPresent(String table, String cId, String id);
  //Category
  Future<bool> insertCatregory(String json);
  Future<List<WebsiteTag>> getAllCatregory();
  Future<bool> deleteCatregory();
  //Search
  Future<bool> insertSearchName(SearchName configWebsite);
  Future<bool> insertSearchTag(SearchTag tag);
  Future<List<SearchName>> getAllSearchName();
  Future<List<SearchTag>> getAllSearchTag();
  Future<bool> deleteSearch(String id);
}

class DataBaseRepositoryImpl implements DatabaseRepository {
  final DatabaseHelper _helper = DatabaseHelper();

  @override
  Future<bool> insertConfigWebsite(ConfigWebsite configWebsite) async {
    int response = await _helper.insertDB(
        ConfigWebsite.table, configWebsite.getMapInsertDB());
    response = await _helper.insertDB(Listbookhtml.table,
        configWebsite.listbookhtml.getMapInsertDB(configWebsite.id));
    response = await _helper.insertDB(Chapterhtml.table,
        configWebsite.chapterhtml.getMapInsertDB(configWebsite.id));
    response = await _helper.insertDB(
        Jsleak.table, configWebsite.jsleak.getMapInsertDB(configWebsite.id));
    if (response > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<ConfigWebsite?> getConfigWebsite(String id) async {
    final websites = await _helper.getDB(ConfigWebsite.table,
        where: '${ConfigWebsite.cId} = ?', whereArgs: [id]);
    final books = await _helper.getDB(Listbookhtml.table,
        where: '${Listbookhtml.cID} = ?', whereArgs: [id]);
    final chapters = await _helper.getDB(Chapterhtml.table,
        where: '${Chapterhtml.cID} = ?', whereArgs: [id]);
    final js = await _helper
        .getDB(Jsleak.table, where: '${Jsleak.cID} = ?', whereArgs: [id]);

    return ConfigWebsite.db(
        websites.first, books.first, chapters.first, js.first);
  }

  @override
  Future<bool> deleteConfigWebsite(String id) async {
    await _helper
        .deleteDB(ConfigWebsite.table, '${ConfigWebsite.cId} = ?', [id]);
    await _helper.deleteDB(Listbookhtml.table, '${Listbookhtml.cID} = ?', [id]);
    await _helper.deleteDB(Chapterhtml.table, '${Chapterhtml.cID} = ?', [id]);
    await _helper.deleteDB(Jsleak.table, '${Jsleak.cID} = ?', [id]);
    return true;
  }

  @override
  Future<bool> isRecordPresent(String table, String cId, String id) async {
    final data = await _helper.getDB(table, where: '$cId = ?', whereArgs: [id]);
    if (data.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<List<ConfigWebsite>> getAllConfigWebsite() async {
    try {
      List<ConfigWebsite> listConfig = [];
      final websites = await _helper.getDB(
        ConfigWebsite.table,
      );

      for (var element in websites) {
        String id = element[ConfigWebsite.cId];
        final books = await _helper.getDB(Listbookhtml.table,
            where: '${Listbookhtml.cID} = ?', whereArgs: [id]);
        final chapters = await _helper.getDB(Chapterhtml.table,
            where: '${Chapterhtml.cID} = ?', whereArgs: [id]);
        final js = await _helper
            .getDB(Jsleak.table, where: '${Jsleak.cID} = ?', whereArgs: [id]);
        if (books.isNotEmpty && chapters.isNotEmpty && js.isNotEmpty) {
          listConfig.add(
              ConfigWebsite.db(element, books.first, chapters.first, js.first));
        }
      }
      return listConfig;
    } catch (e) {
      debugPrint("[ERROR] [getAllConfigWebsite] [DatabaseRepository] $e");
      return [];
    }
  }

  @override
  Future<bool> deleteCatregory() async {
    await _helper.deleteDB(WebsiteTag.table, null, null);

    return true;
  }

  @override
  Future<List<WebsiteTag>> getAllCatregory() async {
    List<WebsiteTag> list = [];

    try {
      final jsons = await _helper.getDB(WebsiteTag.table);
      var json = jsonDecode(jsons.first['json']);
      for (var item in json['tags']) {
        list.add(WebsiteTag.json(item));
      }
      return list;
    } catch (e) {
      debugPrint("[ERROR] [getAllCatregory] $e");
    }

    return list;
  }

  @override
  Future<bool> insertCatregory(String json) async {
    await _helper.insertDB(WebsiteTag.table, {'json': json});

    return true;
  }

  @override
  Future<bool> deleteSearch(String id) async {
    await _helper.deleteDB(SearchName.table, null, null);
    await _helper.deleteDB(Fill.table, null, null);
    await _helper.deleteDB(NextPage.table, null, null);
    return true;
  }

  @override
  Future<bool> insertSearchName(SearchName configWebsite) async {
    await _helper.insertDB(SearchName.table, configWebsite.getMapInsertDB());
    if (configWebsite.nextPage != null) {
      await _helper.insertDB(NextPage.table,
          configWebsite.nextPage!.getMapInsertDB(configWebsite.id));
    }
    for (var item in configWebsite.fill) {
      await _helper.insertDB(Fill.table, item.getMapInsertDB(configWebsite.id));
    }

    return true;
  }

  @override
  Future<bool> insertSearchTag(SearchTag tag) async {
    await _helper.insertDB(SearchTag.table, tag.getMapInsertDB());
    if (tag.nextPage != null) {
      await _helper.insertDB(
          NextPage.table, tag.nextPage!.getMapInsertDB(tag.id));
    }
    for (var item in tag.fill) {
      await _helper.insertDB(Fill.table, item.getMapInsertDB(tag.id));
    }

    return true;
  }

  @override
  Future<List<SearchName>> getAllSearchName() async {
    List<SearchName> list = [];
    final dataSearch = await _helper.getDB(SearchName.table);
    for (var element in dataSearch) {
      String id = element[SearchName.cType] + "SearchName";
      final nextJs = await _helper
          .getDB(NextPage.table, where: '${Tag.cId} = ?', whereArgs: [id]);
      final fills = await _helper
          .getDB(Fill.table, where: '${Fill.cId} = ?', whereArgs: [id]);
      if (nextJs.isNotEmpty) {
        list.add(SearchName.db(element, nextJs.first, fills));
      } else {
        list.add(SearchName.db(element, null, fills));
      }
    }

    return list;
  }

  @override
  Future<List<SearchTag>> getAllSearchTag() async {
    List<SearchTag> list = [];
    final dataSearch = await _helper.getDB(SearchTag.table);
    for (var element in dataSearch) {
      String id = element[SearchTag.cType];
      final nextJs = await _helper
          .getDB(NextPage.table, where: '${Tag.cId} = ?', whereArgs: [id]);
      final fills = await _helper
          .getDB(Fill.table, where: '${Fill.cId} = ?', whereArgs: [id]);
      if (nextJs.isNotEmpty) {
        list.add(SearchTag.db(element, nextJs.first, fills));
      } else {
        list.add(SearchTag.db(element, null, fills));
      }
    }

    return list;
  }
}
