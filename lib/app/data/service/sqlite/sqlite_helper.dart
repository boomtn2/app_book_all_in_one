import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/model_db/download_model.dart';
import '../../model/model_db/favorite_model.dart';
import '../../model/model_db/history_model.dart';
import '../../model/models_export.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal() {
    initDb();
  }

  final String nameDB = 'databaselocal_tts_hit_v2.db';

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, nameDB);
    var myDb = await openDatabase(path, version: 1, onCreate: _onCreate);

    return myDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await _execute(
        'CREATE TABLE ${FavoriteModel.table}(${FavoriteModel.cId} TEXT PRIMARY KEY,${FavoriteModel.cName} TEXT ,${FavoriteModel.cImage} TEXT,${FavoriteModel.cType} TEXT,${FavoriteModel.cFavorite} INTEGER)',
        db);
    await _execute(
        'CREATE TABLE ${HistoryModel.table}(${HistoryModel.cId} TEXT PRIMARY KEY,${HistoryModel.cName} TEXT ,${HistoryModel.cImage} TEXT,${HistoryModel.cType} TEXT)',
        db);
    await _execute(
        'CREATE TABLE ${ChapterHistoryModel.table}(${ChapterHistoryModel.cId} TEXT,${ChapterHistoryModel.cName} TEXT ,${ChapterHistoryModel.cPath} TEXT,${ChapterHistoryModel.cType} TEXT)',
        db);
    await _execute(
        'CREATE TABLE ${DownloadModel.dbTable}(${DownloadModel.cID} TEXT PRIMARY KEY ,${DownloadModel.cName} TEXT,${DownloadModel.cImage} TEXT,${DownloadModel.cDetail} TEXT,${DownloadModel.cCategory} TEXT)',
        db);
    await _execute(
        'CREATE TABLE ${ItemDownload.dbTable}(${ItemDownload.cID} TEXT,${ItemDownload.cName} TEXT ,${ItemDownload.cPath} TEXT,${ItemDownload.cSTT} INTEGER,${ItemDownload.cText} TEXT,${ItemDownload.cType} TEXT )',
        db);

    await _execute(ConfigWebsite.querryCreateTable, db);
    await _execute(Listbookhtml.querryCreateTable, db);
    await _execute(Jsleak.querryCreateTable, db);
    await _execute(Chapterhtml.querryCreateTable, db);

    await _execute(ChannelModel.querryCreateTable, db);

    await _execute(SearchName.querryCreateTable, db);
    await _execute(SearchTag.querryCreateTable, db);
    await _execute(NextPage.querryCreateTable, db);
    await _execute(Fill.querryCreateTable, db);

    await _execute(WebsiteTag.querryCreateTable, db);
    await _execute(GroupTag.querryCreateTable, db);
    await _execute(Tag.querryCreateTable, db);
    await _execute(IDTag.querryCreateTable, db);
  }

  Future _execute(String query, Database db) async {
    await db.execute(query);
  }

  Future<int> insertDB(String tableName, Map<String, Object?> data) async {
    try {
      var dbClient = await db;
      int response = await dbClient!.insert(tableName, data);
      _showDebugCode(response, '_insertDB $tableName');
      return response;
    } catch (e) {
      return 0;
    }
  }

  Future<int> updateDB(String tableName, Map<String, Object?> data) async {
    try {
      var dbClient = await db;
      int response = await dbClient!.update(tableName, data);
      _showDebugCode(response, '_updateDB $tableName');
      return response;
    } catch (e) {
      return 0;
    }
  }

  void _showDebugCode(int code, String title) {
    debugPrint('[DEBUG] $code $title');
  }

  Future<int> deleteDB(
      String tableName, String? where, List<Object?>? args) async {
    try {
      var dbClient = await db;

      int response =
          await dbClient!.delete(tableName, where: where, whereArgs: args);
      _showDebugCode(response, '_deleteDB $tableName');
      return response;
    } catch (e) {
      return 0;
    }
  }

  void close() async {
    var dbClient = await db;
    await dbClient!.close();
  }

  Future<List<Map<String, dynamic>>> getDB(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      var dbClient = await db;
      final List<Map<String, dynamic>> dataList = await dbClient!.query(
        table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );

      return dataList;
    } finally {}
  }
}
