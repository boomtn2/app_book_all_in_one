import 'package:audio_youtube/app/data/model/config_website.dart';

import '../service/sqlite/sqlite_helper.dart';

abstract class DatabaseRepository {
  Future<bool> insertConfigWebsite(ConfigWebsite configWebsite);
  Future<ConfigWebsite?> getConfigWebsite(String id);
  Future<ConfigWebsite> deleteConfigWebsite(String id);
  Future<bool> isRecordPresent(String table, String cId, String id);
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
    await _helper.getDB(ConfigWebsite.table,
        where: '${ConfigWebsite.cId} = ?', whereArgs: [id]);
    await _helper.getDB(Listbookhtml.table,
        where: '${Listbookhtml.cID} = ?', whereArgs: [id]);
    await _helper.getDB(Chapterhtml.table,
        where: '${Chapterhtml.cID} = ?', whereArgs: [id]);
    await _helper
        .getDB(Jsleak.table, where: '${Jsleak.cID} = ?', whereArgs: [id]);
    return null;
  }

  @override
  Future<ConfigWebsite> deleteConfigWebsite(String id) {
    // TODO: implement deleteConfigWebsite
    throw UnimplementedError();
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
}
