import 'package:sqflite/sqflite.dart';

import '/app/utils/table_helper.dart';

import '/app/data/model/keyword/keyword_data.dart';

class KeywordsTable extends TableHelper {
  KeywordsTable(super.tableName);

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

  Future<void> keywordsInsert(List<KeywordData> data) async {
    Batch batch = database.batch();

    for (KeywordData keywordData in data) {
      batch.insert(
        tableName,
        keywordData.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<KeywordData>> keywordsSelect() async {
    List<Map<String, dynamic>> result = await database.query(tableName);

    return result.map((e) => KeywordData.fromJson(e)).toList();
  }

  Future<bool> keywordExists(String keywordKey) async {
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      where: 'keyword_key = ?',
      whereArgs: [keywordKey],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
