import 'package:sqflite/sqflite.dart';

import '/app/utils/table_helper.dart';

import '/app/data/model/keyword/keyword_info_data.dart';

class KeywordInfoTable extends TableHelper {
  KeywordInfoTable(super.tableName);

  @override
  Future<void> delete(Map<String, dynamic> data) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> select(Map<String, dynamic> data) async {
    return await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  @override
  Future<void> update(Map<String, dynamic> data) async {
    await database.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<int> keywordInfoInsert(KeywordInfoData data) async {
    await database.delete(tableName);

    return await database.insert(
      tableName,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<KeywordInfoData> keywordInfoSelectOne() async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      limit: 1,
    );

    if (maps.isEmpty) return KeywordInfoData();

    return KeywordInfoData.fromJson(maps.first);
  }

  Future<int> keywordInfoUpdateOne(
    KeywordInfoData keywordInfoData,
    int? id,
  ) async {
    final data = keywordInfoData.toJson();

    data.removeWhere((key, value) => value == null);

    return await database.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
